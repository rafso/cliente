<?php
/* Copyright (C) 2002-2005 Rodolphe Quiedeville <rodolphe@quiedeville.org>
 * Copyright (C) 2004-2011 Laurent Destailleur  <eldy@users.sourceforge.net>
 * Copyright (C) 2004      Christophe Combelles <ccomb@free.fr>
 * Copyright (C) 2005      Marc Barilley / Ocebo <marc@ocebo.fr>
 * Copyright (C) 2005-2011 Regis Houssin         <regis@dolibarr.fr>
 * Copyright (C) 2010-2011 Juanjo Menent		 <jmenent@2byte.es>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

/**
 *	\file       htdocs/fourn/facture/fiche.php
 *	\ingroup    facture, fournisseur
 *	\brief      Page for supplier invoice card (view, edit, validate)
 *	\version    $Id: fiche.php,v 1.263 2011/08/04 21:46:50 eldy Exp $
 */

require("../../main.inc.php");
require_once(DOL_DOCUMENT_ROOT."/core/class/html.formfile.class.php");
require_once(DOL_DOCUMENT_ROOT.'/fourn/class/fournisseur.class.php');
require_once(DOL_DOCUMENT_ROOT.'/includes/modules/supplier_invoice/modules_facturefournisseur.php');
require_once(DOL_DOCUMENT_ROOT.'/fourn/class/fournisseur.facture.class.php');
require_once(DOL_DOCUMENT_ROOT.'/fourn/class/paiementfourn.class.php');
require_once(DOL_DOCUMENT_ROOT.'/lib/fourn.lib.php');
require_once(DOL_DOCUMENT_ROOT.'/product/class/product.class.php');
if ($conf->projet->enabled) require_once(DOL_DOCUMENT_ROOT.'/projet/class/project.class.php');


$langs->load('bills');
$langs->load('suppliers');
$langs->load('companies');

$facid = GETPOST("facid");

// Security check
if ($user->societe_id) $socid=$user->societe_id;
$result = restrictedArea($user, 'fournisseur', $facid, 'facture_fourn', 'facture');

$html = new Form($db);
$mesg='';
$action=GETPOST("action");


/*
 * Actions
 */

// Action clone object
if ($_REQUEST["action"] == 'confirm_clone' && $_REQUEST['confirm'] == 'yes')
{
    if (1==0 && empty($_REQUEST["clone_content"]) && empty($_REQUEST["clone_receivers"]))
    {
        $mesg='<div class="error">'.$langs->trans("NoCloneOptionsSpecified").'</div>';
    }
    else
    {
        $object=new FactureFournisseur($db);
        $result=$object->createFromClone($_REQUEST['facid']);
        if ($result > 0)
        {
            header("Location: ".$_SERVER['PHP_SELF'].'?facid='.$result);
            exit;
        }
        else
        {
            $langs->load("errors");
            $mesg='<div class="error">'.$langs->trans($object->error).'</div>';
            $_GET['action']='';
            $_GET['id']=$_REQUEST['id'];
        }
    }
}

if ($_REQUEST['action'] == 'confirm_valid' && $_REQUEST['confirm'] == 'yes' && $user->rights->fournisseur->facture->valider)
{
    $facturefourn=new FactureFournisseur($db);
    $facturefourn->fetch($_GET['facid']);
    $result = $facturefourn->validate($user);
    if ($result < 0)
    {
        $mesg='<div class="error">'.$facturefourn->error.'</div>';
    }
}

if ($_REQUEST['action'] == 'confirm_delete' && $_REQUEST['confirm'] == 'yes')
{
    if ($user->rights->fournisseur->facture->supprimer )
    {
        $facturefourn = new FactureFournisseur($db);
        $factfournid = $_GET['facid'];
        $result=$facturefourn->delete($factfournid);
        if ($result > 0)
        {
            Header('Location: index.php');
            exit;
        }
        else
        {
            $mesg='<div class="error">'.$facturefourn->error.'</div>';
        }
    }
}

if ($_REQUEST['action'] == 'confirm_deleteproductline' && $_REQUEST['confirm'] == 'yes')
{
    if ($user->rights->fournisseur->facture->creer)
    {
        $facturefourn = new FactureFournisseur($db);
        $facturefourn->fetch($facid);
        $facturefourn->deleteline($_REQUEST['lineid']);
        $_GET['action'] = '';
    }
}

if ($_REQUEST['action'] == 'confirm_paid' && $_REQUEST['confirm'] == 'yes' && $user->rights->fournisseur->facture->creer)
{
    $facturefourn=new FactureFournisseur($db);
    $facturefourn->fetch($_GET['facid']);
    $result=$facturefourn->set_paid($user);
}

// Set supplier ref
if (($_POST['action'] == 'setref_supplier' || $_POST['action'] == 'set_ref_supplier') && $user->rights->fournisseur->facture->creer)
{
    $facturefourn = new FactureFournisseur($db);
    $facturefourn->fetch($facid);
    $result=$facturefourn->set_ref_supplier($user, $_POST['ref_supplier']);
    $_GET['facid']=$facid;
}

// Set supplier ref
if (($_POST['action'] == 'setlabel') && $user->rights->fournisseur->facture->creer)
{
    $facturefourn = new FactureFournisseur($db);
    $facturefourn->fetch($facid);
    $facturefourn->label=$_POST['label'];
    $result=$facturefourn->update($user);
    if ($result < 0) dol_print_error($db);
    $_GET['facid']=$facid;
}

if($_GET['action'] == 'deletepaiement')
{
    $facfou = new FactureFournisseur($db);
    $facfou->fetch($_GET['facid']);
    if ($facfou->statut == 1 && $facfou->paye == 0 && $user->societe_id == 0)
    {
        $paiementfourn = new PaiementFourn($db);
        $paiementfourn->fetch($_GET['paiement_id']);
        $paiementfourn->delete();
    }
}

if ($_POST['action'] == 'update' && ! $_POST['cancel'])
{
    $error=0;

    $date = dol_mktime(12, 0, 0, $_POST['remonth'], $_POST['reday'], $_POST['reyear']);
    $date_echeance = dol_mktime(12, 0, 0, $_POST['echmonth'], $_POST['echday'], $_POST['echyear']);

    if (! $date)
    {
        $msg=$langs->trans("ErrorFieldRequired",$langs->transnoentities("DateEch"));
        $error++;
    }
    if ($date_echeance && $date_echeance < $date)
    {
        $date_echeance = $date;
    }

    if (! $error)
    {
        $sql = 'UPDATE '.MAIN_DB_PREFIX.'facture_fourn set ';
        $sql .= " facnumber='".$db->escape(trim($_POST['facnumber']))."'";
        $sql .= ", libelle='".$db->escape(trim($_POST['libelle']))."'";
        $sql .= ", note='".$db->escape($_POST['note'])."'";
        $sql .= ", datef = '".$db->idate($date)."'";
        $sql .= ", date_lim_reglement = '".$db->idate($date_echeance)."'";
        $sql .= ' WHERE rowid = '.$_GET['facid'].' ;';
        $result = $db->query($sql);
    }
}
/*
 * Action creation
 */
