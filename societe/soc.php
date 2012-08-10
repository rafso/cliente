<?php
/* Copyright (C) 2001-2007 Rodolphe Quiedeville <rodolphe@quiedeville.org>
 * Copyright (C) 2003      Brian Fraval         <brian@fraval.org>
 * Copyright (C) 2004-2011 Laurent Destailleur  <eldy@users.sourceforge.net>
 * Copyright (C) 2005      Eric Seigne          <eric.seigne@ryxeo.com>
 * Copyright (C) 2005-2011 Regis Houssin        <regis@dolibarr.fr>
 * Copyright (C) 2008	   Patrick Raguin       <patrick.raguin@auguria.net>
 * Copyright (C) 2010-2011 Juanjo Menent        <jmenent@2byte.es>
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
 *  \file       htdocs/societe/soc.php
 *  \ingroup    societe
 *  \brief      Third party card page
 *  \version    $Id: soc.php,v 1.126 2011/08/01 00:38:49 eldy Exp $
 */

require("../main.inc.php");
require_once(DOL_DOCUMENT_ROOT."/lib/company.lib.php");
require_once(DOL_DOCUMENT_ROOT."/lib/images.lib.php");
require_once(DOL_DOCUMENT_ROOT."/lib/files.lib.php");
require_once(DOL_DOCUMENT_ROOT."/core/class/html.formadmin.class.php");
require_once(DOL_DOCUMENT_ROOT."/core/class/html.formcompany.class.php");
require_once(DOL_DOCUMENT_ROOT."/core/class/html.formfile.class.php");
require_once(DOL_DOCUMENT_ROOT."/core/class/extrafields.class.php");
require_once(DOL_DOCUMENT_ROOT."/contact/class/contact.class.php");
if ($conf->adherent->enabled) require_once(DOL_DOCUMENT_ROOT."/adherents/class/adherent.class.php");

$langs->load("companies");
$langs->load("commercial");
$langs->load("bills");
$langs->load("banks");
$langs->load("users");
if ($conf->notification->enabled) $langs->load("mails");

$error=0; $errors=array();

$action = GETPOST('action');
$confirm = GETPOST('confirm');

$object = new Societe($db);
$extrafields = new ExtraFields($db);

// Security check
$socid = GETPOST("socid");
if ($user->societe_id) $socid=$user->societe_id;

// Get object canvas (By default, this is not defined, so standard usage of dolibarr)
if (!empty($socid)) $object->getCanvas($socid);
$canvas = (!empty($object->canvas)?$object->canvas:GETPOST("canvas"));
if (! empty($canvas))
{
    require_once(DOL_DOCUMENT_ROOT."/core/class/canvas.class.php");
    $objcanvas = new Canvas($db,$action);
    $objcanvas->getCanvas('thirdparty','card',$canvas);
    // Security check
    $result = $objcanvas->restrictedArea($user, 'societe', $socid);
}
else
{
    // Security check
//    $result = restrictedArea($user, 'societe', $socid);
}

// Instantiate hooks of thirdparty module. Note that conf->hooks_modules contains array array
if (is_array($conf->hooks_modules) && !empty($conf->hooks_modules))
{
    $object->callHooks('thirdpartycard');
}



/*
 * Actions
 */



$reshook=0;

// Hook of actions. After that, reshook is 0 if we need to process standard actions, >0 otherwise.
if (! empty($object->hooks))
{
    foreach($object->hooks as $hook)
    {
        if (! empty($hook['modules']))
        {
            foreach($hook['modules'] as $module)
            {
                if (method_exists($module,'doActions'))
                {
                    $resaction+=$module->doActions($object,$action,$socid); // object is deprecated, action can be changed by method (to go back to other action for example), socid can be changed/set by method (during creation for example)
                    if ($resaction < 0 || ! empty($module->error) || (! empty($module->errors) && sizeof($module->errors) > 0))
                    {
                        $error=$module->error; $errors=$module->errors;
                        if ($action=='add')    $action='create';    // TODO this chnage must be inside the doActions
                        if ($action=='update') $action='edit';      // TODO this chnage must be inside the doActions
                    }
                    else
                    {
                        $reshook+=$resaction;
                    }
                }
            }
        }
    }
}

// ---------- start deprecated. Use hook to hook actions.
// If canvas actions are defined, because on url, or because contact was created with canvas feature on, we use the canvas feature.
// If canvas actions are not defined, we use standard feature.
if (method_exists($objcanvas->control,'doActions'))
{
    $objcanvas->doActions($socid);

    if (! empty($objcanvas->error) || (! empty($objcanvas->errors) && sizeof($objcanvas->errors) > 0))
    {
        $error=$objcanvas->error; $errors=$objcanvas->errors;
        if ($action=='add')    { $objcanvas->action='create'; $action='create'; }
        if ($action=='update') { $objcanvas->action='edit';   $action='edit'; }
    }
}
// ---------- end deprecated.

if (empty($reshook))
{
    if ($_POST["getcustomercode"])
    {
        // We defined value code_client
        $_POST["code_client"]="Acompleter";
    }

    if ($_POST["getsuppliercode"])
    {
        // We defined value code_fournisseur
        $_POST["code_fournisseur"]="Acompleter";
    }

    // Add new third party
    if ((! $_POST["getcustomercode"] && ! $_POST["getsuppliercode"])
    && ($action == 'add' || $action == 'update') && $user->rights->societe->creer)
    {
        require_once(DOL_DOCUMENT_ROOT."/lib/functions2.lib.php");

        if ($action == 'update')
        {
            $object->fetch($socid);
        }
        else if ($canvas) $object->canvas=$canvas;

        if (GETPOST("private") == 1)
        {
            $object->particulier           = GETPOST("private");

            $object->name                  = empty($conf->global->MAIN_FIRSTNAME_NAME_POSITION)?trim($_POST["prenom"].' '.$_POST["nom"]):trim($_POST["nom"].' '.$_POST["prenom"]);
            $object->nom                   = $object->name;     // TODO obsolete
            $object->nom_particulier       = $_POST["nom"];
            $object->prenom                = $_POST["prenom"];
            $object->civilite_id           = $_POST["civilite_id"];
        }
        else
        {
            $object->name                  = $_POST["nom"];
            $object->nom                   = $object->name;     // TODO obsolete
        }
        $object->address               = $_POST["adresse"];
        $object->adresse               = $_POST["adresse"]; // TODO obsolete
        $object->zip                   = $_POST["ville"];
        $object->cp                    = $_POST["cp"]; // TODO obsolete
        $object->town                  = $_POST["town"];
		$object->ville                 = $_POST["ville"];    // TODO obsolete
        $object->pays_id               = $_POST["pays_id"];
        $object->departement_id        = $_POST["departement_id"];
        $object->tel                   = $_POST["tel"];
        $object->fax                   = $_POST["fax"];
        $object->email                 = trim($_POST["email"]);
        $object->url                   = trim($_POST["url"]);
        $object->siren                 = $_POST["idprof1"];
        $object->siret                 = $_POST["idprof2"];
        $object->ape                   = $_POST["idprof3"];
        $object->idprof4               = $_POST["idprof4"];
        $object->prefix_comm           = $_POST["prefix_comm"];
        $object->code_client           = $_POST["code_client"];
        $object->code_fournisseur      = $_POST["code_fournisseur"];
        $object->capital               = $_POST["capital"];
        $object->gencod                = $_POST["gencod"];

        $object->tva_intra             = $_POST["tva_intra"];
        $object->tva_assuj             = $_POST["assujtva_value"];
        $object->status                = $_POST["status"];

        // Local Taxes
        $object->localtax1_assuj       = $_POST["localtax1assuj_value"];
        $object->localtax2_assuj       = $_POST["localtax2assuj_value"];

        $object->forme_juridique_code  = $_POST["forme_juridique_code"];
        $object->effectif_id           = $_POST["effectif_id"];
        if (GETPOST("private") == 1)
        {
            $object->typent_id             = 8; // TODO predict another method if the field "special" change of rowid
        }
        else
        {
            $object->typent_id             = $_POST["typent_id"];
        }

        $object->client                = $_POST["client"];
        $object->fournisseur           = $_POST["fournisseur"];
        $object->fournisseur_categorie = $_POST["fournisseur_categorie"];

        $object->commercial_id         = $_POST["commercial_id"];
        $object->default_lang          = $_POST["default_lang"];
		
		//recebe os novos campos
		$object->rua					= $_POST["rua"];
		$object->numero					= $_POST["numero"];
		$object->complemento			= $_POST["complemento"];
		$object->bairro					= $_POST["bairro"];
		$object->cpf_cnpj				= $_POST["cpf_cnpj"];
		$object->como_conheceu          = $_POST["como_conheceu"];
		$object->tipo_fornecedor		= $_POST["tipo_fornecedor"];
		$object->email_2				= $_POST["email_2"];
		$object->ponto_ref				= $_POST["ponto_ref"];
		$object->tel1_soli				= $_POST["tel1_soli"];
		$object->tel2_soli				= $_POST["tel2_soli"];

        // Get extra fields
        foreach($_POST as $key => $value)
        {
            if (preg_match("/^options_/",$key))
            {
                $object->array_options[$key]=$_POST[$key];
            }
        }

        if (GETPOST('deletephoto')) $object->logo = '';
        else if (! empty($_FILES['photo']['name'])) $object->logo = dol_sanitizeFileName($_FILES['photo']['name']);

        // Check parameters
        if (empty($_POST["cancel"]))
        {
            if (! empty($object->email) && ! isValidEMail($object->email))
            {
                $langs->load("errors");
                $error++; $errors[] = $langs->trans("ErrorBadEMail",$object->email);
                $action = ($action=='add'?'create':'edit');
            }
            if (! empty($object->url) && ! isValidUrl($object->url))
            {
                $langs->load("errors");
                $error++; $errors[] = $langs->trans("ErrorBadUrl",$object->url);
                $action = ($action=='add'?'create':'edit');
            }
            if ($object->fournisseur && ! $conf->fournisseur->enabled)
            {
                $langs->load("errors");
                $error++; $errors[] = $langs->trans("ErrorSupplierModuleNotEnabled");
                $action = ($action=='add'?'create':'edit');
            }
        }

        if (! $error)
        {
            if ($action == 'add')
            {
                $db->begin();

                if (empty($object->client))      $object->code_client='';
                if (empty($object->fournisseur)) $object->code_fournisseur='';

                $result = $object->create($user);
                if ($result >= 0)
                {
                    if ($object->particulier)
                    {
                        dol_syslog("This thirdparty is a personal people",LOG_DEBUG);
                        $contact=new Contact($db);

     					$contact->civilite_id=$object->civilite_id;
                        $contact->name=$object->nom_particulier;
                        $contact->firstname=$object->prenom;
                        $contact->address=$object->address;
                        $contact->zip=$object->zip;
                        $contact->cp=$object->cp;
                        $contact->town=$object->town;
                        $contact->ville=$object->ville;
                        $contact->fk_departement=$object->departement_id;
                        $contact->fk_pays=$object->pays_id;
                        $contact->socid=$object->id;                   // fk_soc
                        $contact->status=1;
                        $contact->email=$object->email;
						$contact->phone_pro=$object->tel;
						$contact->fax=$object->fax;
                        $contact->priv=0;

                        $result=$contact->create($user);
                        if (! $result >= 0)
                        {
                            $error=$contact->error; $errors=$contact->errors;
                        }
                    }

                    ### Gestion du logo de la société
                    $dir     = $conf->societe->dir_output."/".$object->id."/logos/";
                    $file_OK = is_uploaded_file($_FILES['photo']['tmp_name']);
                    if ($file_OK)
                    {
                        if (image_format_supported($_FILES['photo']['name']))
                        {
                            create_exdir($dir);

                            if (@is_dir($dir))
                            {
                                $newfile=$dir.'/'.dol_sanitizeFileName($_FILES['photo']['name']);
                                $result = dol_move_uploaded_file($_FILES['photo']['tmp_name'], $newfile, 1);

                                if (! $result > 0)
                                {
                                    $errors[] = "ErrorFailedToSaveFile";
                                }
                                else
                                {
                                    // Create small thumbs for company (Ratio is near 16/9)
                                    // Used on logon for example
                                    $imgThumbSmall = vignette($newfile, $maxwidthsmall, $maxheightsmall, '_small', $quality);

                                    // Create mini thumbs for company (Ratio is near 16/9)
                                    // Used on menu or for setup page for example
                                    $imgThumbMini = vignette($newfile, $maxwidthmini, $maxheightmini, '_mini', $quality);
                                }
                            }
                        }
                    }
                    ### Gestion du logo de la société
                }
                else
                {
                    $error=$object->error; $errors=$object->errors;
                }

                if ($result >= 0)
                {
                    $db->commit();

                    $url=$_SERVER["PHP_SELF"]."?socid=".$object->id;
                    if (($object->client == 1 || $object->client == 3) && empty($conf->global->SOCIETE_DISABLE_CUSTOMERS)) $url=DOL_URL_ROOT."/comm/fiche.php?socid=".$object->id;
                    else if ($object->fournisseur == 1) $url=DOL_URL_ROOT."/fourn/fiche.php?socid=".$object->id;
                    Header("Location: ".$url);
                    exit;
                }
                else
                {
                    $db->rollback();
                    $action='create';
                }
            }

            if ($action == 'update')
            {
                if ($_POST["cancel"])
                {
                    Header("Location: ".$_SERVER["PHP_SELF"]."?socid=".$socid);
                    exit;
                }

                $object->oldcopy=dol_clone($object);

                // To not set code if third party is not concerned. But if it had values, we keep them.
                if (empty($object->client) && empty($object->oldcopy->code_client))          $object->code_client='';
                if (empty($object->fournisseur)&& empty($object->oldcopy->code_fournisseur)) $object->code_fournisseur='';
                //var_dump($soc);exit;

                $result = $object->update($socid,$user,1,$object->oldcopy->codeclient_modifiable(),$object->oldcopy->codefournisseur_modifiable());
                if ($result <=  0)
                {
                    $error = $object->error; $errors = $object->errors;
                }

                ### Gestion du logo de la société
                $dir     = $conf->societe->dir_output."/".$object->id."/logos";
                $file_OK = is_uploaded_file($_FILES['photo']['tmp_name']);
                if ($file_OK)
                {
                    if (GETPOST('deletephoto'))
                    {
                        $fileimg=$conf->societe->dir_output.'/'.$object->id.'/logos/'.$object->logo;
                        $dirthumbs=$conf->societe->dir_output.'/'.$object->id.'/logos/thumbs';
                        dol_delete_file($fileimg);
                        dol_delete_dir_recursive($dirthumbs);
                    }

                    if (image_format_supported($_FILES['photo']['name']) > 0)
                    {
                        dol_mkdir($dir);

                        if (@is_dir($dir))
                        {
                            $newfile=$dir.'/'.dol_sanitizeFileName($_FILES['photo']['name']);
                            $result = dol_move_uploaded_file($_FILES['photo']['tmp_name'], $newfile, 1);

                            if (! $result > 0)
                            {
                                $errors[] = "ErrorFailedToSaveFile";
                            }
                            else
                            {
                                // Create small thumbs for company (Ratio is near 16/9)
                                // Used on logon for example
                                $imgThumbSmall = vignette($newfile, $maxwidthsmall, $maxheightsmall, '_small', $quality);

                                // Create mini thumbs for company (Ratio is near 16/9)
                                // Used on menu or for setup page for example
                                $imgThumbMini = vignette($newfile, $maxwidthmini, $maxheightmini, '_mini', $quality);
                            }
                        }
                    }
                    else
                    {
                        $errors[] = "ErrorBadImageFormat";
                    }
                }
                ### Gestion du logo de la société

                if (! $error && ! sizeof($errors))
                {

                    Header("Location: ".$_SERVER["PHP_SELF"]."?socid=".$socid);
                    exit;
                }
                else
                {
                    $object->id = $socid;
                    $action= "edit";
                }
            }
        }
    }

    // Delete third party
    if ($action == 'confirm_delete' && $confirm == 'yes' && $user->rights->societe->supprimer)
    {
        $object->fetch($socid);
        $result = $object->delete($socid);

        if ($result >= 0)
        {
            Header("Location: ".DOL_URL_ROOT."/societe/societe.php?delsoc=".$object->nom."");
            exit;
        }
        else
        {
            $langs->load("errors");
            $error=$langs->trans($object->error); $errors = $object->errors;
            $action='';
        }
    }


    /*
     * Generate document
     */
    if ($action == 'builddoc')  // En get ou en post
    {
        if (is_numeric(GETPOST('model')))
        {
            $error=$langs->trans("ErrorFieldRequired",$langs->transnoentities("Model"));
        }
        else
        {
            require_once(DOL_DOCUMENT_ROOT.'/includes/modules/societe/modules_societe.class.php');

            $object->fetch($socid);
            $object->fetch_thirdparty();

            // Define output language
            $outputlangs = $langs;
            $newlang='';
            if ($conf->global->MAIN_MULTILANGS && empty($newlang) && ! empty($_REQUEST['lang_id'])) $newlang=$_REQUEST['lang_id'];
            if ($conf->global->MAIN_MULTILANGS && empty($newlang)) $newlang=$fac->client->default_lang;
            if (! empty($newlang))
            {
                $outputlangs = new Translate("",$conf);
                $outputlangs->setDefaultLang($newlang);
            }
            $result=thirdparty_doc_create($db, $object->id, '', $_REQUEST['model'], $outputlangs);
            if ($result <= 0)
            {
                dol_print_error($db,$result);
                exit;
            }
            else
            {
                Header ('Location: '.$_SERVER["PHP_SELF"].'?socid='.$object->id.(empty($conf->global->MAIN_JUMP_TAG)?'':'#builddoc'));
                exit;
            }
        }
    }
}



