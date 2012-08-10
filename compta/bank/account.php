<?php
/* Copyright (C) 2001-2005 Rodolphe Quiedeville <rodolphe@quiedeville.org>
 * Copyright (C) 2003      Jean-Louis Bergamo   <jlb@j1b.org>
 * Copyright (C) 2004-2011 Laurent Destailleur  <eldy@users.sourceforge.net>
 * Copytight (C) 2004      Christophe Combelles <ccomb@free.fr>
 * Copytight (C) 2005-2010 Regis Houssin        <regis@dolibarr.fr>
 * Copytight (C) 2010-2011 Juanjo Menent        <jmenent@@2byte.es>
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
 *	    \file       htdocs/compta/bank/account.php
 *		\ingroup    banque
 *		\brief      List of details of bank transactions for an account
 *		\version    $Id: account.php,v 1.155 2011/07/31 22:23:16 eldy Exp $
 */

require("./pre.inc.php");	// We use pre.inc.php to have a dynamic menu
require_once(DOL_DOCUMENT_ROOT."/lib/bank.lib.php");
require_once(DOL_DOCUMENT_ROOT."/societe/class/societe.class.php");
require_once(DOL_DOCUMENT_ROOT."/adherents/class/adherent.class.php");
require_once(DOL_DOCUMENT_ROOT."/compta/sociales/class/chargesociales.class.php");
require_once(DOL_DOCUMENT_ROOT."/compta/paiement/class/paiement.class.php");
require_once(DOL_DOCUMENT_ROOT."/compta/tva/class/tva.class.php");
require_once(DOL_DOCUMENT_ROOT."/fourn/class/paiementfourn.class.php");

$langs->load("bills");

// Security check
if (isset($_GET["account"]) || isset($_GET["ref"]))
{
    $id = isset($_GET["account"])?$_GET["account"]:(isset($_GET["ref"])?$_GET["ref"]:'');
}
$fieldid = isset($_GET["ref"])?'ref':'rowid';
if ($user->societe_id) $socid=$user->societe_id;
$result=restrictedArea($user,'banque',$id,'bank_account','','',$fieldid);

$req_nb=GETPOST("req_nb",'',3);
$centro=GETPOST("centro");
if (GETPOST("subcentro1") > 0){
	$subcentro = GETPOST("subcentro1");
} else if (GETPOST("subcentro2") > 0){
	$subcentro = GETPOST("subcentro2");
} else if (GETPOST("subcentro3") > 0){
		$subcentro = GETPOST("subcentro3");
	}
$account=GETPOST("account");
$vline=GETPOST("vline");
$action=GETPOST("action");

$page=isset($_GET["page"])?$_GET["page"]:0;
$negpage=isset($_GET["negpage"])?$_GET["negpage"]:0;
if ($negpage)
{
    $page=$_GET["nbpage"] - $negpage;
    if ($page > $_GET["nbpage"]) $page = $_GET["nbpage"];
}

$mesg='';


/*
 * Action
 */
$dateop=-1;

if ($action == 'add' && $account && ! isset($_POST["cancel"]) && $user->rights->banque->modifier)
{
    if (price2num($_POST["credit"]) > 0)
    {
        $amount = price2num($_POST["credit"]);
    }
    else
    {
        $amount = - price2num($_POST["debit"]);
    }

    $dateop = dol_mktime(12,0,0,$_POST["opmonth"],$_POST["opday"],$_POST["opyear"]);
    $operation=$_POST["operation"];
    $num_chq=$_POST["num_chq"];
    $label=$_POST["label"];
    $cat1=$_POST["cat1"];
	$centro = $_POST["centro"];
	if ($_POST["subcentro1"] > 0){
		$subcentro = $_POST["subcentro1"];
	} else if ($_POST["subcentro2"] > 0){
		$subcentro = $_POST["subcentro2"];
		} else if ($_POST["subcentro3"] > 0){
			$subcentro = $_POST["subcentro3"];
			}

    if (! $dateop)    $mesg=$langs->trans("ErrorFieldRequired",$langs->trans("Date"));
    if (! $operation) $mesg=$langs->trans("ErrorFieldRequired",$langs->trans("Type"));
    if (! $amount)    $mesg=$langs->trans("ErrorFieldRequired",$langs->trans("Amount"));
	if (! $centro)    $mesg=$langs->trans("ErrorFieldRequired",$langs->trans("centro"));
	if (! $subcentro)    $mesg=$langs->trans("ErrorFieldRequired",$langs->trans("subcentro"));

    if (! $mesg)
    {
        $acct=new Account($db);
        $acct->fetch($account);
		$insertid = $acct->addline($dateop, $operation, $label, $amount, $num_chq, $cat1, $user,'','',$centro, $subcentro); //adicionado o $origem para o kurt
        if ($insertid > 0)
        {
			Header("Location: account.php?account=" . $account."&action=addline&cancel=cancelar");
            exit;
        }
        else
        {
            dol_print_error($db,$acct->error);
        }
    }
    else
    {
        $action='addline';
    }
}
if ($action == 'confirm_delete' && $_POST["confirm"]=='yes' && $user->rights->banque->modifier)
{
    $accline=new AccountLine($db);
    $accline->fetch($_GET["rowid"]);
    $result=$accline->delete();
}