if ($_POST['action'] == 'add' && $user->rights->fournisseur->facture->creer)
{
    $error=0;

    $datefacture=dol_mktime(12,0,0,$_POST['remonth'],$_POST['reday'],$_POST['reyear']);
    $datedue=dol_mktime(12,0,0,$_POST['echmonth'],$_POST['echday'],$_POST['echyear']);

    if ($datefacture == '')
    {
        $mesg='<div class="error">'.$langs->trans('ErrorFieldRequired',$langs->transnoentities('DateInvoice')).'</div>';
        $_GET['action']='create';
        $_GET['socid']=$_POST['socid'];
        $error++;
    }
    if (! GETPOST('facnumber'))
    {
        $mesg='<div class="error">'.$langs->trans('ErrorFieldRequired',$langs->transnoentities('RefSupplier')).'</div>';
        $_GET['action']='create';
        $_GET['socid']=$_POST['socid'];
        $error++;
    }

    if (! $error)
    {
        $db->begin();

        // Creation facture
        $facfou = new FactureFournisseur($db);

        $facfou->ref           = $_POST['facnumber'];
        $facfou->socid         = $_POST['socid'];
        $facfou->libelle       = $_POST['libelle'];
        $facfou->date          = $datefacture;
        $facfou->date_echeance = $datedue;
        $facfou->note_public   = $_POST['note'];

        // If creation from another object of another module
        if ($_POST['origin'] && $_POST['originid'])
        {
            // Parse element/subelement (ex: project_task)
            $element = $subelement = $_POST['origin'];
            /*if (preg_match('/^([^_]+)_([^_]+)/i',$_POST['origin'],$regs))
             {
            $element = $regs[1];
            $subelement = $regs[2];
            }*/

            // For compatibility
            if ($element == 'order')    { $element = $subelement = 'commande'; }
    		if ($element == 'propal')   { $element = 'comm/propal'; $subelement = 'propal'; }
    		if ($element == 'contract') { $element = $subelement = 'contrat'; }
    		if ($element == 'order_supplier') { $element = 'fourn'; $subelement = 'fournisseur.commande'; }

            $facfou->origin 	= $_POST['origin'];
            $facfou->origin_id = $_POST['originid'];

            $facid = $facfou->create($user);

            // Add lines
            if ($facid > 0)
            {
                require_once(DOL_DOCUMENT_ROOT.'/'.$element.'/class/'.$subelement.'.class.php');
                $classname = ucfirst($subelement);
                if ($classname == 'Fournisseur.commande') $classname='CommandeFournisseur';
                $srcobject = new $classname($db);

                $result=$srcobject->fetch($_POST['originid']);
                if ($result > 0)
                {
                    $lines = $srcobject->lines;
                    if (empty($lines) && method_exists($srcobject,'fetch_lines'))  $lines = $srcobject->fetch_lines();

                    for ($i = 0 ; $i < sizeof($lines) ; $i++)
                    {
                        $desc=($lines[$i]->desc?$lines[$i]->desc:$lines[$i]->libelle);
                        $product_type=($lines[$i]->product_type?$lines[$i]->product_type:0);

                        // Dates
                        // TODO mutualiser
                        $date_start=$lines[$i]->date_debut_prevue;
                        if ($lines[$i]->date_debut_reel) $date_start=$lines[$i]->date_debut_reel;
                        if ($lines[$i]->date_start) $date_start=$lines[$i]->date_start;
                        $date_end=$lines[$i]->date_fin_prevue;
                        if ($lines[$i]->date_fin_reel) $date_end=$lines[$i]->date_fin_reel;
                        if ($lines[$i]->date_end) $date_end=$lines[$i]->date_end;

                        $result = $facfou->addline(
                        $desc,
                        $lines[$i]->subprice,
                        $lines[$i]->tva_tx,
                        $lines[$i]->localtax1_tx,
                        $lines[$i]->localtax2_tx,
                        $lines[$i]->qty,
                        $lines[$i]->fk_product,
                        $lines[$i]->remise_percent,
                        $date_start,
                        $date_end,
                        0,
                        $lines[$i]->info_bits,
						'HT',
                        $product_type
                        );

                        if ($result < 0)
                        {
                            $error++;
                            break;
                        }
                    }
                }
                else
                {
                    $error++;
                }
            }
            else
            {
                $error++;
            }
        }
        // If some invoice's lines already known
        else
        {
            $facid = $facfou->create($user);
            if ($facid < 0)
            {
                $error++;
            }

            if (! $error)
            {
                for ($i = 1 ; $i < 9 ; $i++)
                {
                    $label = $_POST['label'.$i];
                    $amountht  = price2num($_POST['amount'.$i]);
                    $amountttc = price2num($_POST['amountttc'.$i]);
                    $tauxtva   = price2num($_POST['tauxtva'.$i]);
                    $qty = $_POST['qty'.$i];
                    $fk_product = $_POST['fk_product'.$i];
                    if ($label)
                    {
                        if ($amountht)
                        {
                            $price_base='HT'; $amount=$amountht;
                        }
                        else
                        {
                            $price_base='TTC'; $amount=$amountttc;
                        }
                        $atleastoneline=1;

                        $product=new Product($db);
                        $product->fetch($_POST['idprod'.$i]);

                        $ret=$facfou->addline($label, $amount, $tauxtva, $product->localtax1_tx, $product->localtax2_tx, $qty, $fk_product, $remise_percent, '', '', '', 0, $price_base);
                        if ($ret < 0) $error++;
                    }
                }
            }
        }

        if ($error)
        {
            $langs->load("errors");
            $db->rollback();
            $mesg='<div class="error">'.$langs->trans($facfou->error).'</div>';
            $_GET['action']='create';
            $_GET['socid']=$_POST['socid'];
        }
        else
        {
            $db->commit();
            header('Location: fiche.php?facid='.$facid);
            exit;
        }
    }
}

if ($_GET['action'] == 'del_ligne')
{
    $facfou = new FactureFournisseur($db,'',$_GET['facid']);
    $facfou->deleteline($_GET['lineid']);
    $_GET['action'] = 'edit';
}

// Modification d'une ligne
if ($_REQUEST['action'] == 'update_line')
{
    if ($_REQUEST['etat'] == '1' && ! $_REQUEST['cancel']) // si on valide la modification
    {
        $facfou = new FactureFournisseur($db);
        $facfou->fetch($_GET['facid']);

        if ($_POST['puht'])
        {
            $pu=$_POST['puht'];
            $price_base_type='HT';
        }
        if ($_POST['puttc'])
        {
            $pu=$_POST['puttc'];
            $price_base_type='TTC';
        }

        if ($_POST['idprod'])
        {
            $prod = new Product($db);
            $prod->fetch($_POST['idprod']);
            $label = $prod->description;
            if (trim($_POST['label']) != trim($label)) $label=$_POST['label'];

            $type = $prod->type;
            $localtax1tx = $prod->localtax1_tx;
            $localtax2tx = $prod->localtax2_tx;
        }
        else
        {
            if ($facfou->socid)
            {
                $societe=new Societe($db);
                $societe->fetch($facfou->socid);
            }
            $label = $_POST['label'];
            $type = $_POST["type"]?$_POST["type"]:0;
            $localtax1tx= get_localtax($_POST['tauxtva'], 1, $societe);
            $localtax2tx= get_localtax($_POST['tauxtva'], 2, $societe);
        }

        $result=$facfou->updateline($_GET['lineid'], $label, $pu, $_POST['tauxtva'], $localtax1tx, $localtax2tx, $_POST['qty'], $_POST['idprod'], $price_base_type, 0, $type);
        if ($result >= 0)
        {
            unset($_POST['label']);
        }
    }
}

if ($_GET['action'] == 'addline')
{
    $facfou = new FactureFournisseur($db, '', $_GET['facid']);
    $ret=$facfou->fetch($_GET['facid']);
    if ($ret < 0)
    {
        dol_print_error($db,$facfou->error);
        exit;
    }
    $ret=$facfou->fetch_thirdparty();

    if ($_POST['idprodfournprice'])	// > 0 or -1
    {
        $product = new ProductFournisseur($db);
        $idprod=$product->get_buyprice($_POST['idprodfournprice'], $_POST['qty']);
        if ($idprod > 0)
        {
            $result=$product->fetch($idprod);

            // cas special pour lequel on a les meme reference que le fournisseur
            // $label = '['.$product->ref.'] - '. $product->libelle;
            $label = $product->description;

            $tvatx=get_default_tva($facfou->thirdparty,$mysoc,$product->id);

            $localtax1tx= get_localtax($tvatx, 1, $mysoc);
            $localtax2tx= get_localtax($tvatx, 2, $mysoc);

            $type = $product->type;

            $result=$facfou->addline($label, $product->fourn_pu, $tvatx, $localtax1tx, $localtax2tx ,$_POST['qty'], $idprod);
        }
        if ($idprod == -1)
        {
            // Quantity too low
            $langs->load("errors");
            $mesg='<div class="error">'.$langs->trans("ErrorQtyTooLowForThisSupplier").'</div>';
        }
    }
    else
    {
        $tauxtva = price2num($_POST['tauxtva']);
        $localtax1tx= get_localtax($tauxtva, 1, $facfou->thirdparty);
        $localtax2tx= get_localtax($tauxtva, 2, $facfou->thirdparty);

        if (! $_POST['label'])
        {
            $mesg='<div class="error">'.$langs->trans("ErrorFieldRequired",$langs->transnoentities("Label")).'</div>';
        }
        else
        {
            $type = $_POST["type"];
            if (! empty($_POST['amount']))
            {
                $ht = price2num($_POST['amount']);
                $price_base_type = 'HT';

                //$desc, $pu, $txtva, $qty, $fk_product=0, $remise_percent=0, $date_start='', $date_end='', $ventil=0, $info_bits='', $price_base_type='HT', $type=0)
                $result=$facfou->addline($_POST['label'], $ht, $tauxtva, $localtax1tx, $localtax2tx, $_POST['qty'], 0, 0, $datestart, $dateend, 0, 0, $price_base_type, $type);
            }
            else
            {
                $ttc = price2num($_POST['amountttc']);
                $ht = $ttc / (1 + ($tauxtva / 100));
                $price_base_type = 'HT';
                $result=$facfou->addline($_POST['label'], $ht, $tauxtva,$localtax1tx, $localtax2tx, $_POST['qty'], 0, 0, $datestart, $dateend, 0, 0, $price_base_type, $type);
            }
        }
    }

    //print "xx".$tva_tx; exit;
    if ($result > 0)
    {
    	// Define output language
    	$outputlangs = $langs;
    	$newlang='';
    	if ($conf->global->MAIN_MULTILANGS && empty($newlang) && GETPOST('lang_id','int')) $newlang=GETPOST('lang_id','int');
    	if ($conf->global->MAIN_MULTILANGS && empty($newlang)) $newlang=$facfou->client->default_lang;
    	if (! empty($newlang))
    	{
    		$outputlangs = new Translate("",$conf);
    		$outputlangs->setDefaultLang($newlang);
    	}
        //supplier_invoice_pdf_create($db, $fac->id, $fac->modelpdf, $outputlangs);

        unset($_POST['qty']);
        unset($_POST['type']);
        unset($_POST['idprodfournprice']);
        unset($_POST['remmise_percent']);
        unset($_POST['dp_desc']);
        unset($_POST['np_desc']);
        unset($_POST['pu']);
        unset($_POST['tva_tx']);
        unset($_POST['label']);
        unset($localtax1_tx);
        unset($localtax2_tx);
    }
    else if (empty($mesg))
    {
        $mesg='<div class="error">'.$facfou->error.'</div>';
    }

    $_GET['action'] = '';
}

if ($_POST['action'] == 'classin')
{
    $facture = new FactureFournisseur($db,'',$_GET['facid']);
    $facture->fetch($_GET['facid']);
    $result=$facture->setProject($_POST['projectid']);
}