/*
 *  View
 */

// fetch optionals attributes and labels
$extralabels=$extrafields->fetch_name_optionals_label('company');

$help_url='EN:Module_Third_Parties|FR:Module_Tiers|ES:Empresas';
llxHeader('',$langs->trans("ThirdParty"),$help_url);

$form = new Form($db);
$formfile = new FormFile($db);
$formadmin = new FormAdmin($db);
$formcompany = new FormCompany($db);

$countrynotdefined=$langs->trans("ErrorSetACountryFirst").' ('.$langs->trans("SeeAbove").')';

if (is_object($objcanvas) && $objcanvas->displayCanvasExists($action))
{
    // -----------------------------------------
    // When used with CANVAS
    // -----------------------------------------
    if ($action == 'create')
    {
        $objcanvas->assign_post();              // TODO: Put code of assign_post into assign_values to keep only assign_values
        $objcanvas->assign_values($action);     // Set value for templates
        $objcanvas->display_canvas($action,0);  // Show template
    }
    elseif ($action == 'edit')
    {
        $objcanvas->control->object=$objcanvas->getObject($socid);  // TODO: Getting and storing object should be done into assign_values (for template with no code) or into tpl
        if (empty($objcanvas->control->object))
        {
            $object = new Societe($db);
            $object->fetch($socid);
            $objcanvas->control->object=$object;
        }
        $objcanvas->assign_post();              // TODO: Put code of assign_post into assign_values to keep only assign_values
        $objcanvas->assign_values($action);     // Set value for templates
        $objcanvas->display_canvas($action);    // Show template
    }
    else
    {
        $objcanvas->control->object=$objcanvas->getObject($socid);  // TODO: Getting and storing object should be done into assign_values (for template with no code) or into tpl
        if (empty($objcanvas->control->object))
        {
            $object = new Societe($db);
            $object->fetch($socid);
            $objcanvas->control->object=$object;
        }
        $objcanvas->assign_values('view');
        $objcanvas->display_canvas('view');  	// Show template
    }
}
else
{
    // -----------------------------------------
    // When used in standard mode
    // -----------------------------------------
    if ($action == 'create')
    {
        /*
         *  Creation
         */

        // Load object modCodeTiers
        $module=$conf->global->SOCIETE_CODECLIENT_ADDON;
        if (! $module) dolibarr_error('',$langs->trans("ErrorModuleThirdPartyCodeInCompanyModuleNotDefined"));
        if (substr($module, 0, 15) == 'mod_codeclient_' && substr($module, -3) == 'php')
        {
            $module = substr($module, 0, dol_strlen($module)-4);
        }
        require_once(DOL_DOCUMENT_ROOT ."/includes/modules/societe/".$module.".php");
        $modCodeClient = new $module;
        $module=$conf->global->SOCIETE_CODEFOURNISSEUR_ADDON;
        if (! $module) $module=$conf->global->SOCIETE_CODECLIENT_ADDON;
        if (substr($module, 0, 15) == 'mod_codeclient_' && substr($module, -3) == 'php')
        {
            $module = substr($module, 0, dol_strlen($module)-4);
        }
        require_once(DOL_DOCUMENT_ROOT ."/includes/modules/societe/".$module.".php");
        $modCodeFournisseur = new $module;

        //if ($_GET["type"]=='cp') { $object->client=3; }
        if (GETPOST("type")!='f') $object->client=3;
        if (GETPOST("type")=='c')  { $object->client=1; }
        if (GETPOST("type")=='p')  { $object->client=2; }
        if ($conf->fournisseur->enabled && (GETPOST("type")=='f' || GETPOST("type")==''))  { $object->fournisseur=1; }
        if (GETPOST("private")==1) { $object->particulier=1; }

        $object->name=$_POST["nom"];
        $object->nom=$_POST["nom"];    // deprecated
        $object->prenom=$_POST["prenom"];
        $object->particulier=$_REQUEST["private"];
        $object->prefix_comm=$_POST["prefix_comm"];
        $object->client=$_POST["client"]?$_POST["client"]:$object->client;
        $object->code_client=$_POST["code_client"];
        $object->fournisseur=$_POST["fournisseur"]?$_POST["fournisseur"]:$object->fournisseur;
        $object->code_fournisseur=$_POST["code_fournisseur"];
        $object->adresse=$_POST["adresse"]; // TODO obsolete
        $object->address=$_POST["adresse"];
        $object->cp=$_POST["cp"];
        $object->ville=$_POST["town"];
        $object->departement_id=$_POST["departement_id"];
        $object->tel=$_POST["tel"];
        $object->fax=$_POST["fax"];
        $object->email=$_POST["email"];
        $object->url=$_POST["url"];
        $object->capital=$_POST["capital"];
        $object->gencod=$_POST["gencod"];
        $object->siren=$_POST["idprof1"];
        $object->siret=$_POST["idprof2"];
        $object->ape=$_POST["idprof3"];
        $object->idprof4=$_POST["idprof4"];
        $object->typent_id=$_POST["typent_id"];
        $object->effectif_id=$_POST["effectif_id"];
		
		//recebe os novos campos
		$object->rua					= $_POST["rua"];
		$object->numero					= $_POST["numero"];
		$object->complemento			= $_POST["complemento"];
		$object->bairro					= $_POST["bairro"];
		$object->cpf_cnpj				= $_POST["cpf_cnpj"];
		$object->como_conheceu          = $_POST["como_conheceu"];
		$object->tipo_fornecedor		= $_POST["tipo_fornecedor"];
		$object->email_2				= $_POST["email_2"];
		$object->ponto_ref				= $_POST["ponto_ref"];
		$object->tel1_soli				= $_POST["tel1_soli"];
		$object->tel2_soli				= $_POST["tel2_soli"];

        $object->tva_assuj = $_POST["assujtva_value"];
        $object->status= $_POST["status"];

        //Local Taxes
        $object->localtax1_assuj       = $_POST["localtax1assuj_value"];
        $object->localtax2_assuj       = $_POST["localtax2assuj_value"];

        $object->tva_intra=$_POST["tva_intra"];

        $object->commercial_id=$_POST["commercial_id"];
        $object->default_lang=$_POST["default_lang"];

        $object->logo = dol_sanitizeFileName($_FILES['photo']['name']);

        ### Gestion du logo de la société
        $dir     = $conf->societe->dir_output."/".$object->id."/logos";
        $file_OK = is_uploaded_file($_FILES['photo']['tmp_name']);
        if ($file_OK)
        {
            if (image_format_supported($_FILES['photo']['name']))
            {
                create_exdir($dir);

                if (@is_dir($dir))
                {
                    $newfile=$dir.'/'.dol_sanitizeFileName($_FILES['photo']['name']);
                    $result = dol_move_uploaded_file($_FILES['photo']['tmp_name'], $newfile, 1);

                    if (! $result > 0)
                    {
                        $errors[] = "ErrorFailedToSaveFile";
                    }
                    else
                    {
                        // Create small thumbs for company (Ratio is near 16/9)
                        // Used on logon for example
                        $imgThumbSmall = vignette($newfile, $maxwidthsmall, $maxheightsmall, '_small', $quality);

                        // Create mini thumbs for company (Ratio is near 16/9)
                        // Used on menu or for setup page for example
                        $imgThumbMini = vignette($newfile, $maxwidthmini, $maxheightmini, '_mini', $quality);
                    }
                }
            }
        }
        ### Gestion du logo de la société

        // We set pays_id, pays_code and label for the selected country
        $object->pays_id=$_POST["pays_id"]?$_POST["pays_id"]:$mysoc->pays_id;
        if ($object->pays_id)
        {
            $sql = "SELECT code, libelle";
            $sql.= " FROM ".MAIN_DB_PREFIX."c_pays";
            $sql.= " WHERE rowid = ".$object->pays_id;
            $resql=$db->query($sql);
            if ($resql)
            {
                $obj = $db->fetch_object($resql);
            }
            else
            {
                dol_print_error($db);
            }
            $object->pays_code=$obj->code;
            $object->pays=$obj->libelle;
        }
        $object->forme_juridique_code=$_POST['forme_juridique_code'];

        //verifica se é fornecedor
		$type = GETPOST("type");
		/* Show create form */
		
		if ($type!='f') {
			print_fiche_titre($langs->trans("NewCompany"));
		} else {
			print_fiche_titre($langs->trans("NewThirdParty"));
		}
//		removido o radio de escolha de empresa ou particular
//        if ($conf->use_javascript_ajax)
//        {
//            print "\n".'<script type="text/javascript" language="javascript">';
//            print 'jQuery(document).ready(function () {
//						id_te_private=8;
//                        id_ef15=1;
//                        is_private='.(GETPOST("private")?GETPOST("private"):0).';
//						if (is_private) {
//							jQuery(".individualline").show();
//						} else {
//							jQuery(".individualline").hide();
//						}
//                         jQuery("#radiocompany").click(function() {
//                               jQuery(".individualline").hide();
//                               jQuery("#typent_id").val(0);
//                               jQuery("#effectif_id").val(0);
//                               jQuery("#TypeName").html(document.formsoc.ThirdPartyName.value);
//                               document.formsoc.private.value=0;
//                         });
//                          jQuery("#radioprivate").click(function() {
//                               jQuery(".individualline").show();
//                               jQuery("#typent_id").val(id_te_private);
//                               jQuery("#effectif_id").val(id_ef15);
//                               jQuery("#TypeName").html(document.formsoc.LastName.value);
//                               document.formsoc.private.value=1;
//                         });
//                         jQuery("#selectpays_id").change(function() {
//                           document.formsoc.action.value="create";
//                           document.formsoc.submit();
//                         });
//                     });';
//            print '</script>'."\n";
//
//            print "<br>\n";
//            print $langs->trans("ThirdPartyType").': &nbsp; ';
//            print '<input type="radio" id="radiocompany" class="flat" name="private" value="0"'.(! GETPOST("private")?' checked="true"':'');
//            print '> '.$langs->trans("Company/Fundation");
//            print ' &nbsp; &nbsp; ';
//            print '<input type="radio" id="radioprivate" class="flat" name="private" value="1"'.(! GETPOST("private")?'':' checked="true"');
//            print '> '.$langs->trans("Individual");
//            print ' ('.$langs->trans("ToCreateContactWithSameName").')';
//            print "<br>\n";
//            print "<br>\n";
//        }


        dol_htmloutput_errors($error,$errors);

        print '<form enctype="multipart/form-data" action="'.$_SERVER["PHP_SELF"].'" method="post" name="formsoc">';

        print '<input type="hidden" name="action" value="add">';
        print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
        print '<input type="hidden" name="private" value='.$object->particulier.'>';
        print '<input type="hidden" name="type" value='.GETPOST("type").'>';
        print '<input type="hidden" name="LastName" value="'.$langs->trans('LastName').'">';
        print '<input type="hidden" name="ThirdPartyName" value="'.$langs->trans('ThirdPartyName').'">';
        if ($modCodeClient->code_auto || $modCodeFournisseur->code_auto) print '<input type="hidden" name="code_auto" value="1">';

        print '<table class="border" width="100%">';

		//função que faz a consulta do cep
		echo '	<script>
				function getEndereco() {
				//limpa os campos
				$("#rua").val("");
				$("#bairro").val("");
				$("#departement_id").val("");
				$("#ville").val("");
				// Se o campo CEP não estiver vazio
				if($.trim($("#cp").val()) != ""){
				/*
				Para conectar no serviço e executar o json, precisamos usar a função
				getScript do jQuery, o getScript e o dataType:"jsonp" conseguem fazer o cross-domain, os outros
				dataTypes não possibilitam esta interação entre domínios diferentes
				Estou chamando a url do serviço passando o parâmetro "formato=javascript" e o CEP digitado no formulário
				http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cp").val()
				*/
				$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cp").val(), function(){
				// o getScript dá um eval no script, então é só ler!
				//Se o resultado for igual a 1
				if(resultadoCEP["resultado"]){
				// troca o valor dos elementos
				$("#rua").val(unescape(resultadoCEP["logradouro"]));
				$("#bairro").val(unescape(resultadoCEP["bairro"]));
				$("#ville").val(unescape(resultadoCEP["cidade"]));
				$("#departement_id").val(unescape(resultadoCEP["uf"]));
				}else{
				$("#rua").val("Endereço não encontrado");
				}
				if ($("#rua").val() == ""){
				$("#rua").val("Endereço não encontrado");
				}
				});
				}
				}
				</script>';


        // Name, firstname
		if ($type=='f') {  //é cadastro de fornecedor
			//Tipo de fornecedor, cadastro
			print '<tr><td class="fieldrequired">'.$langs->trans('TipoFW').'</td><td colspan="3">';
			print '<select name="tipo_fornecedor" id"tipo_fornecedor">';
			print '<option value="">';
			$texto = 'Material de acabamento';
			print '<option> '. $texto;
			$texto = 'Material básico';
			print '<option> '. $texto;
			$texto = 'Material elétrico/Dados/Telefonia';
			print '<option> '. $texto;
			$texto = 'Material hidráulico';
			print '<option> '. $texto;
			$texto = 'Equipamentos e ferramentas';
			print '<option> '. $texto;
			$texto = 'Esquadrias';
			print '<option> '. $texto;
			$texto = 'Impermeabilizações';
			print '<option> '. $texto;
			$texto = 'Alimentação';
			print '<option> '. $texto;
			$texto = 'Depósitos/Atacadistas';
			print '<option> '. $texto;
			$texto = 'Serviços';
			print '<option> '. $texto;
			print '</select>';
			print '</td>';
			print '</tr>';
			
			
			//razão social
			print '<tr><td><span span id="TypeName" class="fieldrequired">'. $langs->trans('CompanyName').'</span></td><td><input type="text" size="70" maxlength="259" name="nom" value="'.$object->nom.'"></td>';
			
			//nome da empresa, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('nomeEmpW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="80" name="idprof4" value="'. $object->idprof4 .'"></td>';
			print '</tr>';
			

			//seta o select fornecedor para sim, oculto
			print '<input type="hidden" name="fournisseur" value ="1">';	
			// código do fornecedor
			print '<td>'.$langs->trans('SupplierCode').'</td><td>';
			print '<table class="nobordernopadding"><tr><td>';
			$tmpcode=$object->code_fournisseur;
			if ($modCodeFournisseur->code_auto) $tmpcode=$modCodeFournisseur->getNextValue($object,1);
			  print '<input type="text" name="code_fournisseur" size="16" value="'.$tmpcode.'" maxlength="15">';
			  print '</td><td>';
			  $s=$modCodeFournisseur->getToolTip($langs,$object,1);
			  print $form->textwithpicto('',$s,1);
			  print '</td></tr></table>';
			  print '</td></tr>';
			
			//cnpj, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('cnpjW').'</td>';
			print '<td colspan="3"><input type="text" size="20" maxlength="50" name="cpf_cnpj" value="'. $object->cpf_cnpj .'"></td>';			
			print '</tr>';
			//insc estadual, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('inscW').'</td>';
			print '<td colspan="3"><input type="text" size="20" maxlength="50" name="idprof3" value="'. $object->idprof3 .'"></td>';			
			print '</tr>';
			//insc municipal, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('inscW1').'</td>';
			print '<td colspan="3"><input type="text" size="20" maxlength="50" name="idprof1" value="'. $object->idprof1 .'"></td>';			
			print '</tr>';
			//endereço completo
			//CEP, cadastro
			print '<tr><td>'. $langs->trans('CEPW').'</td>';
			print '<td colspan="3"><input type="text" size="10" onBlur="getEndereco();" maxlength="10" name="cp" id="cp" value="'. $object->cp .'">
					<input type="button" class="button" value="Buscar CEP" onclick="getEndereco(); ">
					</td>';			
			print '</tr>';
			//rua, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('RuaW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="260" name="rua" id="rua" value="'. $object->rua .'"></td>';			
			print '</tr>';	
			//numemro, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('NumW').'</td>';
			print '<td colspan="3"><input type="text" size="10" maxlength="10" name="numero" id="numero" value="'. $object->numero .'"></td>';			
			print '</tr>';
			//complemento, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('ComplementoW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="10" name="complemento" id="complemento" value="'. $object->complemento .'"></td>';			
			print '</tr>';	
			//bairro, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('BairroW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="100" name="bairro" id="bairro" value="'. $object->bairro .'"></td>';			
			print '</tr>';
			//cidade	
			print '</td><td>'.$langs->trans('CidadeW').'</td><td colspan="3">';
			print '<input type="text" size="70" maxlength="100" name="ville" id="ville" value="'. $object->ville .'">';
			print '</td></tr>';
			// Telefones
			print '<tr><td>'.$langs->trans('Tel1W').'</td><td colspan="3"><input type="text" name="tel" size="10" maxlength="20" value="'.$object->tel.'"></td></tr>';
			print '<tr><td>'.$langs->trans('Tel2W').'</td><td colspan="3"><input type="text" name="tel1_soli" size="10" maxlength="15" value="'.$object->tel1_soli.'"></td></tr>';
			print '<tr><td>'.$langs->trans('Tel3W').'</td><td colspan="3"><input type="text" name="tel2_soli" size="10" maxlength="15" value="'.$object->tel2_soli.'"></td></tr></tr>';
			print '<tr><td>'.$langs->trans('Fax').'</td><td colspan="3"><input type="text" name="fax" size="10" maxlength="20" value="'.$object->fax.'"></td></tr></tr>';
			
			//contato, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('Contact').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="259" name="idprof2" value="'. $object->siret .'"></td>';		
			print '</tr>';
			//e-mail, cadastro
			print '<tr><td>'.$langs->trans('EmailW').'</td><td colspan="3"><input type="text" name="email" size="70" maxlength="128" value="'.$object->email.'"></td></tr>';
			
			// Status
			print '<input type="hidden" name="status" value ="1">';
			
			//seta icms padrao não
			print '<input type="hidden" name="tva_intra" value ="2">';
			
			print '<tr><td colspan="4" align="center">';
			print '<input type="submit" class="button" value="'.$langs->trans('AddThirdParty').'">';
			print '</td></tr>'."\n";
			
			print '</table>'."\n";
			print '</form>'."\n";
			
        }
        else
        {	//alterado para kurt, formulário de cadastro de clientes
		
			// Tipo: Cliente, cliente potencial
			print '<tr><td width="25%"><span class="fieldrequired">'.$langs->trans('ProspectCustomer').'</span></td><td width="25%" colspan="3"><select class="flat" name="client">';
			if (empty($conf->global->SOCIETE_DISABLE_PROSPECTS)) print '<option value="2"'.($object->client==2?' selected="selected"':'').'>'.$langs->trans('Prospect').'</option>';
			//if (empty($conf->global->SOCIETE_DISABLE_PROSPECTS)) print '<option value="3"'.($object->client==3?' selected="selected"':'').'>'.$langs->trans('ProspectCustomer').'</option>';
			print '<option value="1"'.($object->client==1?' selected="selected"':'').'>'.$langs->trans('Customer').'</option>';
			//print '<option value="0"'.($object->client==0?' selected="selected"':'').'>'.$langs->trans('NorProspectNorCustomer').'</option>';
			print '</select></td>';
			
			print '</td></tr>';
		
			//nome do cliente
			print '<tr><td><span span id="TypeName" class="fieldrequired">'. $langs->trans('NomeClienteW').'</span></td><td><input type="text" size="70" maxlength="259" name="nom" value="'.$object->nom.'"></td>';
	
			//código do cliente
			print '<td width="25%">'.$langs->trans('CustomerCode').'</td><td width="25%">';
			print '<table class="nobordernopadding"><tr><td>';
			$tmpcode=$object->code_client;
			if ($modCodeClient->code_auto) $tmpcode=$modCodeClient->getNextValue($object,0);
			print '<input type="text" name="code_client" size="16" value="'.$tmpcode.'" maxlength="15">';
			print '</td><td>';
			$s=$modCodeClient->getToolTip($langs,$object,0);
			print $form->textwithpicto('',$s,1);
			print '</td></tr></table>';
	
			//tipo de cliente
			print '<tr><td><span span id="TypeName" class="fieldrequired">'. $langs->trans('TipoClienteW').'</span></td><td colspan="3"><select name="prefix_comm">
					<option value="Edifício">Edifício</option>
					<option value="Casa">Casa</option>
					<option value="Apto">Apto</option>
					<option value="Empresa">Empresa</option>
					<option value="Galpão">Galpão</option>
					<option value="Salas/Lojas">Salas/Lojas</option>
			</select>';
			//<input type="text" size="30" maxlength="49" name="prefix_comm" value="'.$object->prefix_comm.'"></td></tr>';
			
//			// Telefones
//			print '<tr><td>'.$langs->trans('Tel1W').'</td><td colspan="3"><input type="text" name="tel" size="10" maxlength="20" value="'.$object->tel.'"></td></tr>';
//			print '<tr><td>'.$langs->trans('Tel2W').'</td><td colspan="3"><input type="text" name="fax" size="10" maxlength="20" value="'.$object->fax.'"></td></tr></tr>';
//			
//			//e-mail / web
//			print '<tr><td>'.$langs->trans('EmailW').'</td><td colspan="3"><input type="text" name="email" size="70" maxlength="128" value="'.$object->email.'"></td></tr>';
			
			//cpf_cnpj, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('cpf_cnpjW').'</td>';
			print '<td colspan="3"><input type="checkbox" name="cpf_cnpj" value="1"></td>';			
			print '</tr>';
			
			//nome do solicitante, cadastro
			print '</tr>';
			print '<tr><td><span span id="TypeName" class="fieldrequired">'. $langs->trans('NomeSolicitanteW').'</span></td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="259" name="idprof2" value="'. $object->siret .'"></td>';
			print '</tr>';
			
			//status do solicitante, cadastro
			print '<tr><td><span span id="TypeName" class="fieldrequired">'. $langs->trans('StatusW').'</span></td><td colspan="3">
					<select name="idprof4">
					<option value="Condômino">Condômino</option>
					<option value="Síndico">Síndico</option>
					<option value="Comissão de obra">Comissão de obra</option>
					<option value="Outros">Outros</option>
					</select>';
			print '</td>';
			print '</tr>';	
			
			
			// Telefones solicitante
			print '<tr><td>'.$langs->trans('Tel1W').'</td><td colspan="3"><input type="text" name="tel1_soli" size="10" maxlength="15" value="'.$object->tel1_soli.'"></td></tr>';
			print '<tr><td>'.$langs->trans('Tel2W').'</td><td colspan="3"><input type="text" name="tel2_soli" size="10" maxlength="15" value="'.$object->tel2_soli.'"></td></tr></tr>';
			
			//e-mail solicitante/ web
			print '<tr><td>'.$langs->trans('Email2W').'</td><td colspan="3"><input type="text" name="email_2" size="70" maxlength="128" value="'.$object->email_2.'"></td></tr>';	

			//num apartamentos, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('NumAptoW').'</td>';
			print '<td colspan="3"><input type="text" size="10" maxlength="10" name="idprof3" value="'. $object->ape .'"></td>';			
			print '</tr>';	
			//num pavimentos, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('NumPavW').'</td>';
			print '<td colspan="3"><input type="text" size="10" maxlength="10" name="idprof1" value="'. $object->siren .'"></td>';			
			print '</tr>';	

			//endereço completo
			//CEP, cadastro
			print '<tr><td>'. $langs->trans('CEPW').'</td>';
			print '<td colspan="3"><input type="text" size="10" onBlur="getEndereco();" maxlength="10" name="cp" id="cp" value="'. $object->cp .'">
					<input type="button" class="button" value="Buscar CEP" onclick="getEndereco(); ">
					</td>';			
			print '</tr>';			
			//rua, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('RuaW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="260" name="rua" id="rua" value="'. $object->rua .'"></td>';			
			print '</tr>';	
			//numemro, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('NumW').'</td>';
			print '<td colspan="3"><input type="text" size="10" maxlength="10" name="numero" id="numero" value="'. $object->numero .'"></td>';			
			print '</tr>';
			//complemento, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('ComplementoW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="100" name="complemento" value="'. $object->complemento .'"></td>';			
			print '</tr>';	
			//bairro, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('BairroW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="100" name="bairro" id="bairro" value="'. $object->bairro .'"></td>';			
			print '</tr>';

			// país
			print '<input type="hidden" name="pays_id" value="56">'; 
//			print '<tr><td width="25%">'.$langs->trans('Country').'</td><td colspan="3">';
//			$form->select_pays($object->pays_id,'pays_id');
//			if ($user->admin) print info_admin($langs->trans("YouCanChangeValuesForThisListFromDictionnarySetup"),1);
//			print '</td></tr>';
			
			// EStado
			print '<input type="hidden" name="departement_id" id="departement_id" value="1111">'; 
//			if (empty($conf->global->SOCIETE_DISABLE_STATE))
//			{
//				print '<tr><td>'.$langs->trans('EstadoW').'</td><td colspan="3">';
//				if ($object->pays_id) $formcompany->select_departement($object->departement_id,$object->pays_code);
//				else print $countrynotdefined;
//				print '</td></tr>';
//			}
			//cidade	
			print '</td><td>'.$langs->trans('CidadeW').'</td><td colspan="3">';
			print '<input type="text" size="70" maxlength="100" name="ville" id="ville" value="'. $object->ville .'">';
			print '</td></tr>';
			
			//ponto de referencia
			print '</td><td>'.$langs->trans('PontoRefW').'</td><td colspan="3">';
			print '<input type="text" size="70" maxlength="200" name="ponto_ref" id="ponto_ref" value="'. $object->ponto_ref .'">';
			print '</td></tr>';	

			//print '<td>'.$langs->trans('Web').'</td><td><input type="text" name="url" size="32" value="'.$object->url.'"></td></tr>';
			// Como nos conheceu
			print '<tr><td class="fieldrequired">'.$langs->trans('ConheceuW').'</td><td colspan="3">'.$object->como_conheceu;
			$texto = 'Jornal';
			print '<input type="checkbox" name="como_con[]" value="'. $texto .'"  /> '. $texto .'<br/>';
			$texto = 'Internet';
			print '<input type="checkbox" name="como_con[]" value="'. $texto .'"  /> '. $texto .'<br/>';
			$texto = 'Indicação';
			print '<input type="checkbox" name="como_con[]" value="'. $texto .'"  /> '. $texto .'<br/>';
			print '<input type="checkbox" name="como_con[]" value="Placa de obra"  /> Placa de obra<br/>';
			$texto = 'Veículos';
			print '<input type="checkbox" name="como_con[]" value="'. $texto .'"  /> '. $texto .'<br/>';
			$texto = 'Correspondência';
			print '<input type="checkbox" name="como_con[]" value="'. $texto .'"  /> '. $texto .'<br/>';
			print '<input type="checkbox" value="Outros:"  /> Outro: <input type="text" size="30" maxlength="10" name="como_con[]" id="como_con" value=""> <br/>';
			print '</td>';
			print '</tr>';
			
			// Status
			print '<input type="hidden" name="status" value ="1">';
			
			//seta icms padrao não
			print '<input type="hidden" name="tva_intra" value ="2">';
			
			if ($user->rights->societe->client->voir)
			{
				// Assign a Name
				print '<tr>';
				print '<td>'.$langs->trans("AllocateCommercial").'</td>';
				print '<td colspan="3">';
				$form->select_users($object->commercial_id,'commercial_id',1);
				print '</td></tr>';
			}
			
			
			print '<tr><td colspan="4" align="center">';
			print '<input type="submit" class="button" value="'.$langs->trans('CriarClienteW').'">';
			print '</td></tr>'."\n";
			
			print '</table>'."\n";
			print '</form>'."\n";
			

        }