/*
 * View
 */

llxHeader();

$societestatic=new Societe($db);
$chargestatic=new ChargeSociales($db);
$memberstatic=new Adherent($db);
$paymentstatic=new Paiement($db);
$paymentsupplierstatic=new PaiementFourn($db);
$paymentvatstatic=new TVA($db);

$html = new Form($db);

if ($account || $_GET["ref"])
{
    if ($vline)
    {
        $viewline = $vline;
    }
    else
    {
        $viewline = empty($conf->global->MAIN_SIZE_LISTE_LIMIT)?20:$conf->global->MAIN_SIZE_LISTE_LIMIT;
    }
    $acct = new Account($db);
    if ($account)
    {
        $result=$acct->fetch($account);
    }
    if ($_GET["ref"])
    {
        $result=$acct->fetch(0,$_GET["ref"]);
        $account=$acct->id;
    }

    // Chargement des categories bancaires dans $options
    $nbcategories=0;

    $sql = "SELECT rowid, label";
    $sql.= " FROM ".MAIN_DB_PREFIX."bank_categ";
    $sql.= " WHERE entity = ".$conf->entity;
    $sql.= " ORDER BY label";

    $result = $db->query($sql);
    if ($result)
    {
        $var=True;
        $num = $db->num_rows($result);
        $i = 0;
        $options = "<option value=\"0\" selected=\"true\">&nbsp;</option>";
        while ($i < $num)
        {
            $obj = $db->fetch_object($result);
            $options .= "<option value=\"$obj->rowid\">$obj->label</option>\n";
            $nbcategories++;
            $i++;
        }
        $db->free($result);
    }


	//querys de apoio para busca de nome do centro e do subcentro
	$sqlSubCentro = "SELECT c.id, c.descricao";
	$sqlSubCentro.= " FROM ".MAIN_DB_PREFIX."sub_centro_custo as c";
	//$sqlCentro.= " INNER JOIN llx_centro_custo as c ON c.id = b.origem";
	//$sqlCentro.= " WHERE b.rowid=".$acct->id;
	$sqlSubCentro.= " WHERE c.id = " . $subcentro;
	
	//verifica se � para filtrar pelo subcentro
//	if ((trim($subcentro) <> '') && (trim($subcentro) <> '0')){
//		$sql.= " AND b.subcentro = ' . $subcentro . '";
//    dol_syslog("account.php get transactions - sql=".$sql);



    // Definition de sql_rech et param
    $param='';
    $sql_rech='';
    $mode_search = 0;
    if ($req_nb)
    {
        $sql_rech.= " AND b.num_chq like '%".$db->escape($req_nb)."%'";
        $param.='&amp;req_nb='.urlencode($req_nb);
        $mode_search = 1;
    }
    if ($_REQUEST["req_desc"])
    {
        $sql_rech.= " AND b.label like '%".$db->escape($_REQUEST["req_desc"])."%'";
        $param.='&amp;req_desc='.urlencode($_REQUEST["req_desc"]);
        $mode_search = 1;
    }
    if ($_REQUEST["req_debit"])
    {
        $sql_rech.=" AND b.amount = -".price2num($_REQUEST["req_debit"]);
        $param.='&amp;req_debit='.urlencode($_REQUEST["req_debit"]);
        $mode_search = 1;
    }
    if ($_REQUEST["req_credit"])
    {
        $sql_rech.=" AND b.amount = ".price2num($_REQUEST["req_credit"]);
        $param.='&amp;req_credit='.urlencode($_REQUEST["req_credit"]);
        $mode_search = 1;
    }
//    if ($thirdparty)
//    {
//        $sql_rech.=" AND s.nom LIKE '%".$db->escape($thirdparty)."%'";
//        $param.='&amp;thirdparty='.urlencode($thirdparty);
//        $mode_search = 1;
//    }
    if ($_REQUEST["paiementtype"])
    {
        $sql_rech.=" AND b.fk_type = '".$db->escape($_REQUEST["paiementtype"])."'";
        $param.='&amp;paiementtype='.urlencode($_REQUEST["paiementtype"]);
        $mode_search = 1;
    }

    $sql = "SELECT count(*) as nb";
    $sql.= " FROM ".MAIN_DB_PREFIX."bank_account as ba";
    $sql.= ", ".MAIN_DB_PREFIX."bank as b";
    if ($mode_search)
    {
        $sql.= " LEFT JOIN ".MAIN_DB_PREFIX."bank_url as bu ON bu.fk_bank = b.rowid AND bu.type='company'";
        $sql.= " LEFT JOIN ".MAIN_DB_PREFIX."societe as s ON bu.url_id = s.rowid";
    }
    $sql.= " WHERE b.fk_account = ".$acct->id;
    $sql.= " AND b.fk_account = ba.rowid";
	//feito para o kurt, um sql diferente se o usu�rio for o CBA (id 7), ele s� pode ver a conta mineirao (id 3)
	if ($user->id == 7) {
		$sql .= " AND ba.rowid = 3";
	}
    $sql.= " AND ba.entity = ".$conf->entity;
    $sql.= $sql_rech;

    dol_syslog("account.php count transactions - sql=".$sql);
    $result=$db->query($sql);
    if ($result)
    {
        $obj = $db->fetch_object($result);
        $nbline = $obj->nb;
        $total_lines = $nbline;

        if ($nbline > $viewline )
        {
            $limit = $nbline - $viewline ;
        }
        else
        {
            $limit = $viewline;
        }

        $db->free($result);
    }
    else {
        dol_print_error($db);
    }

    if ($page > 0)
    {
        $limitsql = $nbline - ($page * $viewline);
        if ($limitsql < $viewline)
        {
            $limitsql = $viewline;
        }
        $nbline = $limitsql;
    }
    else
    {
        $page = 0;
        $limitsql = $nbline;
    }
    //print $limitsql.'-'.$page.'-'.$viewline;

    // Onglets
    $head=bank_prepare_head($acct);
    dol_fiche_head($head,'journal',$langs->trans("FinancialAccount"),0,'account');

    print '<table class="border" width="100%">';

    // Ref
    print '<tr><td valign="top" width="25%">'.$langs->trans("Ref").'</td>';
    print '<td colspan="3">';
    print $html->showrefnav($acct,'ref','',1,'ref');
    print '</td></tr>';

    // Label
    print '<tr><td valign="top">'.$langs->trans("Label").'</td>';
    print '<td colspan="3">'.$acct->label.'</td></tr>';

    print '</table>';

    print '<br>';

    if ($mesg) print '<div class="error">'.$mesg.'</div>';


    /**
     * Search form
     */
    $param.='&amp;account='.$acct->id;


    // Define transaction list navigation string
    $navig='';
    $navig.='<form action="'.$_SERVER["PHP_SELF"].'" name="newpage" method="GET">';
    $nbpage=floor($total_lines/$viewline)+($total_lines % $viewline > 0?1:0);  // Nombre de page total
    //print 'nbpage='.$nbpage.' viewline='.$viewline.' limitsql='.$limitsql;
    if ($limitsql > $viewline)
    {
        $navig.='<a href="account.php?'.$param.'&amp;page='.($page+1).'">'.img_previous().'</a>';
    }
    $navig.= $langs->trans("Page")." "; // ' Page ';
    $navig.='<input type="text" name="negpage" size="1" class="flat" value="'.($nbpage-$page).'">';
    $navig.='<input type="hidden" name="req_nb"     value="'.$req_nb.'">';
    $navig.='<input type="hidden" name="req_desc"   value="'.$_REQUEST["req_desc"].'">';
    $navig.='<input type="hidden" name="req_debit"  value="'.$_REQUEST["req_debit"].'">';
    $navig.='<input type="hidden" name="req_credit" value="'.$_REQUEST["req_credit"].'">';
    $navig.='<input type="hidden" name="centro" value="'.$_REQUEST["centro"].'">';
	$navig.='<input type="hidden" name="subcentro" value="'.$subcentro.'">';
    $navig.='<input type="hidden" name="nbpage"  value="'.$nbpage.'">';
    $navig.='<input type="hidden" name="account" value="'.($acct->id).'">';
    $navig.='/'.$nbpage.' ';
    if ($total_lines > $limitsql )
    {
        $navig.= '<a href="account.php?'.$param.'&amp;page='.($page-1).'">'.img_next().'</a>';
    }
    $navig.='</form>';
    //var_dump($navig);

    // Confirmation delete
    if ($action == 'delete')
    {
        $text=$langs->trans('ConfirmDeleteTransaction');
        $ret=$html->form_confirm($_SERVER['PHP_SELF'].'?account='.$acct->id.'&amp;rowid='.$_GET["rowid"],$langs->trans('DeleteTransaction'),$text,'confirm_delete');
        if ($ret == 'html') print '<br>';
    }


    print '<table class="notopnoleftnoright" width="100%" border="1">';

    // Show title
    if ($action != 'addline' && $action != 'delete')
    {
        print '<tr><td colspan="9" align="right">'.$navig.'</td></tr>';
    }


    // Form to add a transaction with no invoice
    if ($user->rights->banque->modifier && $action == 'addline')
    {
        print '<form method="post" action="'.$_SERVER["PHP_SELF"].'">';
        print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
        print '<input type="hidden" name="action" value="add">';
        print '<input type="hidden" name="vline" value="' . $vline . '">';
        print '<input type="hidden" name="account" value="' . $acct->id . '">';

        print '<tr>';
        print '<td align="left" colspan="10"><b>'.$langs->trans("AddBankRecordLong").'</b></td>';
        print '</tr>';

        print '<tr class="liste_titre">';
        print '<td>'.$langs->trans("Date").'</td>';
        print '<td>&nbsp;</td>';
        print '<td>'.$langs->trans("Type").'</td>';
        //print '<td>'.$langs->trans("Numero").'</td>';
        print '<td>'.$langs->trans("Description").'</td>';
		print '<td>'.$langs->trans("origem").'</td>';
		print '<td>'.$langs->trans("sub-centro").'</td>';
        print '<td align=right>'.$langs->trans("Debit").'</td>';
        print '<td align=right>'.$langs->trans("Credit").'</td>';
        print '<td colspan="2" align="center">&nbsp;</td>';
        print '</tr>';

        print '<tr '.$bc[false].'>';
        print '<td nowrap="nowrap" colspan="2">';
        $html->select_date($dateop,'op',0,0,0,'transaction');
        print '</td>';
        print '<td nowrap="nowrap">';
        $html->select_types_paiements((isset($_POST["operation"])?$_POST["operation"]:''),'operation','1,2',2,1);
       // print '</td>';
        //print '<input name="num_chq" class="flat" type="text" size="4" value="'.(isset($_POST["num_chq"])?$_POST["num_chq"]:'').'"></td>';
       // print '<td>';
		print '<td><input name="label" class="flat" type="text" size="24"  value="'.(isset($_POST["label"])?$_POST["label"]:'').'"></td>';
		//kurt
		print '<td>'. $acct->printCentro($_REQUEST["centro"], $subcentro, 1) .'</td>';
		
		require_once(DOL_DOCUMENT_ROOT.'/includes/util_kurt.php');
		
        if ($nbcategories)
        {
            print '<br>'.$langs->trans("Category").': <select class="flat" name="cat1">'.$options.'</select>';
        }
        print '</td>';
        print '<td align=right><input name="debit" class="flat" type="text" size="4" value="'.(isset($_POST["debit"])?$_POST["debit"]:'').'"></td>';
        print '<td align=right><input name="credit" class="flat" type="text" size="4" value="'.(isset($_POST["credit"])?$_POST["credit"]:'').'"></td>';
        print '<td colspan="2" align="center">';
        print '<input type="submit" name="save" class="button" value="'.$langs->trans("Add").'"><br>';
		//print '<input type="hidden" name="cancel" value="cancelar">';
        print '<input type="submit" name="cancel" class="button" value="'.$langs->trans("Cancel").'">';
        print '</td></tr>';
        print "</form>";

        print "<tr class=\"noborder\"><td colspan=\"8\">&nbsp;</td></tr>\n";
    }

    /*
     * Affiche tableau des transactions bancaires
     *
     */

    // Ligne de titre tableau des ecritures
    print '<tr class="liste_titre">';
    print '<td>'.$langs->trans("Date").'</td>';
    print '<td>'.$langs->trans("Value").'</td>';
    print '<td>'.$langs->trans("Type").'</td>';
   // print '<td>'.$langs->trans("Numero").'</td>';
    print '<td>'.$langs->trans("Description").'</td>';
	print '<td>'.$langs->trans("origem").'</td>';
	print '<td>'.$langs->trans("sub-centro").'</td>';
    print '<td align="right">'.$langs->trans("Debit").'</td>';
    print '<td align="right">'.$langs->trans("Credit").'</td>';
    print '<td align="right" width="80">'.$langs->trans("BankBalance").'</td>';
    print '<td align="center" width="60">';
    if ($acct->type != 2 && $acct->rappro) print $langs->trans("AccountStatementShort");
    else print '&nbsp;';
    print '</td></tr>';

    print '<form action="'.$_SERVER["PHP_SELF"].'?'.$param.'" name="search" method="POST">';
    print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
    print '<input type="hidden" name="action" value="search">';
    print '<input type="hidden" name="account" value="' . $acct->id . '">';

    print '<tr class="liste_titre">';
    print '<td>&nbsp;</td>';
    print '<td>&nbsp;</td>';
    print '<td>';
    //$filtertype=array('TIP'=>'TIP','PRE'=>'PRE',...)
    $filtertype='';
    print $html->select_types_paiements($_REQUEST['paiementtype'],'paiementtype',$filtertype,2,1,1,8);
    print '</td>';
	//print '<td></td>'; //<input type="text" class="flat" name="req_nb" value="'.$req_nb.'" size="2">
    print '<td><input type="text" class="flat" name="req_desc" value="'.$_REQUEST["req_desc"].'" size="24"></td>';
	print '<td>'. $acct->printCentro($_REQUEST["centroSearch"], $_REQUEST["SubCentroSearch"], 2) .'</td>';

	require_once(DOL_DOCUMENT_ROOT.'/includes/util_kurt.php');
	
//	print utf8_encode('<td><div id="div1" style="display:block;"><select name="subcentro1" id="subcentro1"><option value="0"></option><option value="1">Fichados</option><option value="2">Medi��o</option></select></div>');
//	print utf8_encode('<div id="div2" style="display:none;"><select name="subcentro2"  id="subcentro2"><option value="0"></option><option value="3">Acabamentos</option><option value="4">Material b�sico</option><option value="5">Material el�trico</option><option value="6">Material hidr�ulico</option><option value="7">Esquadrias</option><option value="8">Impermeabializa��o</option></select></div>');
//	print utf8_encode('<div id="div3" style="display:none;"><select name="subcentro3" id="subcentro3"><option value="0"></option><option value="9">Aquisi��o</option><option value="10">Loca��o</option><option value="11">Manuten��o</option></select></div></td>');
    print '<td align="right"><input type="text" class="flat" name="req_debit" value="'.$_REQUEST["req_debit"].'" size="4"></td>';
    print '<td align="right"><input type="text" class="flat" name="req_credit" value="'.$_REQUEST["req_credit"].'" size="4"></td>';
    print '<td align="center">&nbsp;</td>';
    print '<td align="center" width="40"><input type="image" class="liste_titre" src="'.DOL_URL_ROOT.'/theme/'.$conf->theme.'/img/search.png" value="'.dol_escape_htmltag($langs->trans("Search")).'" title="'.dol_escape_htmltag($langs->trans("Search")).'"></td>';
    print "</tr>\n";
    print "</form>\n";

    /* Another solution
     * create temporary table solde type=heap select amount from llx_bank limit 100 ;
     * select sum(amount) from solde ;
     */

    $sql = "SELECT b.rowid, b.dateo as do, b.datev as dv,";
    $sql.= " b.amount, b.label, b.rappro, b.num_releve, b.num_chq, b.fk_type, b.origem, b.subcentro, c.descricao as centro, sc.descricao as subcentro";
	
//    if ($mode_search)
//    {
//        $sql.= ", s.rowid as socid, s.nom as b.origem";
//    }
    if ($mode_search && $conf->adherent->enabled)
    {

    }
    if ($mode_search && $conf->tax->enabled)
    {

    }
    $sql.= " FROM ".MAIN_DB_PREFIX."bank_account as ba";
    $sql.= ", ".MAIN_DB_PREFIX."bank as b";
	$sql.= " LEFT JOIN ".MAIN_DB_PREFIX."centro_custo as c ON b.origem = c.id";
	$sql.= " LEFT JOIN ".MAIN_DB_PREFIX."sub_centro_custo as sc ON b.subcentro = sc.id";
    if ($mode_search)
    {
        $sql.= " LEFT JOIN ".MAIN_DB_PREFIX."bank_url as bu1 ON bu1.fk_bank = b.rowid AND bu1.type='company'";
        $sql.= " LEFT JOIN ".MAIN_DB_PREFIX."societe as s ON bu1.url_id = s.rowid";
    }
    if ($mode_search && $conf->tax->enabled)
    {
        $sql.= " LEFT JOIN ".MAIN_DB_PREFIX."bank_url as bu2 ON bu2.fk_bank = b.rowid AND bu2.type='payment_vat'";
        $sql.= " LEFT JOIN ".MAIN_DB_PREFIX."tva as t ON bu2.url_id = t.rowid";
    }
    if ($mode_search && $conf->adherent->enabled)
    {
        // TODO Mettre jointure sur adherent pour recherche sur un adherent
        //$sql.= " LEFT JOIN ".MAIN_DB_PREFIX."bank_url as bu3 ON bu3.fk_bank = b.rowid AND bu3.type='company'";
        //$sql.= " LEFT JOIN ".MAIN_DB_PREFIX."societe as s ON bu3.url_id = s.rowid";
    }
    $sql.= " WHERE b.fk_account=".$acct->id;
    $sql.= " AND b.fk_account = ba.rowid";
	//verifica se � para filtrar pela origem
	$centroSearch = $_POST['centroSearch'];
	if ((trim($centroSearch) <> '') && (trim($centroSearch) <> '0')){
		$sql.= " AND b.origem = " . $centroSearch;
	}
	//verifica se � para filtrar pelo subcentro
	$SubCentroSearch = $_POST['SubCentroSearch'];
	if ((trim($SubCentroSearch) <> '') && (trim($SubCentroSearch) <> '0')){
		$sql.= " AND b.subcentro = " . $SubCentroSearch;
	}
	//feito para o kurt, um sql diferente se o usu�rio for o CBA (id 7), ele s� pode ver a conta mineirao (id 3)
	if ($user->id == 7) {
		$sql .= " AND ba.rowid = 3";
	}
    $sql.= " AND ba.entity = ".$conf->entity;
    $sql.= $sql_rech;
    $sql.= $db->order("b.datev, b.datec", "ASC");  // We add date of creation to have correct order when everything is done the same day
    $sql.= $db->plimit($limitsql, 0);

	
    dol_syslog("account.php get transactions - sql=".$sql);
    $result = $db->query($sql);
    if ($result)
    {
        $now=dol_now();
        $nows=dol_print_date($now,'%Y%m%d');

        //$html->load_cache_types_paiements();
        //$html->cache_types_paiements

        $var=true;

        $num = $db->num_rows($result);
        $i = 0; $total = 0; $sep = 0;

        while ($i < $num)
        {
            $objp = $db->fetch_object($result);
            $total = price2num($total + $objp->amount,'MT');
            if ($i >= ($nbline - $viewline))
            {
                $var=!$var;

                // Is it a transaction in future ?
                $dos=dol_print_date($db->jdate($objp->do),'%Y%m%d');
                //print "dos=".$dos." nows=".$nows;
                if ($dos > $nows && !$sep)		// Yes, we show a subtotal
                {
                    $sep = 1 ;
                    print '<tr class="liste_total"><td colspan="8">';
                    print $langs->trans("CurrentBalance");
                    print '</td>';
                    print "<td align=\"right\" nowrap><b>".price($total - $objp->amount)."</b></td>";
                    print "<td>&nbsp;</td>";
                    print '</tr>';
                }

                print "<tr $bc[$var]>";

                print '<td nowrap="nowrap">'.dol_print_date($db->jdate($objp->do),"day")."</td>\n";

                print '<td nowrap="nowrap">'.dol_print_date($db->jdate($objp->dv),"day");
                print "</td>\n";

                // Payment type
                print "<td nowrap>";
                $label=($langs->trans("PaymentTypeShort".$objp->fk_type)!="PaymentTypeShort".$objp->fk_type)?$langs->trans("PaymentTypeShort".$objp->fk_type):$objp->fk_type;
               // $label=$langs->getTradFromKey("PaymentTypeShort".$objp->fk_type);

                if ($objp->fk_type == 'SOLD') $label='&nbsp;';
                print $label;
                print "</td>\n";

//                // Num
//                print '<td nowrap>'.($objp->num_chq?$objp->num_chq:"")."</td>\n";

                // Description
                print '<td>';
                // Show generic description
                if (preg_match('/^\((.*)\)$/i',$objp->label,$reg))
                {
                    // Generic description because between (). We show it after translating.
                    print $langs->trans($reg[1]);
                }
                else
                {
                    print dol_trunc($objp->label,60);
                }
                // Add links after description
                $links = $acct->get_url($objp->rowid);
                foreach($links as $key=>$val)
                {
                    if ($links[$key]['type']=='payment') {
                        $paymentstatic->id=$links[$key]['url_id'];
                        print ' '.$paymentstatic->getNomUrl(2);
                    }
                    else if ($links[$key]['type']=='payment_supplier') {
                        $paymentsupplierstatic->id=$links[$key]['url_id'];
                        $paymentsupplierstatic->ref=$links[$key]['url_id'];
                        print ' '.$paymentsupplierstatic->getNomUrl(2);
                    }
                    else if ($links[$key]['type']=='company') {
                    }
                    else if ($links[$key]['type']=='payment_sc')
                    {
                        //print ' - ';
                        print '<a href="'.DOL_URL_ROOT.'/compta/payment_sc/fiche.php?id='.$links[$key]['url_id'].'">';
                        print ' '.img_object($langs->trans('ShowPayment'),'payment').' ';
                        //print $langs->trans("SocialContributionPayment");
                        print '</a>';

                    }
                    else if ($links[$key]['type']=='payment_vat')
                    {
                        $paymentvatstatic->id=$links[$key]['url_id'];
                        $paymentvatstatic->ref=$links[$key]['url_id'];
                        print ' '.$paymentvatstatic->getNomUrl(2);
                    }
                    else if ($links[$key]['type']=='banktransfert') {
                        // Do not show this link (avoid confusion). Can already be accessed from transaction detail
                    }
                    else if ($links[$key]['type']=='member') {
                    }
                    else if ($links[$key]['type']=='sc') {
                    }
                    else {  // Show link with label $links[$key]['label']
                        if (! empty($objp->label) && ! empty($links[$key]['label'])) print ' - ';
                        print '<a href="'.$links[$key]['url'].$links[$key]['url_id'].'">';
                        if (preg_match('/^\((.*)\)$/i',$links[$key]['label'],$reg))
                        {
                            // Label generique car entre parentheses. On l'affiche en le traduisant
                            if ($reg[1]=='paiement') $reg[1]='Payment';
                            print ' '.$langs->trans($reg[1]);
                        }
                        else
                        {
                            print ' '.$links[$key]['label'];
                        }
                        print '</a>';
                    }
                }
                print '</td>';


                // Add third party column
//                print '<td>';
//                foreach($links as $key=>$val)
//                {
//                    if ($links[$key]['type']=='company') {
//                        $societestatic->id=$links[$key]['url_id'];
//                        $societestatic->nom=$links[$key]['label'];
//                        print $societestatic->getNomUrl(1,'',16);
//                    }
//                    else if ($links[$key]['type']=='sc') {   // sc=old value
//                        $chargestatic->id=$links[$key]['url_id'];
//                        if (preg_match('/^\((.*)\)$/i',$links[$key]['label'],$reg))
//                        {
//                            if ($reg[1]=='socialcontribution') $reg[1]='SocialContribution';
//                            $chargestatic->lib=$langs->trans($reg[1]);
//                        }
//                        else
//                        {
//                            $chargestatic->lib=$links[$key]['label'];
//                        }
//                        $chargestatic->ref=$chargestatic->lib;
//                        print $chargestatic->getNomUrl(1,16);
//                    }
//                    else if ($links[$key]['type']=='member') {
//                        $memberstatic->id=$links[$key]['url_id'];
//                        $memberstatic->ref=$links[$key]['label'];
//                        print $memberstatic->getNomUrl(1,16,'card');
//                    }
//                }
//                print '</td>';
				
				//kurt (origem)
				print "<td nowrap>". $objp->centro ."</td>\n";
				print "<td nowrap>". $objp->subcentro ."</td>\n";

                // Amount
                if ($objp->amount < 0)
                {
                    print "<td align=\"right\" nowrap>".price($objp->amount * -1)."</td><td>&nbsp;</td>\n";
                }
                else
                {
                    print "<td>&nbsp;</td><td align=\"right\" nowrap>&nbsp;".price($objp->amount)."</td>\n";
                }

                // Balance
                if ($action != 'search')
                {
                    if ($total >= 0)
                    {
                        print '<td align="right" nowrap>&nbsp;'.price($total).'</td>';
                    }
                    else
                    {
                        print '<td align="right" class="error" nowrap>&nbsp;'.price($total).'</td>';
                    }
                }
                else
                {
                    print '<td align="right">-</td>';
                }

                // Transaction reconciliated or edit link
                if ($objp->rappro && $acct->canBeConciliated() > 0)  // If line not conciliated and account can be conciliated
                {
                    print "<td align=\"center\" nowrap>";
                    print '<a href="'.DOL_URL_ROOT.'/compta/bank/ligne.php?rowid='.$objp->rowid.'&amp;account='.$acct->id.'&amp;page='.$page.'">';
                    print img_edit();
                    print '</a>';
                    print "&nbsp; ";
                    print "<a href=\"releve.php?num=$objp->num_releve&amp;account=$acct->id\">$objp->num_releve</a>";
                    print "</td>";
                }
                else
                {
                    print '<td align="center">';
                    if ($user->rights->banque->modifier || $user->rights->banque->consolidate)
                    {
                        print '<a href="'.DOL_URL_ROOT.'/compta/bank/ligne.php?rowid='.$objp->rowid.'&amp;account='.$acct->id.'&amp;page='.$page.'">';
                        print img_edit();
                        print '</a>';
                    }
                    else
                    {
                        print '<a href="'.DOL_URL_ROOT.'/compta/bank/ligne.php?rowid='.$objp->rowid.'&amp;account='.$acct->id.'&amp;page='.$page.'">';
                        print img_view();
                        print '</a>';
                    }
                    if ($acct->canBeConciliated() > 0 && empty($objp->rappro))
                    {
                        if ($db->jdate($objp->dv) < ($now - $conf->bank->rappro->warning_delay))
                        {
                            print ' '.img_warning($langs->trans("Late"));
                        }
                    }
                    print '&nbsp;';
					//modificado para que apenas o usuario do kurt (id = 1) tenha permissao de excluir registros
					//era: if ($user->rights->banque->modifier)
					if (($user->id == 1)  || ($user->id == 6))
                    {
                        print '<a href="'.DOL_URL_ROOT.'/compta/bank/account.php?action=delete&amp;rowid='.$objp->rowid.'&amp;account='.$acct->id.'&amp;page='.$page.'">';
                        print img_delete();
                        print '</a>';
                    }
                    print '</td>';
                }

                print "</tr>";

            }

            $i++;
        }

        // Show total
        if ($page == 0 && ! $mode_search)
        {
            print '<tr class="liste_total"><td align="left" colspan="8">';
            if ($sep) print '&nbsp;';
            else print $langs->trans("CurrentBalance");
            print '</td>';
            print '<td align="right" nowrap>'.price($total).'</td>';
            print '<td>&nbsp;</td>';
            print '</tr>';
        }
        $db->free($result);
    }
    else
    {
        dol_print_error($db);
    }


    print "</table>";

    print "\n</div>\n";

    /*
     *  Boutons actions
     */

    if ($action != 'delete')
    {
	    print '<div class="tabsAction">';

        if ($acct->type != 2 && $acct->rappro)  // If not cash account and can be reconciliate
        {
            if ($user->rights->banque->consolidate)
            {
                print '<a class="butAction" href="'.DOL_URL_ROOT.'/compta/bank/rappro.php?account='.$acct->id.'">'.$langs->trans("Conciliate").'</a>';
            }
            else
            {
                print "<a class=\"butActionRefused\" title=\"".$langs->trans("NotEnoughPermissions")."\" href=\"#\">".$langs->trans("Conciliate")."</a>";
            }
        }

	    if ($action != 'addline')
	    {
	        if ($user->rights->banque->modifier)
		    {
		        print '<a class="butAction" href="account.php?action=addline&amp;account='.$acct->id.'&amp;page='.$page.'">'.$langs->trans("AddBankRecord").'</a>';
		    }
		    else
		    {
		        print "<a class=\"butActionRefused\" title=\"".$langs->trans("NotEnoughPermissions")."\" href=\"#\">".$langs->trans("AddBankRecord")."</a>";
		    }
	    }

	    print '</div>';
    }

    print '<br>';

}
else
{
    print $langs->trans("ErrorBankAccountNotFound");
}

$db->close();

llxFooter('$Date: 2011/07/31 22:23:16 $ - $Revision: 1.155 $');
?>