// Repasse la facture en mode brouillon
if ($_GET['action'] == 'edit' && $user->rights->fournisseur->facture->creer)
{
    $fac = new FactureFournisseur($db);
    $fac->fetch($_GET['facid']);

    // On verifie si la facture a des paiements
    $sql = 'SELECT pf.amount';
    $sql.= ' FROM '.MAIN_DB_PREFIX.'paiementfourn_facturefourn as pf';
    $sql.= ' WHERE pf.fk_facturefourn = '.$fac->id;

    $result = $db->query($sql);
    if ($result)
    {
        $i = 0;
        $num = $db->num_rows($result);

        while ($i < $num)
        {
            $objp = $db->fetch_object($result);
            $totalpaye += $objp->amount;
            $i++;
        }
    }

    $resteapayer = $fac->total_ttc - $totalpaye;

    // On verifie si les lignes de factures ont ete exportees en compta et/ou ventilees
    //$ventilExportCompta = $fac->getVentilExportCompta();

    // On verifie si aucun paiement n'a ete effectue
    if ($resteapayer == $fac->total_ttc	&& $fac->paye == 0 && $ventilExportCompta == 0)
    {
        $fac->set_draft($user);

        $outputlangs = $langs;
        if (! empty($_REQUEST['lang_id']))
        {
            $outputlangs = new Translate("",$conf);
            $outputlangs->setDefaultLang($_REQUEST['lang_id']);
        }
        //supplier_invoice_pdf_create($db, $fac->id, $fac->modelpdf, $outputlangs);
    }
}

if ($_GET['action'] == 'reopen' && $user->rights->fournisseur->facture->creer)
{
    $fac = new FactureFournisseur($db);
    $result = $fac->fetch($_GET['facid']);
    if ($fac->statut == 2
    || ($fac->statut == 3 && $fac->close_code != 'replaced'))
    {
        $result = $fac->set_unpaid($user);
        if ($result > 0)
        {
            Header('Location: '.$_SERVER["PHP_SELF"].'?facid='.$_GET['facid']);
            exit;
        }
        else
        {
            $mesg='<div class="error">'.$fac->error.'</div>';
        }
    }
}


/*********************************************************************
 *
 * Mail Actions
 *
 **********************************************************************/

/*
 * Add file in email form
*/
if ($_POST['addfile'])
{
    require_once(DOL_DOCUMENT_ROOT."/lib/files.lib.php");

    // Set tmp user directory TODO Use a dedicated directory for temp mails files
    $vardir=$conf->user->dir_output."/".$user->id;
    $upload_dir_tmp = $vardir.'/temp';

    $mesg=dol_add_file_process($upload_dir_tmp,0,0);

    $_GET["action"]='presend';
    $_POST["action"]='presend';
}

/*
 * Remove file in email form
*/
if (! empty($_POST['removedfile']))
{
    require_once(DOL_DOCUMENT_ROOT."/lib/files.lib.php");

    // Set tmp user directory
    $vardir=$conf->user->dir_output."/".$user->id;
    $upload_dir_tmp = $vardir.'/temp';

    $mesg=dol_remove_file_process($_POST['removedfile'],0);

    $_GET["action"]='presend';
    $_POST["action"]='presend';
}

/*
 * Send mail
*/
if ($_POST['action'] == 'send' && ! $_POST['addfile'] && ! $_POST['removedfile'] && ! $_POST['cancel'])
{
    $langs->load('mails');

    $facturefourn=new FactureFournisseur($db);
    $facturefourn->fetch($_GET['facid']);
    $result=$facturefourn->fetch_thirdparty();
    if ($result > 0)
    {
        $ref = dol_sanitizeFileName($facturefourn->ref);
        $file = $conf->fournisseur->facture->dir_output.'/'.get_exdir($facturefourn->id,2).$ref.'/'.$ref.'.pdf';

        if (is_readable($file))
        {
            if ($_POST['sendto'])
            {
                // Le destinataire a ete fourni via le champ libre
                $sendto = $_POST['sendto'];
                $sendtoid = 0;
            }
            elseif ($_POST['receiver'] != '-1')
            {
                // Recipient was provided from combo list
                if ($_POST['receiver'] == 'thirdparty') // Id of third party
                {
                    $sendto = $facturefourn->client->email;
                    $sendtoid = 0;
                }
                else	// Id du contact
                {
                    $sendto = $facturefourn->client->contact_get_property($_POST['receiver'],'email');
                    $sendtoid = $_POST['receiver'];
                }
            }

            if (dol_strlen($sendto))
            {
                $langs->load("commercial");

                $from = $_POST['fromname'] . ' <' . $_POST['frommail'] .'>';
                $replyto = $_POST['replytoname']. ' <' . $_POST['replytomail'].'>';
                $message = $_POST['message'];
                $sendtocc = $_POST['sendtocc'];
                $deliveryreceipt = $_POST['deliveryreceipt'];

                if ($_POST['action'] == 'send')
                {
                    if (dol_strlen($_POST['subject'])) $subject=$_POST['subject'];
                    else $subject = $langs->transnoentities('CustomerOrder').' '.$facturefourn->ref;
                    $actiontypecode='AC_SUP_ORD';
                    $actionmsg = $langs->transnoentities('MailSentBy').' '.$from.' '.$langs->transnoentities('To').' '.$sendto.".\n";
                    if ($message)
                    {
                        $actionmsg.=$langs->transnoentities('MailTopic').": ".$subject."\n";
                        $actionmsg.=$langs->transnoentities('TextUsedInTheMessageBody').":\n";
                        $actionmsg.=$message;
                    }
                    $actionmsg2=$langs->transnoentities('Action'.$actiontypecode);
                }

                // Create form object
                include_once(DOL_DOCUMENT_ROOT.'/core/class/html.formmail.class.php');
                $formmail = new FormMail($db);

                $attachedfiles=$formmail->get_attached_files();
                $filepath = $attachedfiles['paths'];
                $filename = $attachedfiles['names'];
                $mimetype = $attachedfiles['mimes'];

                // Send mail
                require_once(DOL_DOCUMENT_ROOT.'/lib/CMailFile.class.php');
                $mailfile = new CMailFile($subject,$sendto,$from,$message,$filepath,$mimetype,$filename,$sendtocc,'',$deliveryreceipt);
                if ($mailfile->error)
                {
                    $mesg='<div class="error">'.$mailfile->error.'</div>';
                }
                else
                {
                    $result=$mailfile->sendfile();
                    if ($result)
                    {
                        $mesg=$langs->trans('MailSuccessfulySent',$mailfile->getValidAddress($from,2),$mailfile->getValidAddress($sendto,2));		// Must not contain "

                        $error=0;

                        // Initialisation donnees
                        $facturefourn->sendtoid			= $sendtoid;
                        $facturefourn->actiontypecode	= $actiontypecode;
                        $facturefourn->actionmsg		= $actionmsg;
                        $facturefourn->actionmsg2		= $actionmsg2;
                        $facturefourn->fk_element		= $facturefourn->id;
                        $facturefourn->elementtype		= $facturefourn->element;

                        // Appel des triggers
                        include_once(DOL_DOCUMENT_ROOT . "/core/class/interfaces.class.php");
                        $interface=new Interfaces($db);
                        $result=$interface->run_triggers('BILL_SUPPLIER_SENTBYMAIL',$facturefourn,$user,$langs,$conf);
                        if ($result < 0) { $error++; $this->errors=$interface->errors; }
                        // Fin appel triggers

                        if ($error)
                        {
                            dol_print_error($db);
                        }
                        else
                        {
                            // Redirect here
                            // This avoid sending mail twice if going out and then back to page
                            Header('Location: '.$_SERVER["PHP_SELF"].'?facid='.$facturefourn->id.'&mesg='.urlencode($mesg));
                            exit;
                        }
                    }
                    else
                    {
                        $langs->load("other");
                        $mesg='<div class="error">';
                        if ($mailfile->error)
                        {
                            $mesg.=$langs->trans('ErrorFailedToSendMail',$from,$sendto);
                            $mesg.='<br>'.$mailfile->error;
                        }
                        else
                        {
                            $mesg.='No mail sent. Feature is disabled by option MAIN_DISABLE_ALL_MAILS';
                        }
                        $mesg.='</div>';
                    }
                }
            }

            else
            {
                $langs->load("other");
                $mesg='<div class="error">'.$langs->trans('ErrorMailRecipientIsEmpty').'</div>';
                dol_syslog('Recipient email is empty');
            }
        }
        else
        {
            $langs->load("other");
            $mesg='<div class="error">'.$langs->trans('ErrorCantReadFile',$file).'</div>';
            dol_syslog('Failed to read file: '.$file);
        }
    }
    else
    {
        $langs->load("other");
        $mesg='<div class="error">'.$langs->trans('ErrorFailedToReadEntity',$langs->trans("Invoice")).'</div>';
        dol_syslog('Unable to read data from the invoice. The invoice file has perhaps not been generated.');
    }

    //$_GET['action'] = 'presend';
}

/*
 * Build document
*/

if ($_REQUEST['action']	== 'builddoc')
{
    /*
     * Generation de la	facture
    * definit dans	/includes/modules/supplier_invoice/modules_facturefournisseur.php
    */

    // Save modele used
    $facture=new FactureFournisseur($db);
    $facture->fetch($_REQUEST['facid']);
    if ($_REQUEST['model'])
    {
        $facture->setDocModel($user, $_REQUEST['model']);
    }

    $outputlangs = $langs;
    if (! empty($_REQUEST['lang_id']))
    {
        $outputlangs = new Translate("",$conf);
        $outputlangs->setDefaultLang($_REQUEST['lang_id']);
    }
    $result=supplier_invoice_pdf_create($db, $facture,$facture->modelpdf,$outputlangs);
    if ($result	<= 0)
    {
        dol_print_error($db,$result);
        exit;
    }
    else
    {
        Header ('Location: '.$_SERVER["PHP_SELF"].'?facid='.$facture->id.(empty($conf->global->MAIN_JUMP_TAG)?'':'#builddoc'));
        exit;
    }
}