//        // If javascript on, we show option individual
//        if ($conf->use_javascript_ajax)
//        {
//            print '<tr class="individualline"><td>'.$langs->trans('FirstName').'</td><td><input type="text" size="30" name="prenom" value="'.$object->firstname.'"></td>';
//            print '<td colspan=2>&nbsp;</td></tr>';
//            print '<tr class="individualline"><td>'.$langs->trans("UserTitle").'</td><td>';
//            print $formcompany->select_civilite($contact->civilite_id).'</td>';
//            print '<td colspan=2>&nbsp;</td></tr>';
//        }

//
//        if ($conf->fournisseur->enabled && ! empty($user->rights->fournisseur->lire))
//        {
//            // Supplier
//            print '<tr>';
//            print '<td><span class="fieldrequired">'.$langs->trans('Supplier').'</span></td><td>';
//            print $form->selectyesno("fournisseur",$object->fournisseur,1);
//            print '</td>';
//            print '<td>'.$langs->trans('SupplierCode').'</td><td>';
//            print '<table class="nobordernopadding"><tr><td>';
//            $tmpcode=$object->code_fournisseur;
//            if ($modCodeFournisseur->code_auto) $tmpcode=$modCodeFournisseur->getNextValue($object,1);
//            print '<input type="text" name="code_fournisseur" size="16" value="'.$tmpcode.'" maxlength="15">';
//            print '</td><td>';
//            $s=$modCodeFournisseur->getToolTip($langs,$object,1);
//            print $form->textwithpicto('',$s,1);
//            print '</td></tr></table>';
//            print '</td></tr>';
//
//            // Category
//            if ($object->fournisseur)
//            {
//                $load = $object->LoadSupplierCateg();
//                if ( $load == 0)
//                {
//                    if (sizeof($object->SupplierCategories) > 0)
//                    {
//                        print '<tr>';
//                        print '<td>'.$langs->trans('SupplierCategory').'</td><td colspan="3">';
//                        print $form->selectarray("fournisseur_categorie",$object->SupplierCategories,$_POST["fournisseur_categorie"],1);
//                        print '</td></tr>';
//                    }
//                }
//            }
//
//        }


//        print '<tr><td>'.$langs->trans('Status').'</td><td colspan="3">';
//        print $form->selectarray('status', array('0'=>$langs->trans('ActivityCeased'),'1'=>$langs->trans('InActivity')),1);
//        print '</td></tr>';

        // Barcode
//        if ($conf->global->MAIN_MODULE_BARCODE)
//        {
//            print '<tr><td>'.$langs->trans('Gencod').'</td><td colspan="3"><input type="text" name="gencod">';
//            print $object->gencod;
//            print '</textarea></td></tr>';
//        }

        // Address
//        print '<tr><td valign="top">'.$langs->trans('Address').'</td><td colspan="3"><textarea name="adresse" cols="40" rows="3" wrap="soft">';
//        print $object->address;
//        print '</textarea></td></tr>';

        /*print '<tr>';
        // IdProf1 (SIREN for France)
        $idprof=$langs->transcountry('ProfId1',$object->pays_code);
        if ($idprof!='-')
        {
            print '<td>'.$idprof.'</td><td>';
            print $formcompany->get_input_id_prof(1,'idprof1',$object->siren,$object->pays_code);
            print '</td>';
        }
        else print '<td>&nbsp;</td><td>&nbsp;</td>';
        // IdProf2 (SIRET for France)
        $idprof=$langs->transcountry('ProfId2',$object->pays_code);
        if ($idprof!='-')
        {
            print '<td>'.$idprof.'</td><td>';
            print $formcompany->get_input_id_prof(2,'idprof2',$object->siret,$object->pays_code);
            print '</td>';
        }
        else print '<td>&nbsp;</td><td>&nbsp;</td>';
        print '</tr>';
        print '<tr>';
        // IdProf3 (APE for France)
        $idprof=$langs->transcountry('ProfId3',$object->pays_code);
        if ($idprof!='-')
        {
            print '<td>'.$idprof.'</td><td>';
            print $formcompany->get_input_id_prof(3,'idprof3',$object->ape,$object->pays_code);
            print '</td>';
        }
        else print '<td>&nbsp;</td><td>&nbsp;</td>';
        // IdProf4 (NU for France)
        $idprof=$langs->transcountry('ProfId4',$object->pays_code);
        if ($idprof!='-')
        {
            print '<td>'.$idprof.'</td><td>';
            print $formcompany->get_input_id_prof(4,'idprof4',$object->idprof4,$object->pays_code);
            print '</td>';
        }
        else print '<td>&nbsp;</td><td>&nbsp;</td>';
        print '</tr>';*/

        // Assujeti TVA

       /* $html = new Form($db);
        print '<tr><td>'.$langs->trans('VATIsUsed').'</td>';
        print '<td>';
        print $html->selectyesno('assujtva_value',2,1);     // Assujeti par defaut en creation
        print '</td>';
        print '<td nowrap="nowrap">'.$langs->trans('VATIntra').'</td>';
        print '<td nowrap="nowrap">';
        $s = '<input type="text" class="flat" name="tva_intra" size="12" maxlength="20" value="'.$object->tva_intra.'">';

        if (empty($conf->global->MAIN_DISABLEVATCHECK))
        {
            $s.=' ';

            if ($conf->use_javascript_ajax)
            {
                print "\n";
                print '<script language="JavaScript" type="text/javascript">';
                print "function CheckVAT(a) {\n";
                print "newpopup('".DOL_URL_ROOT."/societe/checkvat/checkVatPopup.php?vatNumber='+a,'".dol_escape_js($langs->trans("VATIntraCheckableOnEUSite"))."',500,230);\n";
                print "}\n";
                print '</script>';
                print "\n";
                $s.='<a href="#" onclick="javascript: CheckVAT(document.formsoc.tva_intra.value);">'.$langs->trans("VATIntraCheck").'</a>';
                $s = $form->textwithpicto($s,$langs->trans("VATIntraCheckDesc",$langs->trans("VATIntraCheck")),1);
            }
            else
            {
                $s.='<a href="'.$langs->transcountry("VATIntraCheckURL",$object->id_pays).'" target="_blank">'.img_picto($langs->trans("VATIntraCheckableOnEUSite"),'help').'</a>';
            }
        }
        print $s;
        print '</td>';
        print '</tr>';*/

//        // Type - Size
//        print '<tr><td>'.$langs->trans("ThirdPartyType").'</td><td>'."\n";
//        print $form->selectarray("typent_id",$formcompany->typent_array(0), $object->typent_id);
//        if ($user->admin) print info_admin($langs->trans("YouCanChangeValuesForThisListFromDictionnarySetup"),1);
//        print '</td>';
//        print '<td>'.$langs->trans("Staff").'</td><td>';
//        print $form->selectarray("effectif_id",$formcompany->effectif_array(0), $object->effectif_id);
//        if ($user->admin) print info_admin($langs->trans("YouCanChangeValuesForThisListFromDictionnarySetup"),1);
//        print '</td></tr>';
//
//        // Legal Form
//        print '<tr><td>'.$langs->trans('JuridicalStatus').'</td>';
//        print '<td colspan="3">';
//        if ($object->pays_id)
//        {
//            $formcompany->select_forme_juridique($object->forme_juridique_code,$object->pays_code);
//        }
//        else
//        {
//            print $countrynotdefined;
//        }
//        print '</td></tr>';



        // Local Taxes
        // TODO add specific function by country