// Delete file in doc form
if ($action=='remove_file')
{
    require_once(DOL_DOCUMENT_ROOT."/lib/files.lib.php");
    $facture = new FactureFournisseur($db);

    if ($facture->fetch($id))
    {
        $upload_dir =	$conf->fournisseur->facture->dir_output . "/";
        $file =	$upload_dir	. '/' .	$_GET['file'];
        dol_delete_file($file);
        $mesg	= '<div	class="ok">'.$langs->trans("FileWasRemoved").'</div>';
    }
}


/*
 *	View
*/

llxHeader('','','');

$formfile = new FormFile($db);


// Mode creation
if ($_GET['action'] == 'create')
{
    print_fiche_titre($langs->trans('NewBill'));

    if ($mesg) { print $mesg.'<br>'; }

    $societe='';
    if ($_GET['socid'])
    {
        $societe=new Societe($db);
        $societe->fetch($_GET['socid']);
    }

    if (GETPOST('origin') && GETPOST('originid'))
    {
        // Parse element/subelement (ex: project_task)
        $element = $subelement = GETPOST('origin');

        if ($element == 'project')
        {
            $projectid=GETPOST('originid');
        }
        else if (in_array($element,array('order_supplier')))
        {
            // For compatibility
            if ($element == 'order')    { $element = $subelement = 'commande'; }
    		if ($element == 'propal')   { $element = 'comm/propal'; $subelement = 'propal'; }
    		if ($element == 'contract') { $element = $subelement = 'contrat'; }
    		if ($element == 'order_supplier') { $element = 'fourn'; $subelement = 'fournisseur.commande'; }

            require_once(DOL_DOCUMENT_ROOT.'/'.$element.'/class/'.$subelement.'.class.php');
            $classname = ucfirst($subelement);
            if ($classname == 'Fournisseur.commande') $classname='CommandeFournisseur';
            $objectsrc = new $classname($db);
            $objectsrc->fetch(GETPOST('originid'));
            $objectsrc->fetch_thirdparty();

            $projectid			= (!empty($objectsrc->fk_project)?$object->fk_project:'');
            //$ref_client			= (!empty($objectsrc->ref_client)?$object->ref_client:'');

            $soc = $objectsrc->client;
            $cond_reglement_id 	= (!empty($objectsrc->cond_reglement_id)?$objectsrc->cond_reglement_id:(!empty($soc->cond_reglement_id)?$soc->cond_reglement_id:1));
            $mode_reglement_id 	= (!empty($objectsrc->mode_reglement_id)?$objectsrc->mode_reglement_id:(!empty($soc->mode_reglement_id)?$soc->mode_reglement_id:0));
            $remise_percent 	= (!empty($objectsrc->remise_percent)?$objectsrc->remise_percent:(!empty($soc->remise_percent)?$soc->remise_percent:0));
            $remise_absolue 	= (!empty($objectsrc->remise_absolue)?$objectsrc->remise_absolue:(!empty($soc->remise_absolue)?$soc->remise_absolue:0));
            $dateinvoice		= empty($conf->global->MAIN_AUTOFILL_DATE)?-1:0;

            $datetmp=dol_mktime(12,0,0,$_POST['remonth'],$_POST['reday'],$_POST['reyear']);
            $dateinvoice=($datetmp==''?(empty($conf->global->MAIN_AUTOFILL_DATE)?-1:0):$datetmp);
            $datetmp=dol_mktime(12,0,0,$_POST['echmonth'],$_POST['echday'],$_POST['echyear']);
            $datedue=($datetmp==''?-1:$datetmp);
        }
    }
    else
    {
        $datetmp=dol_mktime(12,0,0,$_POST['remonth'],$_POST['reday'],$_POST['reyear']);
        $dateinvoice=($datetmp==''?(empty($conf->global->MAIN_AUTOFILL_DATE)?-1:0):$datetmp);
        $datetmp=dol_mktime(12,0,0,$_POST['echmonth'],$_POST['echday'],$_POST['echyear']);
        $datedue=($datetmp==''?-1:$datetmp);
    }

    print '<form name="add" action="'.$_SERVER["PHP_SELF"].'" method="post">';
    print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
    print '<input type="hidden" name="action" value="add">';
    print '<input type="hidden" name="origin" value="'.GETPOST('origin').'">';
    print '<input type="hidden" name="originid" value="'.GETPOST('originid').'">';
    print '<table class="border" width="100%">';

    // Ref
    print '<tr><td>'.$langs->trans('Ref').'</td><td>'.$langs->trans('Draft').'</td></tr>';

    // Third party
    print '<tr><td class="fieldrequired">'.$langs->trans('ThirdParty').'</td>';
    print '<td>';

    if ($_REQUEST['socid'] > 0)
    {
        print $societe->getNomUrl(1);
        print '<input type="hidden" name="socid" value="'.$_GET['socid'].'">';
    }
    else
    {
        $html->select_societes((empty($_GET['socid'])?'':$_GET['socid']),'socid','s.fournisseur = 1',1);
    }
    print '</td>';

    // Ref supplier
    print '<tr><td class="fieldrequired">'.$langs->trans('RefSupplier').'</td><td><input name="facnumber" value="'.(isset($_POST['facnumber'])?$_POST['facnumber']:$fac_ori->ref).'" type="text"></td>';
    print '</tr>';

    print '<tr><td valign="top" class="fieldrequired">'.$langs->trans('Type').'</td><td colspan="2">';
    print '<table class="nobordernopadding">'."\n";

    // Standard invoice
    print '<tr height="18"><td width="16px" valign="middle">';
    print '<input type="radio" name="type" value="0"'.($_POST['type']==0?' checked="true"':'').'>';
    print '</td><td valign="middle">';
    $desc=$html->textwithpicto($langs->trans("InvoiceStandardAsk"),$langs->transnoentities("InvoiceStandardDesc"),1);
    print $desc;
    print '</td></tr>'."\n";

    /*
     // Deposit
    print '<tr height="18"><td width="16px" valign="middle">';
    print '<input type="radio" name="type" value="3"'.($_POST['type']==3?' checked="true"':'').'>';
    print '</td><td valign="middle">';
    $desc=$html->textwithpicto($langs->trans("InvoiceDeposit"),$langs->transnoentities("InvoiceDepositDesc"),1);
    print $desc;
    print '</td></tr>'."\n";

    // Proforma
    if ($conf->global->FACTURE_USE_PROFORMAT)
    {
    print '<tr height="18"><td width="16px" valign="middle">';
    print '<input type="radio" name="type" value="4"'.($_POST['type']==4?' checked="true"':'').'>';
    print '</td><td valign="middle">';
    $desc=$html->textwithpicto($langs->trans("InvoiceProForma"),$langs->transnoentities("InvoiceProFormaDesc"),1);
    print $desc;
    print '</td></tr>'."\n";
    }

    // Replacement
    print '<tr height="18"><td valign="middle">';
    print '<input type="radio" name="type" value="1"'.($_POST['type']==1?' checked=true':'');
    if (! $options) print ' disabled="true"';
    print '>';
    print '</td><td valign="middle">';
    $text=$langs->trans("InvoiceReplacementAsk").' ';
    $text.='<select class="flat" name="fac_replacement"';
    if (! $options) $text.=' disabled="true"';
    $text.='>';
    if ($options)
    {
    $text.='<option value="-1">&nbsp;</option>';
    $text.=$options;
    }
    else
    {
    $text.='<option value="-1">'.$langs->trans("NoReplacableInvoice").'</option>';
    }
    $text.='</select>';
    $desc=$html->textwithpicto($text,$langs->transnoentities("InvoiceReplacementDesc"),1);
    print $desc;
    print '</td></tr>';

    // Credit note
    print '<tr height="18"><td valign="middle">';
    print '<input type="radio" name="type" value="2"'.($_POST['type']==2?' checked=true':'');
    if (! $optionsav) print ' disabled="true"';
    print '>';
    print '</td><td valign="middle">';
    $text=$langs->transnoentities("InvoiceAvoirAsk").' ';
    //	$text.='<input type="text" value="">';
    $text.='<select class="flat" name="fac_avoir"';
    if (! $optionsav) $text.=' disabled="true"';
    $text.='>';
    if ($optionsav)
    {
    $text.='<option value="-1">&nbsp;</option>';
    $text.=$optionsav;
    }
    else
    {
    $text.='<option value="-1">'.$langs->trans("NoInvoiceToCorrect").'</option>';
    }
    $text.='</select>';
    $desc=$html->textwithpicto($text,$langs->transnoentities("InvoiceAvoirDesc"),1);
    //.' ('.$langs->trans("FeatureNotYetAvailable").')',$langs->transnoentities("InvoiceAvoirDesc"),1);
    print $desc;
    print '</td></tr>'."\n";
    */
    print '</table>';
    print '</td></tr>';

    // Label
    print '<tr><td>'.$langs->trans('Label').'</td><td><input size="30" name="libelle" value="'.(isset($_POST['libelle'])?$_POST['libelle']:$fac_ori->libelle).'" type="text"></td></tr>';

    // Date invoice
    print '<tr><td class="fieldrequired">'.$langs->trans('DateInvoice').'</td><td>';
    $html->select_date($dateinvoice,'','','','',"add",1,1);
    print '</td></tr>';

    // Due date
    print '<tr><td>'.$langs->trans('DateEcheance').'</td><td>';
    $html->select_date($datedue,'ech','','','',"add",1,1);
    print '</td></tr>';

    print '<tr><td>'.$langs->trans('NotePublic').'</td>';
    print '<td><textarea name="note" wrap="soft" cols="60" rows="'.ROWS_5.'"></textarea></td>';
    print '</tr>';

    if (is_object($objectsrc))
    {
        print "\n<!-- ".$classname." info -->";
        print "\n";
        print '<input type="hidden" name="amount"         value="'.$objectsrc->total_ht.'">'."\n";
        print '<input type="hidden" name="total"          value="'.$objectsrc->total_ttc.'">'."\n";
        print '<input type="hidden" name="tva"            value="'.$objectsrc->total_tva.'">'."\n";
        print '<input type="hidden" name="origin"         value="'.$objectsrc->element.'">';
        print '<input type="hidden" name="originid"       value="'.$objectsrc->id.'">';

        $txt=$langs->trans($classname);
        if ($classname=='CommandeFournisseur') $txt=$langs->trans("SupplierOrder");
        print '<tr><td>'.$txt.'</td><td colspan="2">'.$objectsrc->getNomUrl(1).'</td></tr>';
        print '<tr><td>'.$langs->trans('TotalHT').'</td><td colspan="2">'.price($objectsrc->total_ht).'</td></tr>';
        print '<tr><td>'.$langs->trans('TotalVAT').'</td><td colspan="2">'.price($objectsrc->total_tva)."</td></tr>";
        if ($mysoc->pays_code=='ES')
        {
            if ($mysoc->localtax1_assuj=="1") //Localtax1 RE
            {
                print '<tr><td>'.$langs->transcountry("AmountLT1",$mysoc->pays_code).'</td><td colspan="2">'.price($objectsrc->total_localtax1)."</td></tr>";
            }

            if ($mysoc->localtax2_assuj=="1") //Localtax2 IRPF
            {
                print '<tr><td>'.$langs->transcountry("AmountLT2",$mysoc->pays_code).'</td><td colspan="2">'.price($objectsrc->total_localtax2)."</td></tr>";
            }
        }
        print '<tr><td>'.$langs->trans('TotalTTC').'</td><td colspan="2">'.price($objectsrc->total_ttc)."</td></tr>";
    }
    else
    {
        if ($conf->global->PRODUCT_SHOW_WHEN_CREATE)
        {
            print '<tr class="liste_titre">';
            print '<td>&nbsp;</td><td>'.$langs->trans('Label').'</td>';
            print '<td align="right">'.$langs->trans('PriceUHT').'</td>';
            print '<td align="right">'.$langs->trans('VAT').'</td>';
            print '<td align="right">'.$langs->trans('Qty').'</td>';
            print '<td align="right">'.$langs->trans('PriceUTTC').'</td>';
            print '</tr>';

            for ($i = 1 ; $i < 9 ; $i++)
            {
                $value_qty = '1';
                $value_tauxtva = '';
                print '<tr><td>'.$i.'</td>';
                print '<td><input size="50" name="label'.$i.'" value="'.$value_label.'" type="text"></td>';
                print '<td align="right"><input type="text" size="8" name="amount'.$i.'" value="'.$value_pu.'"></td>';
                print '<td align="right">';
                print $html->load_tva('tauxtva'.$i,$value_tauxtva,$societe,$mysoc);
                print '</td>';
                print '<td align="right"><input type="text" size="3" name="qty'.$i.'" value="'.$value_qty.'"></td>';
                print '<td align="right"><input type="text" size="8" name="amountttc'.$i.'" value=""></td></tr>';
            }
        }
    }
    // Bouton "Create Draft"
    print "</table>\n";

    print '<br><center><input type="submit" class="button" name="bouton" value="'.$langs->trans('CreateDraft').'"></center>';

    print "</form>\n";

    // Show origin lines
    if (is_object($objectsrc))
    {
        print '<br>';

        $title=$langs->trans('ProductsAndServices');
        print_titre($title);

        print '<table class="noborder" width="100%">';

        $objectsrc->printOriginLinesList($hookmanager);

        print '</table>';
    }
}
else
{
    if ($_GET['facid'] > 0)
    {
        /* *************************************************************************** */
        /*                                                                             */
        /* Fiche en mode visu ou edition                                               */
        /*                                                                             */
        /* *************************************************************************** */

        $now=dol_now();

        $productstatic = new Product($db);

        $fac = new FactureFournisseur($db);
        $fac->fetch($_GET['facid']);

        $societe = new Fournisseur($db);
        $societe->fetch($fac->socid);

        if ($_GET['action'] == 'edit')
        {
            print_fiche_titre($langs->trans('SupplierInvoice'));

            print '<form name="update" action="fiche.php?facid='.$fac->id.'" method="post">';
            print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
            print '<input type="hidden" name="action" value="update">';

            print '<table class="border" width="100%">';

            print '<tr><td class="fieldrequired">'.$langs->trans('Company').'</td>';
            print '<td>'.$societe->getNomUrl(1).'</td>';
            print '<td width="50%" valign="top">'.$langs->trans('NotePublic').'</td>';
            print '</tr>';

            // Ref
            print '<tr><td valign="top">'.$langs->trans('Ref').'</td><td valign="top">';
            print $fac->ref.'</td>';
            $rownb=10;
            print '<td rowspan="'.$rownb.'" valign="top">';
            print '<textarea name="note" wrap="soft" cols="60" rows="'.$rownb.'">';
            print $fac->note;
            print '</textarea></td></tr>';

            // Ref supplier
            print '<tr><td valign="top" class="fieldrequired">'.$langs->trans('RefSupplier').'</td><td valign="top">';
            print '<input name="facnumber" type="text" value="'.$fac->ref_supplier.'"></td>';
            print '</tr>';

            // Label
            print '<tr><td valign="top">'.$langs->trans('Label').'</td><td>';
            print '<input size="30" name="libelle" type="text" value="'.$fac->libelle.'"></td></tr>';

            // Date invoice
            print '<tr><td class="fieldrequired">'.$langs->trans('DateInvoice').'</td><td nowrap="nowrap">';
            $html->select_date($fac->datep,'','','','',"update",1,1);
            print '</td></tr>';

            // Due date
            print '<tr><td>'.$langs->trans('DateEcheance').'</td><td nowrap="nowrap">';
            $html->select_date($fac->date_echeance,'ech','','','',"update",1,1);
            if (($fac->paye == 0) && ($fac->statut > 0) && $fac->date_echeance < ($now - $conf->facture->fournisseur->warning_delay)) print img_picto($langs->trans("Late"),"warning");
            print '</td></tr>';

            print '<tr><td>'.$langs->trans('AmountHT').'</td><td nowrap="nowrap"><b>'.price($fac->total_ht).'</b></td></tr>';
            print '<tr><td>'.$langs->trans('AmountVAT').'</td><td nowrap="nowrap">'.price($fac->total_tva).'</td></tr>';
            print '<tr><td>'.$langs->trans('AmountTTC').'</td><td nowrap="nowrap">'.price($fac->total_ttc).'</td></tr>';

            print '<tr><td>'.$langs->trans('Status').'</td><td>'.$fac->getLibStatut(4).'</td></tr>';
            print '<tr><td colspan="2" align="center">';
            print '<input type="submit" class="button" name="save" value="'.$langs->trans('Save').'">';
            print ' &nbsp; &nbsp; ';
            print '<input type="submit" class="button" name="cancel" value="'.$langs->trans('Cancel').'">';

            print '</td></tr>';
            print '</table>';
            print '</form>';

            print '</table>';
        }
        else
        {
            /*
             *	View card
            */
            $head = facturefourn_prepare_head($fac);
            $titre=$langs->trans('SupplierInvoice');
            dol_fiche_head($head, 'card', $titre, 0, 'bill');

            if ($mesg) { print $mesg.'<br>'; }

            // Confirmation de la suppression d'une ligne produit
            if ($_GET['action'] == 'confirm_delete_line')
            {
                $ret=$html->form_confirm($_SERVER["PHP_SELF"].'?facid='.$fac->id.'&lineid='.$_GET["lineid"], $langs->trans('DeleteProductLine'), $langs->trans('ConfirmDeleteProductLine'), 'confirm_deleteproductline', '', 1, 1);
                if ($ret == 'html') print '<br>';
            }

            // Clone confirmation
            if ($_GET["action"] == 'clone')
            {
                // Create an array for form
                $formquestion=array(
                //'text' => $langs->trans("ConfirmClone"),
                //array('type' => 'checkbox', 'name' => 'clone_content',   'label' => $langs->trans("CloneMainAttributes"),   'value' => 1)
                );
                // Paiement incomplet. On demande si motif = escompte ou autre
                $ret=$html->form_confirm($_SERVER["PHP_SELF"].'?facid='.$fac->id,$langs->trans('CloneInvoice'),$langs->trans('ConfirmCloneInvoice',$fac->ref),'confirm_clone',$formquestion,'yes', 1);
                if ($ret == 'html') print '<br>';
            }

            // Confirmation de la validation
            if ($_GET['action'] == 'valid')
            {
                $ret=$html->form_confirm('fiche.php?facid='.$fac->id, $langs->trans('ValidateBill'), $langs->trans('ConfirmValidateBill', $fac->ref), 'confirm_valid', '', 0, 1);
                if ($ret == 'html') print '<br>';
            }

            // Confirmation set paid
            if ($_GET['action'] == 'paid')
            {
                $ret=$html->form_confirm('fiche.php?facid='.$fac->id, $langs->trans('ClassifyPaid'), $langs->trans('ConfirmClassifyPaidBill', $fac->ref), 'confirm_paid', '', 0, 1);
                if ($ret == 'html') print '<br>';
            }

            /*
             * Confirmation de la suppression de la facture fournisseur
            */
            if ($_GET['action'] == 'delete')
            {
                $ret=$html->form_confirm('fiche.php?facid='.$fac->id, $langs->trans('DeleteBill'), $langs->trans('ConfirmDeleteBill'), 'confirm_delete', '', 0, 1);
                if ($ret == 'html') print '<br>';
            }


            /*
             *   Facture
            */
            print '<table class="border" width="100%">';

            // Ref
            print '<tr><td nowrap="nowrap" width="20%">'.$langs->trans("Ref").'</td><td colspan="4">';
            print $html->showrefnav($fac,'facid','',1,'rowid','ref',$morehtmlref);
            print '</td>';
            print "</tr>\n";

            // Ref supplier
            print '<tr><td>'.$html->editfieldkey("RefSupplier",'ref_supplier',$fac->ref_supplier,'facid',$fac->id,($fac->statut<2 && $user->rights->fournisseur->facture->creer)).'</td><td colspan="4">';
            print $html->editfieldval("RefSupplier",'ref_supplier',$fac->ref_supplier,'facid',$fac->id,($fac->statut<2 && $user->rights->fournisseur->facture->creer));
            print '</td></tr>';

            // Third party
            print '<tr><td>'.$langs->trans('Supplier').'</td><td colspan="4">'.$societe->getNomUrl(1);
            print ' &nbsp; (<a href="'.DOL_URL_ROOT.'/fourn/facture/index.php?socid='.$fac->socid.'">'.$langs->trans('OtherBills').'</a>)</td>';
            print '</tr>';

            // Type
            print '<tr><td>'.$langs->trans('Type').'</td><td colspan="4">';
            print $fac->getLibType();
            if ($fac->type == 1)
            {
                $facreplaced=new FactureFournisseur($db);
                $facreplaced->fetch($fac->fk_facture_source);
                print ' ('.$langs->transnoentities("ReplaceInvoice",$facreplaced->getNomUrl(1)).')';
            }
            if ($fac->type == 2)
            {
                $facusing=new FactureFournisseur($db);
                $facusing->fetch($fac->fk_facture_source);
                print ' ('.$langs->transnoentities("CorrectInvoice",$facusing->getNomUrl(1)).')';
            }

            $facidavoir=$fac->getListIdAvoirFromInvoice();
            if (sizeof($facidavoir) > 0)
            {
                print ' ('.$langs->transnoentities("InvoiceHasAvoir");
                $i=0;
                foreach($facidavoir as $id)
                {
                    if ($i==0) print ' ';
                    else print ',';
                    $facavoir=new FactureFournisseur($db);
                    $facavoir->fetch($id);
                    print $facavoir->getNomUrl(1);
                }
                print ')';
            }
            if ($facidnext > 0)
            {
                $facthatreplace=new FactureFournisseur($db);
                $facthatreplace->fetch($facidnext);
                print ' ('.$langs->transnoentities("ReplacedByInvoice",$facthatreplace->getNomUrl(1)).')';
            }
            print '</td></tr>';


            // Label
            print '<tr><td>'.$html->editfieldkey("Label",'label',$fac->label,'facid',$fac->id,($fac->statut<2 && $user->rights->fournisseur->facture->creer)).'</td><td colspan="3">';
            print $html->editfieldval("Label",'label',$fac->label,'facid',$fac->id,($fac->statut<2 && $user->rights->fournisseur->facture->creer));
            print '</td>';

            /*
             * List of payments
            */
            $nbrows=7;
            if ($conf->projet->enabled) $nbrows++;

            // Local taxes
            if ($mysoc->pays_code=='ES')
            {
                if($mysoc->localtax1_assuj=="1") $nbrow++;
                if($mysoc->localtax2_assuj=="1") $nbrow++;
            }

            print '<td rowspan="'.$nbrows.'" valign="top">';
            $sql  = 'SELECT datep as dp, pf.amount,';
            $sql .= ' c.libelle as paiement_type, p.num_paiement, p.rowid';
            $sql .= ' FROM '.MAIN_DB_PREFIX.'paiementfourn as p';
            $sql .= ' LEFT JOIN '.MAIN_DB_PREFIX.'c_paiement as c ON p.fk_paiement = c.id';
            $sql .= ' LEFT JOIN '.MAIN_DB_PREFIX.'paiementfourn_facturefourn as pf ON pf.fk_paiementfourn = p.rowid';
            $sql .= ' WHERE pf.fk_facturefourn = '.$fac->id;
            $sql .= ' ORDER BY dp DESC';

            $result = $db->query($sql);
            if ($result)
            {
                $num = $db->num_rows($result);
                $i = 0; $totalpaye = 0;
                print '<table class="nobordernopadding" width="100%">';
                print '<tr class="liste_titre">';
                print '<td>'.$langs->trans('Payments').'</td>';
                print '<td>'.$langs->trans('Type').'</td>';

                if ($fac->statut == 1 && $fac->paye == 0 && $user->societe_id == 0)
                {
                    $tdsup=' colspan="2"';
                }
                print '<td align="right">'.$langs->trans('AmountTTC').'</td><td'.$tdsup.'>&nbsp;</td></tr>';

                $var=True;
                while ($i < $num)
                {
                    $objp = $db->fetch_object($result);
                    $var=!$var;
                    print '<tr '.$bc[$var].'>';
                    print '<td nowrap><a href="'.DOL_URL_ROOT.'/fourn/paiement/fiche.php?id='.$objp->rowid.'">'.img_object($langs->trans('ShowPayment'),'payment').' '.dol_print_date($db->jdate($objp->dp),'day')."</a></td>\n";
                    print '<td>'.$objp->paiement_type.' '.$objp->num_paiement.'</td>';
                    print '<td align="right">'.price($objp->amount).'</td><td>&nbsp;'.$langs->trans('Currency'.$conf->monnaie).'</td>';

                    if ($fac->statut == 1 && $fac->paye == 0 && $user->societe_id == 0)
                    {
                        print '<td align="center">';
                        print '<a href="fiche.php?facid='.$fac->id.'&amp;action=deletepaiement&amp;paiement_id='.$objp->rowid.'">';
                        print img_delete();
                        print '</a></td>';
                    }

                    print '</tr>';
                    $totalpaye += $objp->amount;
                    $i++;
                }

                if ($fac->paye == 0)
                {
                    print '<tr><td colspan="2" align="right">'.$langs->trans('AlreadyPaid').' :</td><td align="right"><b>'.price($totalpaye).'</b></td><td>&nbsp;'.$langs->trans('Currency'.$conf->monnaie).'</td></tr>';
                    print '<tr><td colspan="2" align="right">'.$langs->trans("Billed").' :</td><td align="right" style="border: 1px solid;">'.price($fac->total_ttc).'</td><td>&nbsp;'.$langs->trans('Currency'.$conf->monnaie).'</td></tr>';

                    $resteapayer = $fac->total_ttc - $totalpaye;

                    print '<tr><td colspan="2" align="right">'.$langs->trans('RemainderToPay').' :</td>';
                    print '<td align="right" style="border: 1px solid;" bgcolor="#f0f0f0"><b>'.price($resteapayer).'</b></td><td>&nbsp;'.$langs->trans('Currency'.$conf->monnaie).'</td></tr>';
                }
                print '</table>';
                $db->free($result);
            }
            else
            {
                dol_print_error($db);
            }
            print '</td>';


            print '</tr>';

            // Date
            print '<tr><td>'.$langs->trans('Date').'</td><td colspan="3" nowrap="nowrap">';
            print dol_print_date($fac->datep,'daytext').'</td></tr>';

            // Due date
            print '<tr>';
            print '<td>'.$langs->trans('DateEcheance').'</td><td colspan="3">';
            print dol_print_date($fac->date_echeance,'daytext');
            if (($fac->paye == 0) && ($fac->statut > 0) && $fac->date_echeance && $fac->date_echeance < ($now - $conf->facture->fournisseur->warning_delay)) print img_picto($langs->trans("Late"),"warning");
            print '</td></tr>';

            // Status
            $alreadypaid=$fac->getSommePaiement();
            print '<tr><td>'.$langs->trans('Status').'</td><td colspan="3">'.$fac->getLibStatut(4,$alreadypaid).'</td></tr>';

            print '<tr><td>'.$langs->trans('AmountHT').'</td><td align="right">'.price($fac->total_ht).'</td><td colspan="2" align="left">'.$langs->trans('Currency'.$conf->monnaie).'</td></tr>';
            print '<tr><td>'.$langs->trans('AmountVAT').'</td><td align="right">'.price($fac->total_tva).'</td><td colspan="2" align="left">'.$langs->trans('Currency'.$conf->monnaie).'</td></tr>';

            // Amount Local Taxes
            if ($mysoc->pays_code=='ES')
            {
                if ($mysoc->localtax1_assuj=="1") //Localtax1 RE
                {
                    print '<tr><td>'.$langs->transcountry("AmountLT1",$mysoc->pays_code).'</td>';
                    print '<td align="right">'.price($fac->total_localtax1).'</td>';
                    print '<td>'.$langs->trans("Currency".$conf->monnaie).'</td></tr>';
                }
                if ($mysoc->localtax2_assuj=="1") //Localtax2 IRPF
                {
                    print '<tr><td>'.$langs->transcountry("AmountLT2",$mysoc->pays_code).'</td>';
                    print '<td align="right">'.price($fac->total_localtax2).'</td>';
                    print '<td>'.$langs->trans("Currency".$conf->monnaie).'</td></tr>';
                }
            }
            print '<tr><td>'.$langs->trans('AmountTTC').'</td><td align="right">'.price($fac->total_ttc).'</td><td colspan="2" align="left">'.$langs->trans('Currency'.$conf->monnaie).'</td></tr>';

            // Project
            if ($conf->projet->enabled)
            {
                $langs->load('projects');
                print '<tr>';
                print '<td>';

                print '<table class="nobordernopadding" width="100%"><tr><td>';
                print $langs->trans('Project');
                print '</td>';
                if ($_GET['action'] != 'classer')
                {
                    print '<td align="right"><a href="'.$_SERVER["PHP_SELF"].'?action=classer&amp;facid='.$fac->id.'">';
                    print img_edit($langs->trans('SetProject'),1);
                    print '</a></td>';
                }
                print '</tr></table>';

                print '</td><td colspan="3">';
                if ($_GET['action'] == 'classer')
                {
                    $html->form_project($_SERVER['PHP_SELF'].'?facid='.$fac->id,$fac->socid,$fac->fk_project,'projectid');
                }
                else
                {
                    $html->form_project($_SERVER['PHP_SELF'].'?facid='.$fac->id,$fac->socid,$fac->fk_project,'none');
                }
                print '</td>';
                print '</tr>';
            }

            print '</table>';


            /*
             * Lines
            */
            print '<br>';
            print '<table class="noborder" width="100%">';
            $var=1;
            for ($i = 0 ; $i < sizeof($fac->lines) ; $i++)
            {
                if ($i == 0)
                {
                    print '<tr class="liste_titre"><td>'.$langs->trans('Label').'</td>';
                    print '<td align="right">'.$langs->trans('VAT').'</td>';
                    print '<td align="right">'.$langs->trans('PriceUHT').'</td>';
                    print '<td align="right">'.$langs->trans('PriceUTTC').'</td>';
                    print '<td align="right">'.$langs->trans('Qty').'</td>';
                    print '<td align="right">'.$langs->trans('TotalHTShort').'</td>';
                    print '<td align="right">'.$langs->trans('TotalTTCShort').'</td>';
                    print '<td>&nbsp;</td>';
                    print '<td>&nbsp;</td>';
                    print '</tr>';
                }

                // Show product and description
                $type=$fac->lines[$i]->product_type?$fac->lines[$i]->product_type:$fac->lines[$i]->fk_product_type;
                // Try to enhance type detection using date_start and date_end for free lines where type
                // was not saved.
                if (! empty($fac->lines[$i]->date_start)) $type=1;
                if (! empty($fac->lines[$i]->date_end)) $type=1;

                $var=!$var;

                // Edit line
                if ($fac->statut == 0 && $_GET['action'] == 'mod_ligne' && $_GET['etat'] == '0' && $_GET['lineid'] == $fac->lines[$i]->rowid)
                {
                    print '<form action="'.$_SERVER["PHP_SELF"].'?facid='.$fac->id.'&amp;etat=1&amp;lineid='.$fac->lines[$i]->rowid.'" method="post">';
                    print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
                    print '<input type="hidden" name="action" value="update_line">';
                    print '<tr '.$bc[$var].'>';

                    // Show product and description
                    print '<td>';
                    if (($conf->product->enabled || $conf->service->enabled) && $fac->lines[$i]->fk_product)
                    {
                        print '<input type="hidden" name="idprod" value="'.$fac->lines[$i]->fk_product.'">';
                        $product_static=new ProductFournisseur($db);
                        $product_static->fetch($fac->lines[$i]->fk_product);
                        $text=$product_static->getNomUrl(1);
                        $text.= ' - '.$product_static->libelle;
                        print $text;
                        print '<br>';
                    }
                    else
                    {
                        print $html->select_type_of_lines($fac->lines[$i]->product_type,'type',1);
                        if ($conf->product->enabled && $conf->service->enabled) print '<br>';
                    }

                    // Description - Editor wysiwyg
                    require_once(DOL_DOCUMENT_ROOT."/lib/doleditor.class.php");
                    $nbrows=ROWS_2;
                    if (! empty($conf->global->MAIN_INPUT_DESC_HEIGHT)) $nbrows=$conf->global->MAIN_INPUT_DESC_HEIGHT;
                    $doleditor=new DolEditor('label',$fac->lines[$i]->description,'',128,'dolibarr_details','',false,true,$conf->fckeditor->enabled && $conf->global->FCKEDITOR_ENABLE_DETAILS,$nbrows,70);
                    $doleditor->Create();
                    print '</td>';

                    // VAT
                    print '<td align="right">';
                    print $html->load_tva('tauxtva',$fac->lines[$i]->tva_tx,$societe,$mysoc);
                    print '</td>';

                    // Unit price
                    print '<td align="right" nowrap="nowrap"><input size="4" name="puht" type="text" value="'.price($fac->lines[$i]->pu_ht).'"></td>';

                    print '<td align="right" nowrap="nowrap"><input size="4" name="puttc" type="text" value=""></td>';

                    print '<td align="right"><input size="1" name="qty" type="text" value="'.$fac->lines[$i]->qty.'"></td>';

                    print '<td align="right" nowrap="nowrap">&nbsp;</td>';

                    print '<td align="right" nowrap="nowrap">&nbsp;</td>';

                    print '<td align="center" colspan="2"><input type="submit" class="button" value="'.$langs->trans('Save').'">';
                    print '<br><input type="submit" class="button" name="cancel" value="'.$langs->trans('Cancel').'"></td>';

                    print '</tr>';
                    print '</form>';
                }
                else // Affichage simple de la ligne
                {
                    print '<tr '.$bc[$var].'>';

                    // Show product and description
                    print '<td>';
                    if ($fac->lines[$i]->fk_product)
                    {
                        print '<a name="'.$objp->rowid.'"></a>'; // ancre pour retourner sur la ligne

                        $product_static=new ProductFournisseur($db);
                        $product_static->fetch($fac->lines[$i]->fk_product);
                        $text=$product_static->getNomUrl(1);
                        $text.= ' - '.$product_static->libelle;
                        $description=($conf->global->PRODUIT_DESC_IN_FORM?'':dol_htmlentitiesbr($fac->lines[$i]->description));
                        print $html->textwithtooltip($text,$description,3,'','',$i);

                        // Show range
                        print_date_range($fac->lines[$i]->date_start,$fac->lines[$i]->date_end);

                        // Add description in form
                        if ($conf->global->PRODUIT_DESC_IN_FORM) print ($fac->lines[$i]->description && $fac->lines[$i]->description!=$product_static->libelle)?'<br>'.dol_htmlentitiesbr($fac->lines[$i]->description):'';
                    }

                    // Description - Editor wysiwyg
                    if (! $fac->lines[$i]->fk_product)
                    {
                        if ($type==1) $text = img_object($langs->trans('Service'),'service');
                        else $text = img_object($langs->trans('Product'),'product');
                        print $text.' '.nl2br($fac->lines[$i]->description);

                        // Show range
                        print_date_range($fac->lines[$i]->date_start,$fac->lines[$i]->date_end);
                    }
                    print '</td>';

                    // VAT
                    print '<td align="right">'.vatrate($fac->lines[$i]->tva_tx).'%</td>';

                    // Unit price
                    print '<td align="right" nowrap="nowrap">'.price($fac->lines[$i]->pu_ht,'MU').'</td>';

                    print '<td align="right" nowrap="nowrap">'.($fac->lines[$i]->pu_ttc?price($fac->lines[$i]->pu_ttc,'MU'):'&nbsp;').'</td>';

                    print '<td align="right">'.$fac->lines[$i]->qty.'</td>';

                    print '<td align="right" nowrap="nowrap">'.price($fac->lines[$i]->total_ht).'</td>';

                    print '<td align="right" nowrap="nowrap">'.price($fac->lines[$i]->total_ttc).'</td>';

                    print '<td align="center" width="16">';
                    if ($fac->statut == 0) print '<a href="fiche.php?facid='.$fac->id.'&amp;action=mod_ligne&amp;etat=0&amp;lineid='.$fac->lines[$i]->rowid.'">'.img_edit().'</a>';
                    else print '&nbsp;';
                    print '</td>';

                    print '<td align="center" width="16">';
                    if ($fac->statut == 0) print '<a href="fiche.php?facid='.$fac->id.'&amp;action=confirm_delete_line&amp;lineid='.$fac->lines[$i]->rowid.'">'.img_delete().'</a>';
                    else print '&nbsp;';
                    print '</td>';

                    print '</tr>';
                }

            }

            /*
             * Form to add new line
            */

            if ($fac->statut == 0 && $_GET['action'] != 'mod_ligne')
            {
                print '<tr class="liste_titre">';
                print '<td>';
                print '<a name="add"></a>'; // ancre
                print $langs->trans('AddNewLine').' - '.$langs->trans("FreeZone").'</td>';
                print '<td align="right">'.$langs->trans('VAT').'</td>';
                print '<td align="right">'.$langs->trans('PriceUHT').'</td>';
                print '<td align="right">'.$langs->trans('PriceUTTC').'</td>';
                print '<td align="right">'.$langs->trans('Qty').'</td>';
                print '<td align="right">&nbsp;</td>';
                print '<td align="right">&nbsp;</td>';
                print '<td>&nbsp;</td>';
                print '<td>&nbsp;</td>';
                print '</tr>';

                // Add free products/services form
                print '<form action="fiche.php?facid='.$fac->id.'&amp;action=addline" method="post">';
                print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
                print '<input type="hidden" name="facid" value="'.$fac->id.'">';
                print '<input type="hidden" name="socid" value="'.$societe->id.'">';

                $var=true;
                print '<tr '.$bc[$var].'>';
                print '<td>';

                $forceall=1;	// For suppliers, we always show all types
                print $html->select_type_of_lines(isset($_POST["type"])?$_POST["type"]:-1,'type',1,0,$forceall);
                if ($forceall || ($conf->product->enabled && $conf->service->enabled)
                || (empty($conf->product->enabled) && empty($conf->service->enabled))) print '<br>';

                // Editor wysiwyg
                require_once(DOL_DOCUMENT_ROOT."/lib/doleditor.class.php");
                $nbrows=ROWS_2;
                if (! empty($conf->global->MAIN_INPUT_DESC_HEIGHT)) $nbrows=$conf->global->MAIN_INPUT_DESC_HEIGHT;
                $doleditor=new DolEditor('label',GETPOST("label"),'',100,'dolibarr_details','',false,true,$conf->fckeditor->enabled && $conf->global->FCKEDITOR_ENABLE_DETAILS,$nbrows,70);
                $doleditor->Create();

                print '</td>';
                print '<td align="right">';
                print $html->load_tva('tauxtva',($_POST["tauxtva"]?$_POST["tauxtva"]:-1),$societe,$mysoc);
                print '</td>';
                print '<td align="right">';
                print '<input size="4" name="amount" type="text">';
                print '</td>';
                print '<td align="right">';
                print '<input size="4" name="amountttc" type="text">';
                print '</td>';
                print '<td align="right">';
                print '<input size="1" name="qty" type="text" value="1">';
                print '</td>';
                print '<td align="right">&nbsp;</td>';
                print '<td align="center">&nbsp;</td>';
                print '<td align="center" valign="middle" colspan="2"><input type="submit" class="button" value="'.$langs->trans('Add').'"></td></tr>';
                print '</form>';

                // Ajout de produits/services predefinis
                if ($conf->product->enabled || $conf->service->enabled)
                {
                    print '<tr class="liste_titre">';
                    print '<td colspan="4">';
                    print $langs->trans("AddNewLine").' - ';
                    if ($conf->service->enabled)
                    {
                        print $langs->trans('RecordedProductsAndServices');
                    }
                    else
                    {
                        print $langs->trans('RecordedProducts');
                    }
                    print '</td>';
                    print '<td align="right">'.$langs->trans('Qty').'</td>';
                    print '<td align="right">&nbsp;</td>';
                    print '<td colspan="4">&nbsp;</td>';
                    print '</tr>';

                    print '<form name="addline_predef" action="fiche.php?facid='.$fac->id.'&amp;action=addline" method="post">';
                    print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
                    print '<input type="hidden" name="socid" value="'. $fac->socid .'">';
                    print '<input type="hidden" name="facid" value="'.$fac->id.'">';
                    print '<input type="hidden" name="socid" value="'.$fac->socid.'">';
                    $var=! $var;
                    print '<tr '.$bc[$var].'>';
                    print '<td colspan="4">';
                    $html->select_produits_fournisseurs($fac->socid,'','idprodfournprice','',$filtre);
                    print '</td>';
                    print '<td align="right"><input type="text" name="qty" value="1" size="1"></td>';
                    print '<td>&nbsp;</td>';
                    print '<td>&nbsp;</td>';
                    print '<td align="center" valign="middle" colspan="2"><input type="submit" class="button" value="'.$langs->trans("Add").'"></td>';
                    print '</tr>';
                    print '</form>';
                }
            }

            print '</table>';

            print '</div>';
        }

        if ($_GET['action'] != 'presend')
        {

            /*
             * Boutons actions
            */

            print '<div class="tabsAction">';

            // Reopen a standard paid invoice
            if (($fac->type == 0 || $fac->type == 1) && ($fac->statut == 2 || $fac->statut == 3))				// A paid invoice (partially or completely)
            {
                if (! $facidnext && $fac->close_code != 'replaced')	// Not replaced by another invoice
                {
                    print '<a class="butAction" href="'.$_SERVER['PHP_SELF'].'?facid='.$fac->id.'&amp;action=reopen">'.$langs->trans('ReOpen').'</a>';
                }
                else
                {
                    print '<span class="butActionRefused" title="'.$langs->trans("DisabledBecauseReplacedInvoice").'">'.$langs->trans('ReOpen').'</span>';
                }
            }

            //Modify
            if ($_GET['action'] != 'edit' && $fac->statut <= 1 && $fac->getSommePaiement() <= 0 && $user->rights->fournisseur->facture->creer)
            {
                print '<a class="butAction" href="fiche.php?facid='.$fac->id.'&amp;action=edit">'.$langs->trans('Modify').'</a>';
            }

            // Send by mail
            if (($fac->statut == 1 || $fac->statut == 2))
            {
                if (empty($conf->global->MAIN_USE_ADVANCED_PERMS) || $user->rights->fournisseur->supplier_invoice_advance->send)
                {
                    print '<a class="butAction" href="'.$_SERVER['PHP_SELF'].'?facid='.$fac->id.'&amp;action=presend&amp;mode=init">'.$langs->trans('SendByMail').'</a>';
                }
                else print '<a class="butActionRefused" href="#">'.$langs->trans('SendByMail').'</a>';
            }


            //Make payments
            if ($_GET['action'] != 'edit' && $fac->statut == 1 && $fac->paye == 0  && $user->societe_id == 0)
            {
                print '<a class="butAction" href="paiement.php?facid='.$fac->id.'&amp;action=create">'.$langs->trans('DoPayment').'</a>';
            }

            //Classify paid
            if ($_GET['action'] != 'edit' && $fac->statut == 1 && $fac->paye == 0  && $user->societe_id == 0)
            {
                print '<a class="butAction" href="'.$_SERVER["PHP_SELF"].'?facid='.$fac->id.'&amp;action=paid"';
                print '>'.$langs->trans('ClassifyPaid').'</a>';

                //print '<a class="butAction" href="fiche.php?facid='.$fac->id.'&amp;action=paid">'.$langs->trans('ClassifyPaid').'</a>';
            }

            //Validate
            if ($_GET['action'] != 'edit' && $fac->statut == 0)
            {
                if (sizeof($fac->lines))
                {
                    if ($user->rights->fournisseur->facture->valider)
                    {
                        print '<a class="butAction" href="'.$_SERVER["PHP_SELF"].'?facid='.$fac->id.'&amp;action=valid"';
                        print '>'.$langs->trans('Validate').'</a>';
                    }
                    else
                    {
                        print '<a class="butActionRefused" href="#" title="'.dol_escape_htmltag($langs->trans("NotAllowed")).'"';
                        print '>'.$langs->trans('Validate').'</a>';
                    }
                }
            }

            //Clone
            if ($_GET['action'] != 'edit' && $user->rights->fournisseur->facture->creer)
            {
                print '<a class="butAction" href="fiche.php?facid='.$fac->id.'&amp;action=clone&amp;socid='.$fac->socid.'">'.$langs->trans('ToClone').'</a>';
            }

            //Delete
            if ($_GET['action'] != 'edit' && $user->rights->fournisseur->facture->supprimer)
            {
                print '<a class="butActionDelete" href="fiche.php?facid='.$fac->id.'&amp;action=delete">'.$langs->trans('Delete').'</a>';
            }
            print '</div>';

            if ($_GET['action'] != 'edit')
            {
                print '<table width="100%"><tr><td width="50%" valign="top">';
                print '<a name="builddoc"></a>'; // ancre

                /*
                 * Documents generes
                */

                $ref=dol_sanitizeFileName($fac->ref);
                $subdir = get_exdir($fac->id,2).$ref;
                $filedir = $conf->fournisseur->facture->dir_output.'/'.get_exdir($fac->id,2).$ref;
                $urlsource=$_SERVER['PHP_SELF'].'?facid='.$fac->id;
                $genallowed=$user->rights->fournisseur->facture->creer;
                $delallowed=$user->rights->fournisseur->facture->supprimer;

                print '<br>';
                $somethingshown=$formfile->show_documents('facture_fournisseur',$subdir,$filedir,$urlsource,$genallowed,$delallowed,$fac->modelpdf,1,0,0,0,0,'','','',$societe->default_lang);

                $object=$fac;

                /*
                 * Linked object block
                */
                $somethingshown=$object->showLinkedObjectBlock();

                print '</td><td valign="top" width="50%">';
                print '<br>';

                // List of actions on element
                include_once(DOL_DOCUMENT_ROOT.'/core/class/html.formactions.class.php');
                $formactions=new FormActions($db);
                $somethingshown=$formactions->showactions($object,'invoice_supplier',$socid);

                print '</td></tr></table>';
            }
        }
        /*
         * Show mail form
         */
        if ($_GET['action'] == 'presend')
        {
            $ref = dol_sanitizeFileName($fac->ref);
            $file = $conf->fournisseur->facture->dir_output.'/'.get_exdir($fac->id,2).$ref.'/'.$ref.'.pdf';

            print '<br>';
            print_titre($langs->trans('SendBillByMail'));

            // Cree l'objet formulaire mail
            include_once(DOL_DOCUMENT_ROOT.'/core/class/html.formmail.class.php');
            $formmail = new FormMail($db);
            $formmail->fromtype = 'user';
            $formmail->fromid   = $user->id;
            $formmail->fromname = $user->getFullName($langs);
            $formmail->frommail = $user->email;
            $formmail->withfrom=1;
            $formmail->withto=empty($_POST["sendto"])?1:$_POST["sendto"];
            $formmail->withtosocid=$soc->id;
            $formmail->withtocc=1;
            $formmail->withtoccsocid=0;
            $formmail->withtoccc=$conf->global->MAIN_EMAIL_USECCC;
            $formmail->withtocccsocid=0;
            $formmail->withtopic=$langs->trans('SendBillRef','__FACREF__');
            $formmail->withfile=2;
            $formmail->withbody=1;
            $formmail->withdeliveryreceipt=1;
            $formmail->withcancel=1;
            // Tableau des substitutions
            $formmail->substit['__FACREF__']=$fac->ref;
            // Tableau des parametres complementaires
            $formmail->param['action']='send';
            $formmail->param['models']='invoice_supplier_send';
            $formmail->param['facid']=$fac->id;
            $formmail->param['returnurl']=$_SERVER["PHP_SELF"].'?facid='.$fac->id;

            // Init list of files
            if (! empty($_REQUEST["mode"]) && $_REQUEST["mode"]=='init')
            {
                $formmail->clear_attached_files();
                $formmail->add_attached_files($file,dol_sanitizeFilename($ref.'.pdf'),'application/pdf');
            }

            // Show form
            $formmail->show_form();

            print '<br>';
        }
    }
}

$db->close();

llxFooter('$Date: 2011/08/04 21:46:50 $ - $Revision: 1.263 $');
?>