//        if($mysoc->pays_code=='ES')
//        {
//            if($mysoc->localtax1_assuj=="1" && $mysoc->localtax2_assuj=="1")
//            {
//                print '<tr><td>'.$langs->trans("LocalTax1IsUsedES").'</td><td>';
//                print $html->selectyesno('localtax1assuj_value',0,1);
//                print '</td><td>'.$langs->trans("LocalTax2IsUsedES").'</td><td>';
//                print $html->selectyesno('localtax2assuj_value',0,1);
//                print '</td></tr>';
//
//            }
//            elseif($mysoc->localtax1_assuj=="1")
//            {
//                print '<tr><td>'.$langs->trans("LocalTax1IsUsedES").'</td><td colspan="3">';
//                print $html->selectyesno('localtax1assuj_value',0,1);
//                print '</td><tr>';
//            }
//            elseif($mysoc->localtax2_assuj=="1")
//            {
//                print '<tr><td>'.$langs->trans("LocalTax2IsUsedES").'</td><td colspan="3">';
//                print $html->selectyesno('localtax2assuj_value',0,1);
//                print '</td><tr>';
//            }
//        }

//        if ($conf->global->MAIN_MULTILANGS)
//        {
//            print '<tr><td>'.$langs->trans("DefaultLang").'</td><td colspan="3">'."\n";
//            print $formadmin->select_language(($object->default_lang?$object->default_lang:$conf->global->MAIN_LANG_DEFAULT),'default_lang',0,0,1);
//            print '</td>';
//            print '</tr>';
//        }


//
//        // Other attributes
//        foreach($extrafields->attribute_label as $key=>$label)
//        {
//            $value=(isset($_POST["options_".$key])?$_POST["options_".$key]:'');
//            print "<tr><td>".$label.'</td><td colspan="3">';
//            print $extrafields->showInputField($key,$value);
//            print '</td></tr>'."\n";
//        }

//        // Ajout du logo
//        print '<tr>';
//        print '<td>'.$langs->trans("Logo").'</td>';
//        print '<td colspan="3">';
//        print '<input class="flat" type="file" name="photo" id="photoinput" />';
//        print '</td>';
//        print '</tr>';


    }
    elseif ($action == 'edit')
	{
		
		if ($socid)
		{
			$object = new Societe($db);
			$res=$object->fetch($socid);
			if ($res < 0) { dol_print_error($db,$object->error); exit; }
			$res=$object->fetch_optionals($socid,$extralabels);
			if ($res < 0) { dol_print_error($db); exit; }
			
			// Load object modCodeTiers
			$module=$conf->global->SOCIETE_CODECLIENT_ADDON;
			if (! $module) dolibarr_error('',$langs->trans("ErrorModuleThirdPartyCodeInCompanyModuleNotDefined"));
			if (substr($module, 0, 15) == 'mod_codeclient_' && substr($module, -3) == 'php')
			{
				$module = substr($module, 0, dol_strlen($module)-4);
			}
			require_once(DOL_DOCUMENT_ROOT ."/includes/modules/societe/".$module.".php");
			$modCodeClient = new $module;
			// We verified if the tag prefix is used
			if ($modCodeClient->code_auto)
			{
				$prefixCustomerIsUsed = $modCodeClient->verif_prefixIsUsed();
			}
			$module=$conf->global->SOCIETE_CODEFOURNISSEUR_ADDON;
			if (! $module) $module=$conf->global->SOCIETE_CODECLIENT_ADDON;
			if (substr($module, 0, 15) == 'mod_codeclient_' && substr($module, -3) == 'php')
			{
				$module = substr($module, 0, dol_strlen($module)-4);
			}
			require_once(DOL_DOCUMENT_ROOT ."/includes/modules/societe/".$module.".php");
			$modCodeFournisseur = new $module;
			// On verifie si la balise prefix est utilisee
			if ($modCodeFournisseur->code_auto)
			{
				$prefixSupplierIsUsed = $modCodeFournisseur->verif_prefixIsUsed();
			}
			
			if (! empty($_POST["nom"]))
			{
				// We overwrite with values if posted
				$object->name=$_POST["nom"];
				$object->nom=$_POST["nom"];    // deprecated
				$object->prefix_comm=$_POST["prefix_comm"];
				$object->client=$_POST["client"];
				$object->code_client=$_POST["code_client"];
				$object->fournisseur=$_POST["fournisseur"];
				$object->code_fournisseur=$_POST["code_fournisseur"];
				$object->adresse=$_POST["adresse"]; // TODO obsolete
				$object->address=$_POST["adresse"];
				$object->cp=$_POST["cp"];
				$object->ville=$_POST["town"];
				$object->pays_id=$_POST["pays_id"]?$_POST["pays_id"]:$mysoc->pays_id;
				$object->departement_id=$_POST["departement_id"];
				$object->tel=$_POST["tel"];
				$object->fax=$_POST["fax"];
				$object->email=$_POST["email"];
				$object->url=$_POST["url"];
				$object->capital=$_POST["capital"];
				$object->siren=$_POST["idprof1"];
				$object->siret=$_POST["idprof2"];
				$object->ape=$_POST["idprof3"];
				$object->idprof4=$_POST["idprof4"];
				$object->typent_id=$_POST["typent_id"];
				$object->effectif_id=$_POST["effectif_id"];
				$object->gencod=$_POST["gencod"];
				$object->forme_juridique_code=$_POST["forme_juridique_code"];
				$object->default_lang=$_POST["default_lang"];
				
				$object->tva_assuj = $_POST["assujtva_value"];
				$object->tva_intra=$_POST["tva_intra"];
				$object->status=$_POST["status"];
				
				
				//recebe os novos campos
				$object->rua					= $_POST["rua"];
				$object->numero					= $_POST["numero"];
				$object->complemento			= $_POST["complemento"];
				$object->bairro					= $_POST["bairro"];
				$object->cpf_cnpj				= $_POST["cpf_cnpj"];
				$object->como_conheceu          = $_POST["como_conheceu"];
				$object->tipo_fornecedor		= $_POST["tipo_fornecedor"];
				$object->email_2				= $_POST["email_2"];
				$object->ponto_ref				= $_POST["ponto_ref"];
				$object->tel1_soli				= $_POST["tel1_soli"];
				$object->tel2_soli				= $_POST["tel2_soli"];
				
				//Local Taxes
				$object->localtax1_assuj       = $_POST["localtax1assuj_value"];
				$object->localtax2_assuj       = $_POST["localtax2assuj_value"];
				
				// We set pays_id, and pays_code label of the chosen country
				if ($object->pays_id)
				{
					$sql = "SELECT code, libelle from ".MAIN_DB_PREFIX."c_pays where rowid = ".$object->pays_id;
					$resql=$db->query($sql);
					if ($resql)
					{
						$obj = $db->fetch_object($resql);
					}
					else
					{
						dol_print_error($db);
					}
					$object->pays_code=$obj->code;
					$object->pays=$langs->trans("Country".$obj->code)?$langs->trans("Country".$obj->code):$obj->libelle;
				}
			}
			
			dol_htmloutput_errors($error,$errors);
			
			
			$type = $object->code_fournisseur; //se tiver um código de fornecedor é edição de fornecedor
			
			if (!empty($type)) {  //é edição de fornecedor
				print_fiche_titre($langs->trans("editForW"));
			} else {
				print_fiche_titre($langs->trans("EditarClienteW"));
			}
			
			if ($conf->use_javascript_ajax)
			{
				print "\n".'<script type="text/javascript" language="javascript">';
				print 'jQuery(document).ready(function () {
						jQuery("#selectpays_id").change(function() {
						document.formsoc.action.value="edit";
						document.formsoc.submit();
						});
						})';
				print '</script>'."\n";
			}
			
			print '<form enctype="multipart/form-data" action="'.$_SERVER["PHP_SELF"].'?socid='.$object->id.'" method="post" name="formsoc">';
			print '<input type="hidden" name="action" value="update">';
			print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
			print '<input type="hidden" name="socid" value="'.$object->id.'">';
			if ($modCodeClient->code_auto || $modCodeFournisseur->code_auto) print '<input type="hidden" name="code_auto" value="1">';
			
			print '<table class="border" width="100%">';
		
		/*
		 * Edition
		 */
			//função que faz a consulta do cep
			echo '	<script>
					function getEndereco() {
					//limpa os campos
					$("#rua").val("");
					$("#bairro").val("");
					$("#departement_id").val("");
					$("#ville").val("");
					// Se o campo CEP não estiver vazio
					if($.trim($("#cp").val()) != ""){
					/*
					Para conectar no serviço e executar o json, precisamos usar a função
					getScript do jQuery, o getScript e o dataType:"jsonp" conseguem fazer o cross-domain, os outros
					dataTypes não possibilitam esta interação entre domínios diferentes
					Estou chamando a url do serviço passando o parâmetro "formato=javascript" e o CEP digitado no formulário
					http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cp").val()
					*/
					$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cp").val(), function(){
					// o getScript dá um eval no script, então é só ler!
					//Se o resultado for igual a 1
					if(resultadoCEP["resultado"]){
					// troca o valor dos elementos
					$("#rua").val(unescape(resultadoCEP["logradouro"]));
					$("#bairro").val(unescape(resultadoCEP["bairro"]));
					$("#ville").val(unescape(resultadoCEP["cidade"]));
					$("#departement_id").val(unescape(resultadoCEP["uf"]));
					}else{
					$("#rua").val("Endereço não encontrado");
					}
					if ($("#rua").val() == ""){
					$("#rua").val("Endereço não encontrado");
					}
					});
					}
					}
					</script>';
		$type = $object->code_fournisseur;
			if (!empty($type)) {  //é edição de fornecedor
				//Tipo de fornecedor, edição
				print '<tr><td class="fieldrequired">'.$langs->trans('TipoFW').'</td><td colspan="3">';
				print '<select name="tipo_fornecedor" id"tipo_fornecedor">';
				print '<option>';
				
				//condição que procura o valor do select para marcar a tela de edição de fornecedores KURT
				$tFornecedor = $object->tipo_fornecedor;
				$texto = 'Material de acabamento';
				if (strstr($tFornecedor, $texto )) {
					print '<option selected> '. $texto;					
					} else print '<option> '. $texto;					
				
				$texto = 'Material básico';
				if (strstr($tFornecedor, $texto )) {					
					print '<option selected> '. $texto;					
				} else print '<option > '. $texto;					
								
				$texto = 'Material elétrico/Dados/Telefonia';
				if (strstr($tFornecedor, $texto )) {					
					print '<option selected> '. $texto;					
				} else print '<option> '. $texto;					
				
				$texto = 'Material hidráulico';
				if (strstr($tFornecedor, $texto )) {					
					print '<option selected> '. $texto;					
				} else print '<option> '. $texto;					
				
				$texto = 'Equipamentos e ferramentas';
				if (strstr($tFornecedor, $texto )) {					
					print '<option selected> '. $texto;					
				} else print '<option> '. $texto;					
				
				$texto = 'Esquadrias';
				if (strstr($tFornecedor, $texto )) {					
					print '<option selected > '. $texto;					
				} else print '<option> '. $texto;					
				
				$texto = 'Impermeabilizações';
				if (strstr($tFornecedor, $texto )) {					
					print '<option selected> '. $texto;					
				} else print '<option> '. $texto;					
		
				$texto = 'Alimentação';
				if (strstr($tFornecedor, $texto )) {					
					print '<option selected> '. $texto;					
				} else print '<option> '. $texto;					

				$texto = 'Depósitos/Atacadistas';
				if (strstr($tFornecedor, $texto )) {					
					print '<option selected> '. $texto;					
				} else print '<option> '. $texto;					
				
				$texto = 'Serviços';
				if (strstr($tFornecedor, $texto )) {					
					print '<option selected> '. $texto;					
				} else print '<option> '. $texto;					
								
				print '</select>';
				print '</td>';
				print '</tr>';
			
			//razão social
			print '<tr><td><span span id="TypeName" class="fieldrequired">'. $langs->trans('CompanyName').'</span></td><td><input type="text" size="70" maxlength="259" name="nom" value="'.$object->nom.'"></td>';
			
			//nome da empresa, edição
			print '</tr>';
			print '<tr><td>'. $langs->trans('nomeEmpW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="80" name="idprof4" value="'. $object->idprof4 .'"></td>';
			print '</tr>';
			
			//seta o select fornecedor para sim, oculto
			print '<input type="hidden" name="fournisseur" value ="1">';	
			// código do fornecedor
			print '<td>'.$langs->trans('SupplierCode').'</td><td>';
			print '<table class="nobordernopadding"><tr><td>';
			$tmpcode=$object->code_fournisseur;
			if ($modCodeFournisseur->code_auto) $tmpcode=$modCodeFournisseur->getNextValue($object,1);
			print '<input type="text" name="code_fournisseur" size="16" value="'.$tmpcode.'" maxlength="15">';
			print '</td><td>';
			$s=$modCodeFournisseur->getToolTip($langs,$object,1);
			print $form->textwithpicto('',$s,1);
			print '</td></tr></table>';
			print '</td></tr>';
			
			//cnpj, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('cnpjW').'</td>';
			print '<td colspan="3"><input type="text" size="20" maxlength="50" name="cpf_cnpj" value="'. $object->cpf_cnpj .'"></td>';			
			print '</tr>';
			//insc estadual, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('inscW').'</td>';
			print '<td colspan="3"><input type="text" size="20" maxlength="50" name="idprof3" value="'. $object->idprof3 .'"></td>';			
			print '</tr>';
			//insc municipal, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('inscW1').'</td>';
			print '<td colspan="3"><input type="text" size="20" maxlength="50" name="idprof1" value="'. $object->idprof1 .'"></td>';			
			print '</tr>';
			//endereço completo
			//CEP, cadastro
			print '<tr><td>'. $langs->trans('CEPW').'</td>';
			print '<td colspan="3"><input type="text" size="10" onBlur="getEndereco();" maxlength="10" name="cp" id="cp" value="'. $object->cp .'">
					<input type="button" class="button" value="Buscar CEP" onclick="getEndereco(); ">
					</td>';			
			print '</tr>';
			//rua, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('RuaW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="260" name="rua" id="rua" value="'. $object->rua .'"></td>';			
			print '</tr>';	
			//numemro, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('NumW').'</td>';
			print '<td colspan="3"><input type="text" size="10" maxlength="10" name="numero" id="numero" value="'. $object->numero .'"></td>';			
			print '</tr>';
			//complemento, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('ComplementoW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="100" name="complemento" id="complemento" value="'. $object->complemento .'"></td>';			
			print '</tr>';	
			//bairro, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('BairroW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="100" name="bairro" id="bairro" value="'. $object->bairro .'"></td>';			
			print '</tr>';
			//cidade	
			print '</td><td>'.$langs->trans('CidadeW').'</td><td colspan="3">';
				print '<input type="text" size="70" maxlength="100" name="ville" id="ville" value="'. $object->ville .'">';
				print '</td></tr>';
			// Telefones
				print '<tr><td>'.$langs->trans('Tel1W').'</td><td colspan="3"><input type="text" name="tel" size="10" maxlength="20" value="'.$object->tel.'"></td></tr>';
				print '<tr><td>'.$langs->trans('Tel2W').'</td><td colspan="3"><input type="text" name="tel1_soli" size="10" maxlength="15" value="'.$object->tel1_soli.'"></td></tr>';
				print '<tr><td>'.$langs->trans('Tel3W').'</td><td colspan="3"><input type="text" name="tel2_soli" size="10" maxlength="15" value="'.$object->tel2_soli.'"></td></tr></tr>';
				print '<tr><td>'.$langs->trans('Fax').'</td><td colspan="3"><input type="text" name="fax" size="10" maxlength="20" value="'.$object->fax.'"></td></tr></tr>';
			
			//contato, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('Contact').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="259" name="idprof2" value="'. $object->siret .'"></td>';		
			print '</tr>';
			//e-mail, cadastro
			print '<tr><td>'.$langs->trans('EmailW').'</td><td colspan="3"><input type="text" name="email" size="70" maxlength="128" value="'.$object->email.'"></td></tr>';

			// Status
			print '<input type="hidden" name="status" value ="1">';
			
			//seta icms padrao não
			print '<input type="hidden" name="tva_intra" value ="2">';
			
			print '</table>';
			print '<br>';
			
			print '<center>';
			print '<input type="submit" class="button" name="save" value="'.$langs->trans("Save").'">';
			print ' &nbsp; &nbsp; ';
			print '<input type="submit" class="button" name="cancel" value="'.$langs->trans("Cancel").'">';
			print '</center>';
			
			print '</form>';
			
		}
			else {			
				
				//alterado para kurt, formulário de edição de clientes
				
				// Tipo: Cliente, cliente potencial
				print '<tr><td width="25%"><span class="fieldrequired">'.$langs->trans('ProspectCustomer').'</span></td><td width="25%" colspan="3"><select class="flat" name="client">';
				if (empty($conf->global->SOCIETE_DISABLE_PROSPECTS)) print '<option value="2"'.($object->client==2?' selected="selected"':'').'>'.$langs->trans('Prospect').'</option>';
				//if (empty($conf->global->SOCIETE_DISABLE_PROSPECTS)) print '<option value="3"'.($object->client==3?' selected="selected"':'').'>'.$langs->trans('ProspectCustomer').'</option>';
				print '<option value="1"'.($object->client==1?' selected="selected"':'').'>'.$langs->trans('Customer').'</option>';
				//print '<option value="0"'.($object->client==0?' selected="selected"':'').'>'.$langs->trans('NorProspectNorCustomer').'</option>';
				print '</select></td>';
				
				print '</td></tr>';
				
				//nome do cliente
				print '<tr><td><span span id="TypeName" class="fieldrequired">'. $langs->trans('NomeClienteW').'</span></td><td><input type="text" size="70" maxlength="259" name="nom" value="'.$object->nom.'"></td>';
				
				//código do cliente
				print '<td width="25%">'.$langs->trans('CustomerCode').'</td><td width="25%">';
				print '<table class="nobordernopadding"><tr><td>';
				$tmpcode=$object->code_client;
				if ($modCodeClient->code_auto) $tmpcode=$modCodeClient->getNextValue($object,0);
				print '<input type="text" name="code_client" size="16" value="'.$tmpcode.'" maxlength="15">';
				print '</td><td>';
				$s=$modCodeClient->getToolTip($langs,$object,0);
				print $form->textwithpicto('',$s,1);
				print '</td></tr></table>';
				
				//tipo de cliente
				print '<tr><td><span span id="TypeName" class="fieldrequired">'. $langs->trans('TipoClienteW').'</span></td><td colspan="3">
						<select name="prefix_comm">
						<option value="'.$object->prefix_comm.'">'.$object->prefix_comm.'</option>
						<option value="Edifício">Edifício</option>
						<option value="Casa">Casa</option>
						<option value="Apto">Apto</option>
						<option value="Empresa">Empresa</option>
						<option value="Galpão">Galpão</option>
						<option value="Salas/Lojas">Salas/Lojas</option>
						</select>';
				//<input type="text" size="30" maxlength="49" name="prefix_comm" value="'.$object->prefix_comm.'"></td></tr>';
				
				//retirado a pedido do Kurt
				//				// Telefones
				//				print '<tr><td>'.$langs->trans('Tel1W').'</td><td colspan="3"><input type="text" name="tel" size="10" maxlength="20" value="'.$object->tel.'"></td></tr>';
				//				print '<tr><td>'.$langs->trans('Tel2W').'</td><td colspan="3"><input type="text" name="fax" size="10" maxlength="20" value="'.$object->fax.'"></td></tr></tr>';
				//				
				//				//e-mail / web
				//				print '<tr><td>'.$langs->trans('EmailW').'</td><td colspan="3"><input type="text" name="email" size="70" maxlength="128" value="'.$object->email.'"></td></tr>';
				//				
				//cpf_cnpj, cadastro, passa a ser apenas um checkbox
				print '</tr>';
				print '<tr><td>'. $langs->trans('cpf_cnpjW').'</td>';
				if (isset($object->cpf_cnpj)){
					print '<td colspan="3"><input type="checkbox" name="cpf_cnpj" checked></td>';			
				}
				else {
					print '<td colspan="3"><input type="checkbox" name="cpf_cnpj"></td>';			
				}
				print '</tr>';
				
				//nome do solicitante, cadastro
				print '</tr>';
				print '<tr><td><span span id="TypeName" class="fieldrequired">'. $langs->trans('NomeSolicitanteW').'</span></td>';
				print '<td colspan="3"><input type="text" size="70" maxlength="259" name="idprof2" value="'. $object->siret .'"></td>';
				print '</tr>';
				//status do solicitante, cadastro
				print '<tr><td><span span id="TypeName" class="fieldrequired">'. $langs->trans('StatusW').'</span></td><td colspan="3">
						<select name="idprof4">
						<option value="'.$object->idprof4.'">'.$object->idprof4.'</option>
						<option value="Condômino">Condômino</option>
						<option value="Síndico">Síndico</option>
						<option value="Comissão de obra">Comissão de obra</option>
						<option value="Outros">Outros</option>
						</select>';
				print '</td>';
				print '</tr>';	
				
				// Telefones solicitante
				print '<tr><td>'.$langs->trans('Tel1W').'</td><td colspan="3"><input type="text" name="tel1_soli" size="10" maxlength="15" value="'.$object->tel1_soli.'"></td></tr>';
				print '<tr><td>'.$langs->trans('Tel2W').'</td><td colspan="3"><input type="text" name="tel2_soli" size="10" maxlength="15" value="'.$object->tel2_soli.'"></td></tr></tr>';
				
				//e-mail solicitante/ web
				print '<tr><td>'.$langs->trans('Email2W').'</td><td colspan="3"><input type="text" name="email_2" size="70" maxlength="128" value="'.$object->email_2.'"></td></tr>';
				
				//num apartamentos, cadastro
				print '</tr>';
				print '<tr><td>'. $langs->trans('NumAptoW').'</td>';
				print '<td colspan="3"><input type="text" size="10" maxlength="10" name="idprof3" value="'. $object->ape .'"></td>';			
				print '</tr>';	
				//num pavimentos, cadastro
				print '</tr>';
				print '<tr><td>'. $langs->trans('NumPavW').'</td>';
				print '<td colspan="3"><input type="text" size="10" maxlength="10" name="idprof1" value="'. $object->siren .'"></td>';			
				print '</tr>';	
				
				
				//endereço completo
				//CEP, cadastro
				print '<tr><td>'. $langs->trans('CEPW').'</td>';
				print '<td colspan="3"><input type="text" size="10" onBlur="getEndereco();" maxlength="10" name="cp" id="cp" value="'. $object->cp .'">
						<input type="button" class="button" value="Buscar CEP" onclick="getEndereco(); ">
						</td>';			
				print '</tr>';			
				//rua, cadastro
				print '</tr>';
				print '<tr><td>'. $langs->trans('RuaW').'</td>';
				print '<td colspan="3"><input type="text" size="70" maxlength="260" name="rua" id="rua" value="'. $object->rua .'"></td>';			
				print '</tr>';	
				//numemro, cadastro
				print '</tr>';
				print '<tr><td>'. $langs->trans('NumW').'</td>';
				print '<td colspan="3"><input type="text" size="10" maxlength="10" name="numero" id="numero" value="'. $object->numero .'"></td>';			
				print '</tr>';
				//complemento, cadastro
				print '</tr>';
				print '<tr><td>'. $langs->trans('ComplementoW').'</td>';
				print '<td colspan="3"><input type="text" size="70" maxlength="100" name="complemento" value="'. $object->complemento .'"></td>';			
				print '</tr>';	
				//bairro, cadastro
				print '</tr>';
				print '<tr><td>'. $langs->trans('BairroW').'</td>';
				print '<td colspan="3"><input type="text" size="70" maxlength="100" name="bairro" id="bairro" value="'. $object->bairro .'"></td>';			
				print '</tr>';
				// país
				print '<input type="hidden" name="pays_id" value="56">'; 
				//			print '<tr><td width="25%">'.$langs->trans('Country').'</td><td colspan="3">';
				//			$form->select_pays($object->pays_id,'pays_id');
				//			if ($user->admin) print info_admin($langs->trans("YouCanChangeValuesForThisListFromDictionnarySetup"),1);
				//			print '</td></tr>';
				
				// EStado
				print '<input type="hidden" name="departement_id" value="1111">'; 
				//			if (empty($conf->global->SOCIETE_DISABLE_STATE))
				//			{
				//				print '<tr><td>'.$langs->trans('EstadoW').'</td><td colspan="3">';
				//				if ($object->pays_id) $formcompany->select_departement($object->departement_id,$object->pays_code);
				//				else print $countrynotdefined;
				//				print '</td></tr>';
				//			}
				//cidade	
				print '</td><td>'.$langs->trans('CidadeW').'</td><td colspan="3">';
				print '<input type="text" size="70" maxlength="100" name="ville" id="ville" value="'. $object->ville .'">';
				print '</td></tr>';
				
				//ponto de referencia
				print '</td><td>'.$langs->trans('PontoRefW').'</td><td colspan="3">';
				print '<input type="text" size="70" maxlength="200" name="ponto_ref" id="ponto_ref" value="'. $object->ponto_ref .'">';
				print '</td></tr>';
				
				//print '<td>'.$langs->trans('Web').'</td><td><input type="text" name="url" size="32" value="'.$object->url.'"></td></tr>';
				
				// If javascript on, we show option individual
				//        if ($conf->use_javascript_ajax)
				//        {
				//            print '<tr class="individualline"><td>'.$langs->trans('FirstName').'</td><td><input type="text" size="30" name="prenom" value="'.$object->firstname.'"></td>';
				//            print '<td colspan=2>&nbsp;</td></tr>';
				//            print '<tr class="individualline"><td>'.$langs->trans("UserTitle").'</td><td>';
				//            print $formcompany->select_civilite($contact->civilite_id).'</td>';
				//            print '<td colspan=2>&nbsp;</td></tr>';
				//        }
				
				//
				//        if ($conf->fournisseur->enabled && ! empty($user->rights->fournisseur->lire))
				//        {
				//            // Supplier
				//            print '<tr>';
				//            print '<td><span class="fieldrequired">'.$langs->trans('Supplier').'</span></td><td>';
				//            print $form->selectyesno("fournisseur",$object->fournisseur,1);
				//            print '</td>';
				//            print '<td>'.$langs->trans('SupplierCode').'</td><td>';
				//            print '<table class="nobordernopadding"><tr><td>';
				//            $tmpcode=$object->code_fournisseur;
				//            if ($modCodeFournisseur->code_auto) $tmpcode=$modCodeFournisseur->getNextValue($object,1);
				//            print '<input type="text" name="code_fournisseur" size="16" value="'.$tmpcode.'" maxlength="15">';
				//            print '</td><td>';
				//            $s=$modCodeFournisseur->getToolTip($langs,$object,1);
				//            print $form->textwithpicto('',$s,1);
				//            print '</td></tr></table>';
				//            print '</td></tr>';
				//
				//            // Category
				//            if ($object->fournisseur)
				//            {
				//                $load = $object->LoadSupplierCateg();
				//                if ( $load == 0)
				//                {
				//                    if (sizeof($object->SupplierCategories) > 0)
				//                    {
				//                        print '<tr>';
				//                        print '<td>'.$langs->trans('SupplierCategory').'</td><td colspan="3">';
				//                        print $form->selectarray("fournisseur_categorie",$object->SupplierCategories,$_POST["fournisseur_categorie"],1);
				//                        print '</td></tr>';
				//                    }
				//                }
				//            }
				//
				//        }
				
				// Status
				print '<input type="hidden" name="status" value ="1">';
				//        print '<tr><td>'.$langs->trans('Status').'</td><td colspan="3">';
				//        print $form->selectarray('status', array('0'=>$langs->trans('ActivityCeased'),'1'=>$langs->trans('InActivity')),1);
				//        print '</td></tr>';
				
				// Barcode
				//        if ($conf->global->MAIN_MODULE_BARCODE)
				//        {
				//            print '<tr><td>'.$langs->trans('Gencod').'</td><td colspan="3"><input type="text" name="gencod">';
				//            print $object->gencod;
				//            print '</textarea></td></tr>';
				//        }
				
				// Address
				//        print '<tr><td valign="top">'.$langs->trans('Address').'</td><td colspan="3"><textarea name="adresse" cols="40" rows="3" wrap="soft">';
				//        print $object->address;
				//        print '</textarea></td></tr>';
				
				/*print '<tr>';
				// IdProf1 (SIREN for France)
				$idprof=$langs->transcountry('ProfId1',$object->pays_code);
				if ($idprof!='-')
				{
				    print '<td>'.$idprof.'</td><td>';
				    print $formcompany->get_input_id_prof(1,'idprof1',$object->siren,$object->pays_code);
				    print '</td>';
				}
				else print '<td>&nbsp;</td><td>&nbsp;</td>';
				// IdProf2 (SIRET for France)
				$idprof=$langs->transcountry('ProfId2',$object->pays_code);
				if ($idprof!='-')
				{
				    print '<td>'.$idprof.'</td><td>';
				    print $formcompany->get_input_id_prof(2,'idprof2',$object->siret,$object->pays_code);
				    print '</td>';
				}
				else print '<td>&nbsp;</td><td>&nbsp;</td>';
				print '</tr>';
				print '<tr>';
				// IdProf3 (APE for France)
				$idprof=$langs->transcountry('ProfId3',$object->pays_code);
				if ($idprof!='-')
				{
				    print '<td>'.$idprof.'</td><td>';
				    print $formcompany->get_input_id_prof(3,'idprof3',$object->ape,$object->pays_code);
				    print '</td>';
				}
				else print '<td>&nbsp;</td><td>&nbsp;</td>';
				// IdProf4 (NU for France)
				$idprof=$langs->transcountry('ProfId4',$object->pays_code);
				if ($idprof!='-')
				{
				    print '<td>'.$idprof.'</td><td>';
				    print $formcompany->get_input_id_prof(4,'idprof4',$object->idprof4,$object->pays_code);
				    print '</td>';
				}
				else print '<td>&nbsp;</td><td>&nbsp;</td>';
				print '</tr>';*/
				
				// Assujeti TVA
				//seta icms padrao não
				print '<input type="hidden" name="tva_intra" value ="2">';
				/* $html = new Form($db);
				 print '<tr><td>'.$langs->trans('VATIsUsed').'</td>';
				 print '<td>';
				 print $html->selectyesno('assujtva_value',2,1);     // Assujeti par defaut en creation
				 print '</td>';
				 print '<td nowrap="nowrap">'.$langs->trans('VATIntra').'</td>';
				 print '<td nowrap="nowrap">';
				 $s = '<input type="text" class="flat" name="tva_intra" size="12" maxlength="20" value="'.$object->tva_intra.'">';
							
				 if (empty($conf->global->MAIN_DISABLEVATCHECK))
				 {
				     $s.=' ';
							
				     if ($conf->use_javascript_ajax)
				     {
				         print "\n";
				         print '<script language="JavaScript" type="text/javascript">';
				         print "function CheckVAT(a) {\n";
				         print "newpopup('".DOL_URL_ROOT."/societe/checkvat/checkVatPopup.php?vatNumber='+a,'".dol_escape_js($langs->trans("VATIntraCheckableOnEUSite"))."',500,230);\n";
				         print "}\n";
				         print '</script>';
				         print "\n";
				         $s.='<a href="#" onclick="javascript: CheckVAT(document.formsoc.tva_intra.value);">'.$langs->trans("VATIntraCheck").'</a>';
				         $s = $form->textwithpicto($s,$langs->trans("VATIntraCheckDesc",$langs->trans("VATIntraCheck")),1);
				     }
				     else
				     {
				         $s.='<a href="'.$langs->transcountry("VATIntraCheckURL",$object->id_pays).'" target="_blank">'.img_picto($langs->trans("VATIntraCheckableOnEUSite"),'help').'</a>';
				     }
				 }
				 print $s;
				 print '</td>';
				 print '</tr>';*/
				
				//        // Type - Size
				//        print '<tr><td>'.$langs->trans("ThirdPartyType").'</td><td>'."\n";
				//        print $form->selectarray("typent_id",$formcompany->typent_array(0), $object->typent_id);
				//        if ($user->admin) print info_admin($langs->trans("YouCanChangeValuesForThisListFromDictionnarySetup"),1);
				//        print '</td>';
				//        print '<td>'.$langs->trans("Staff").'</td><td>';
				//        print $form->selectarray("effectif_id",$formcompany->effectif_array(0), $object->effectif_id);
				//        if ($user->admin) print info_admin($langs->trans("YouCanChangeValuesForThisListFromDictionnarySetup"),1);
				//        print '</td></tr>';
				//
				//        // Legal Form
				//        print '<tr><td>'.$langs->trans('JuridicalStatus').'</td>';
				//        print '<td colspan="3">';
				//        if ($object->pays_id)
				//        {
				//            $formcompany->select_forme_juridique($object->forme_juridique_code,$object->pays_code);
				//        }
				//        else
				//        {
				//            print $countrynotdefined;
				//        }
				//        print '</td></tr>';
				
				// Como nos conheceu
				print '<tr><td class="fieldrequired">'.$langs->trans('ConheceuW').'</td><td colspan="3">';
				$tipo_temp = explode(",", $object->como_conheceu);
				for ($i = 0; $i < count($tipo_temp); $i++){
					if (!empty($tipo_temp[$i])){
						switch ($tipo_temp[$i]) {
							case 'Jornal':
								print '<input type="checkbox" name="como_con[]" value="Jornal"  checked="yes" /> Jornal<br/>';
								$controle .= "J";
								break;
							
							case 'Internet':
								print '<input type="checkbox" name="como_con[]" value="Internet"  checked="yes" /> Internet<br/>';
								$controle .= "I";
								break;
							
							case 'Indicação':
								print '<input type="checkbox" name="como_con[]" value="Indicação"  checked="yes" /> Indicação<br/>';
								$controle .= "D";
								break;
							
							case 'Placa de obra':
								print '<input type="checkbox" name="como_con[]" value="Placa de obra"  checked="yes" /> Placa de obra<br/>';
								$controle .= "P";
								break;
							
							case 'Veículos':
								print '<input type="checkbox" name="como_con[]" value="Veículos"  checked="yes" /> Veículos<br/>';
								$controle .= "V";
								break;
							
							case 'Correspondência':
								print '<input type="checkbox" name="como_con[]" value="Correspondência"  checked="yes" /> Correspondência<br/>';
								$controle .= "C";
								break;
							
							default:
								print '<input type="checkbox" value="Outros:"  checked="yes" /> Outro: <input type="text" size="100" maxlength="200" name="como_con[]" id="como_con" value="'. $tipo_temp[$i] .'"> <br/>';
								$controle .= "O";
								break;
						}
					}
				}
				//verifica quais devem exibir e quais já foram exibidas marcadas
				if (strpos($controle, "J") === false){
					print '<input type="checkbox" name="como_con[]" value="Jornal" /> Jornal<br/>';
				}
				if (strpos($controle, "I") === false){
					print '<input type="checkbox" name="como_con[]" value="Internet" /> Internet<br/>';
				}
				if (strpos($controle, "D") === false){
					print '<input type="checkbox" name="como_con[]" value="Indicação" /> Indicação<br/>';
				}
				if (strpos($controle, "P") === false){
					print '<input type="checkbox" name="como_con[]" value="Placa de obra" /> Placa de obra<br/>';
				}
				if (strpos($controle, "V") === false){
					print '<input type="checkbox" name="como_con[]" value="Veículos" /> Veículos<br/>';
				}
				if (strpos($controle, "C") === false){
					print '<input type="checkbox" name="como_con[]" value="Correspondência" /> Correspondência<br/>';
				}
				if (strpos($controle, "O") === false){
					print '<input type="checkbox" value="Outros:" /> Outro: <input type="text" size="100" maxlength="200" name="como_con[]" id="como_con" value="'. $tipo_temp[$i] .'"> <br/>';
				}
				print '</td>';
				print '</tr>';
				
				// Local Taxes
				// TODO add specific function by country
				//        if($mysoc->pays_code=='ES')
				//        {
				//            if($mysoc->localtax1_assuj=="1" && $mysoc->localtax2_assuj=="1")
				//            {
				//                print '<tr><td>'.$langs->trans("LocalTax1IsUsedES").'</td><td>';
				//                print $html->selectyesno('localtax1assuj_value',0,1);
				//                print '</td><td>'.$langs->trans("LocalTax2IsUsedES").'</td><td>';
				//                print $html->selectyesno('localtax2assuj_value',0,1);
				//                print '</td></tr>';
				//
				//            }
				//            elseif($mysoc->localtax1_assuj=="1")
				//            {
				//                print '<tr><td>'.$langs->trans("LocalTax1IsUsedES").'</td><td colspan="3">';
				//                print $html->selectyesno('localtax1assuj_value',0,1);
				//                print '</td><tr>';
				//            }
				//            elseif($mysoc->localtax2_assuj=="1")
				//            {
				//                print '<tr><td>'.$langs->trans("LocalTax2IsUsedES").'</td><td colspan="3">';
				//                print $html->selectyesno('localtax2assuj_value',0,1);
				//                print '</td><tr>';
				//            }
				//        }
				
				//        if ($conf->global->MAIN_MULTILANGS)
				//        {
				//            print '<tr><td>'.$langs->trans("DefaultLang").'</td><td colspan="3">'."\n";
				//            print $formadmin->select_language(($object->default_lang?$object->default_lang:$conf->global->MAIN_LANG_DEFAULT),'default_lang',0,0,1);
				//            print '</td>';
				//            print '</tr>';
				//        }
				
				if ($user->rights->societe->client->voir)
				{
					// Assign a Name
					print '<tr>';
					print '<td>'.$langs->trans("AllocateCommercial").'</td>';
					print '<td colspan="3">';
					$form->select_users($object->commercial_id,'commercial_id',1);
					print '</td></tr>';
					
				}
				print '</table>';
				print '<br>';
				
				print '<center>';
				print '<input type="submit" class="button" name="save" value="'.$langs->trans("Save").'">';
				print ' &nbsp; &nbsp; ';
				print '<input type="submit" class="button" name="cancel" value="'.$langs->trans("Cancel").'">';
				print '</center>';
				
				print '</form>';
			} 
		} //fim do else do formulário de cliente
	} //final do formulário de edição
    else
    {
        /*
         * View
         */
        $object = new Societe($db);
        $res=$object->fetch($socid);
        if ($res < 0) { dol_print_error($db,$object->error); exit; }
        $res=$object->fetch_optionals($socid,$extralabels);
        if ($res < 0) { dol_print_error($db); exit; }


        $head = societe_prepare_head($object);

		dol_fiche_head($head, 'card', $langs->trans("TituloCliForW"),0,'company');

        $html = new Form($db);


        // Confirm delete third party
        if ($action == 'delete' || $conf->use_javascript_ajax)
        {
            $html = new Form($db);
            $ret=$html->form_confirm($_SERVER["PHP_SELF"]."?socid=".$object->id,$langs->trans("DeleteACompany"),$langs->trans("ConfirmDeleteCompany"),"confirm_delete",'',0,"action-delete");
            if ($ret == 'html') print '<br>';
        }

        dol_htmloutput_errors($error,$errors);

        print '<table class="border" width="100%">';

        // Ref
        /*
        print '<tr><td width="25%" valign="top">'.$langs->trans("Ref").'</td>';
        print '<td colspan="2">';
        print $fuser->id;
        print '</td>';
        print '</tr>';
        */
		if ($object->client)  //cliente
		{
			print '<tr><td>';
			print $langs->trans('CustomerCode').'</td><td colspan="'.(2+($object->logo?0:1)).'">';
			print $object->code_client;
			if ($object->check_codeclient() <> 0) print ' <font class="error">('.$langs->trans("WrongCustomerCode").')</font>';
			print '</td>';
			print $showlogo; $showlogo='';
			print '</tr>';
			
			// nome
			print '<tr><td width="20%">'.$langs->trans('NomeClienteW').'</td>';
			print '<td colspan="3">';
			print $object->nom;
			print '</td>';
			print '</tr>';
			//tipo visualizar modificado kurt
			print '<tr><td width="20%">'.$langs->trans('TipoClienteW').'</td>';
			print '<td colspan="3">';		
			print $object->prefix_comm;
			print '</td>';
			print '</tr>';
//			//tel, visualização
//			print '</tr>';
//			print '<tr><td width="20%">'. $langs->trans('Tel1W').'</td><td colspan="3")>';
//			print $object->tel;
//			print '</td></tr>';
//			//tel2, visualização
//			print '</tr>';
//			print '<tr><td width="20%">'. $langs->trans('Tel2W').'</td><td colspan="3")>';
//			print $object->fax;
//			print '</td></tr>';
//			//EmailW cliente, visualização
//			print '</tr>';
//			print '<tr><td width="20%">'. $langs->trans('EmailW').'</td><td colspan="3")>';
//			print $object->email;
//			print '</td></tr>';
			//cpf_cnpj, visualização
					
			print '<tr><td width="20%">'. $langs->trans('cpf_cnpjW').'</td>';
			print '<td colspan="3">';		
			if ($object->cpf_cnpj) {
				print 'Sim';
			}
			print '</td>';
			print '</tr>';
			//NomeSolicitanteW, visualização
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('NomeSolicitanteW').'</td><td colspan="3")>';
			print $object->siret;
			print '</td></tr>';
			//StatusW, visualização
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('StatusW').'</td><td colspan="3")>';
			print $object->idprof4;
			print '</td></tr>';
			//tel solicitante, visualização
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('Tel1W').'</td><td colspan="3")>';
			print $object->tel1_soli;
			print '</td></tr>';
			//tel2 solicitante, visualização
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('Tel2W').'</td><td colspan="3")>';
			print $object->tel2_soli;
			print '</td></tr>';
			//EmailW solicitante, visualização
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('Email2W').'</td><td colspan="3")>';
			print $object->email_2;
			print '</td></tr>';
			//num aptos, visualização
			print '<tr><td>'. $langs->trans('NumAptoW').'</td>';
			print '<td colspan="3">'. $object->ape .'</td>';			
			print '</tr>';
			//num pav, visualização
			print '<tr><td width="20%">'. $langs->trans('NumPavW').'</td><td colspan="3")>';
			print $object->siren;
			print '</td></tr>';	
			//rua, visualização
			print '<tr><td width="20%">'. $langs->trans('RuaW').'</td><td colspan="3")>';
			print $object->rua;
			print '</td></tr>';
			
			//numemro, visualização
			print '<tr><td width="20%">'. $langs->trans('NumW').'</td><td colspan="3")>';
			print $object->numero;
			print '</td></tr>';
			//complemento, visualização
			print '<tr><td width="20%">'. $langs->trans('ComplementoW').'</td><td colspan="3")>';
			print $object->complemento;
			print '</td></tr>';
			//bairro, visualização
			print '<tr><td width="20%">'. $langs->trans('BairroW').'</td><td colspan="3")>';
			print $object->bairro;
			print '</td></tr>';
			//CEP, visualização
			print '<tr><td width="20%">'. $langs->trans('CEPW').'</td><td colspan="3")>';
			print $object->cp;
			print '</td></tr>';
			//cidade, visualização
			print '<tr><td width="20%">'. $langs->trans('CidadeW').'</td><td colspan="3")>';
			print $object->ville;
			print '</td></tr>';
			//ponto de referencia
			print '<tr><td width="20%">'.$langs->trans('PontoRefW').'</td><td colspan="3">';
			print $object->ponto_ref;
			print '</td></tr>';
			// Pais
			print '<tr><td>'.$langs->trans("Country").'</td><td colspan="'.(2+($object->logo?0:1)).'" nowrap="nowrap">';
			$img=picto_from_langcode($object->pays_code);
			if ($object->isInEEC()) print $form->textwithpicto(($img?$img.' ':'').$object->pays,$langs->trans("CountryIsInEEC"),1,0);
			else print ($img?$img.' ':'').$object->pays;
			print '</td></tr>';
			//como conheceu, visualização
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('ConheceuW').'</td><td colspan="3")>';
			$tipo_temp = explode(",", $object->como_conheceu);
			for ($i = 0; $i < count($tipo_temp); $i++){
				if (!empty($tipo_temp[$i])){
					print '- '. $tipo_temp[$i] .'<br/>';
				}
			}
			print '</td></tr>';
					
			// Commercial
			print '<tr><td>';
			print '<table width="100%" class="nobordernopadding"><tr><td>';
			print $langs->trans('SalesRepresentatives');
			print '<td><td align="right">';
			if ($user->rights->societe->creer)
				print '<a href="'.DOL_URL_ROOT.'/societe/commerciaux.php?socid='.$object->id.'">'.img_edit().'</a>';
			else
				print '&nbsp;';
			print '</td></tr></table>';
			print '</td>';
			print '<td colspan="3">';
			
			$listsalesrepresentatives=$object->getSalesRepresentatives($user);
			$nbofsalesrepresentative=sizeof($listsalesrepresentatives);
			if ($nbofsalesrepresentative > 3)   // We print only number
			{
				print '<a href="'.DOL_URL_ROOT.'/societe/commerciaux.php?socid='.$object->id.'">';
				print $nbofsalesrepresentative;
				print '</a>';
			}
			else if ($nbofsalesrepresentative > 0)
				{
					$userstatic=new User($db);
					$i=0;
					foreach($listsalesrepresentatives as $val)
					{
						$userstatic->id=$val['id'];
						$userstatic->nom=$val['name'];
						$userstatic->prenom=$val['firstname'];
						print $userstatic->getNomUrl(1);
						$i++;
						if ($i < $nbofsalesrepresentative) print ', ';
					}
				}
				else print $langs->trans("NoSalesRepresentativeAffected");
			print '</td></tr>';
			
			// Module Adherent
			if ($conf->adherent->enabled)
			{
				$langs->load("members");
				print '<tr><td width="25%" valign="top">'.$langs->trans("LinkedToDolibarrMember").'</td>';
				print '<td colspan="3">';
				$adh=new Adherent($db);
				$result=$adh->fetch('','',$object->id);
				if ($result > 0)
				{
					$adh->ref=$adh->getFullName($langs);
					print $adh->getNomUrl(1);
				}
				else
				{
					print $langs->trans("UserNotLinkedToMember");
				}
				print '</td>';
				print "</tr>\n";
			}
		} //fim da visualização de cliente
		else { //visualização de fornecedor
		
			//Tipo de fornecedor, visualização
			print '<tr><td width="20%"><span span id="TypeName" class="fieldrequired">'.$langs->trans('TipoFW').'</td><td colspan="3">'.$object->tipo_fornecedor.'</td></tr>';
		
			//razão social
			print '<tr><td width="20%"><span span id="TypeName" class="fieldrequired">'. $langs->trans('CompanyName').'</span></td><td>'.$object->nom.'</td>';
			
			//nome da empresa, visualização
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('nomeEmpW').'</td>';
			print '<td colspan="3">'. $object->idprof4 .'</td>';
			print '</tr>';
			
			// código do fornecedor
			print '<td width="20%">'.$langs->trans('SupplierCode').'</td><td>';
			print '<table class="nobordernopadding"><tr><td>';
			$tmpcode=$object->code_fournisseur;
			if ($modCodeFournisseur->code_auto) $tmpcode=$modCodeFournisseur->getNextValue($object,1);
			print $tmpcode;
			print '</td>';
			print '</tr></table>';
			print '</td></tr>';
			
			//cnpj, cadastro
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('cnpjW').'</td>';
			print '<td colspan="3">'. $object->cpf_cnpj .'</td>';			
			print '</tr>';
			//insc estadual, cadastro
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('inscW').'</td>';
			print '<td colspan="3">'. $object->idprof3 .'</td>';			
			print '</tr>';
			//insc municipal, cadastro
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('inscW1').'</td>';
			print '<td colspan="3">'. $object->idprof1 .'</td>';			
			print '</tr>';
			// Telefones
			print '<tr><td width="20%">'.$langs->trans('Tel1W').'</td><td colspan="3">'.$object->tel.'</td></tr>';
			//tel solicitante, visualização
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('Tel2W').'</td><td colspan="3")>';
			print $object->tel1_soli;
			print '</td></tr>';
			//tel2 solicitante, visualização
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('Tel3W').'</td><td colspan="3")>';
			print $object->tel2_soli;
			print '</td></tr>';
			print '<tr><td width="20%">'.$langs->trans('Fax').'</td><td colspan="3">'.$object->fax.'</td></tr></tr>';
			
			//endereço completo
			//rua, cadastro
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('RuaW').'</td>';
			print '<td colspan="3">'. $object->rua .'</td>';			
			print '</tr>';	
			//numemro, cadastro
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('NumW').'</td>';
			print '<td colspan="3">'. $object->numero .'</td>';			
			print '</tr>';
			//complemento, cadastro
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('ComplementoW').'</td>';
			print '<td colspan="3">'. $object->complemento .'</td>';			
			print '</tr>';	
			//bairro, cadastro
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('BairroW').'</td>';
			print '<td colspan="3">'. $object->bairro .'</td>';			
			print '</tr>';
			//CEP, cadastro
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('CEPW').'</td>';
			print '<td colspan="3">'. $object->cp .'</td>';			
			print '</tr>';
			//cidade	
			print '</td><td width="20%">'.$langs->trans('CidadeW').'</td><td colspan="3">';
			print $object->ville;
			print '</td></tr>';
			
			//contato, cadastro
			print '</tr>';
			print '<tr><td width="20%">'. $langs->trans('Contact').'</td>';
			print '<td colspan="3">'. $object->siret .'</td>';		
			print '</tr>';
			//e-mail, cadastro
			print '<tr><td width="20%">'.$langs->trans('EmailW').'</td><td colspan="3">'.$object->email.'</td></tr>';


		}
        print '</table>';

        dol_fiche_end();


        /*
         *  Actions
         */
        print '<div class="tabsAction">'."\n";

        if ($user->rights->societe->creer)
        {
            print '<a class="butAction" href="'.$_SERVER["PHP_SELF"].'?socid='.$object->id.'&amp;action=edit">'.$langs->trans("Modify").'</a>'."\n";
        }

        if ($user->rights->societe->supprimer)
        {
            if ($conf->use_javascript_ajax)
            {
                print '<span id="action-delete" class="butActionDelete">'.$langs->trans('Delete').'</span>'."\n";
            }
            else
            {
                print '<a class="butActionDelete" href="'.$_SERVER["PHP_SELF"].'?socid='.$object->id.'&amp;action=delete">'.$langs->trans('Delete').'</a>'."\n";
            }
        }

        print '</div>'."\n";
        print '<br>';

        if (empty($conf->global->SOCIETE_DISABLE_BUILDDOC))
        {
            print '<table width="100%"><tr><td valign="top" width="50%">';
            print '<a name="builddoc"></a>'; // ancre

            /*
             * Documents generes
             */
            $filedir=$conf->societe->dir_output.'/'.$object->id;
            $urlsource=$_SERVER["PHP_SELF"]."?socid=".$object->id;
            $genallowed=$user->rights->societe->creer;
            $delallowed=$user->rights->societe->supprimer;

            $var=true;

            $somethingshown=$formfile->show_documents('company',$object->id,$filedir,$urlsource,$genallowed,$delallowed,'',0,0,0,28,0,'',0,'',$object->default_lang);

            print '</td>';
            print '<td></td>';
            print '</tr>';
            print '</table>';

            print '<br>';
        }

        // Subsidiaries list
        $result=show_subsidiaries($conf,$langs,$db,$object);

        // Contacts list
        if (empty($conf->global->SOCIETE_DISABLE_CONTACTS))
        {
            $result=show_contacts($conf,$langs,$db,$object,$_SERVER["PHP_SELF"].'?socid='.$object->id);
        }

        // Projects list
        $result=show_projects($conf,$langs,$db,$object,$_SERVER["PHP_SELF"].'?socid='.$object->id);
    }

}


$db->close();

llxFooter('$Date: 2011/08/01 00:38:49 $ - $Revision: 1.126 $');
?>