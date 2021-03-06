<?php
/* Copyright (C) 2004-2005 Rodolphe Quiedeville <rodolphe@quiedeville.org>
 * Copyright (C) 2004-2011 Laurent Destailleur  <eldy@users.sourceforge.net>
 * Copyright (C) 2004      Benoit Mortier       <benoit.mortier@opensides.be>
 * Copyright (C) 2005-2011 Regis Houssin        <regis@dolibarr.fr>
 * Copyright (C) 2007      Franky Van Liedekerke <franky.van.liedekerke@telenet.be>
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
 *       \file       htdocs/contact/fiche.php
 *       \ingroup    societe
 *       \brief      Card of a contact
 *       \version    $Id: fiche.php,v 1.222 2011/07/31 23:54:12 eldy Exp $
 */

require("../main.inc.php");
require_once(DOL_DOCUMENT_ROOT."/comm/action/class/actioncomm.class.php");
require_once(DOL_DOCUMENT_ROOT."/contact/class/contact.class.php");
require_once(DOL_DOCUMENT_ROOT."/lib/contact.lib.php");
require_once(DOL_DOCUMENT_ROOT."/lib/company.lib.php");
require_once(DOL_DOCUMENT_ROOT."/core/class/html.formcompany.class.php");

$langs->load("companies");
$langs->load("users");
$langs->load("other");
$langs->load("commercial");

$error=0; $errors=array();

$action = GETPOST('action');
$socid = GETPOST("socid");
$id = GETPOST("id");

// Security check
if ($user->societe_id) $socid=$user->societe_id;

$object = new Contact($db);

// Get object canvas (By default, this is not defined, so standard usage of dolibarr)
if (!empty($id)) $object->getCanvas($id);
$canvas = (!empty($object->canvas)?$object->canvas:GETPOST("canvas"));
if (! empty($canvas))
{
    require_once(DOL_DOCUMENT_ROOT."/core/class/canvas.class.php");
    $objcanvas = new Canvas($db,$action);
    $objcanvas->getCanvas('contact','contactcard',$canvas);

    // Security check
    $result = $objcanvas->restrictedArea($user, 'contact', $id, 'socpeople');
}
else
{
    // Security check
    $result = restrictedArea($user, 'contact', $id, 'socpeople'); // If we create a contact with no company (shared contacts), no check on write permission
}

// Instantiate hooks of thirdparty module
if (is_array($conf->hooks_modules) && !empty($conf->hooks_modules))
{
    $object->callHooks('contactcard');
}


/*
 *	Actions
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
                    $resaction+=$module->doActions($object,$action,$id); // object is deprecated, action can be changed by method (to go back to other action for example), id can be changed/set by method (during creation for example)
                    if ($resaction < 0 || ! empty($module->error) || (! empty($module->errors) && sizeof($module->errors) > 0))
                    {
                        $error=$module->error; $errors=$module->errors;
                        if ($action=='add')    $action='create';
                        if ($action=='update') $action='edit';
                    }
                    else $reshook+=$resaction;
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
    $objcanvas->doActions($id);
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
    // Cancel
    if (GETPOST("cancel") && GETPOST('backtopage'))
    {
        header("Location: ".GETPOST('backtopage'));
        exit;
    }

	// Creation utilisateur depuis contact
    if ($_POST["action"] == 'confirm_create_user' && $_POST["confirm"] == 'yes' && $user->rights->user->user->creer)
    {
        // Recuperation contact actuel
        $result = $object->fetch($_GET["id"]);

        if ($result > 0)
        {
            $db->begin();

            // Creation user
            $nuser = new User($db);
            $result=$nuser->create_from_contact($object,$_POST["login"]);

            if ($result > 0)
            {
                $result2=$nuser->setPassword($user,$_POST["password"],0,1,1);
                if ($result2)
                {
                    $db->commit();
                }
                else
                {
                    $error=$nuser->error; $errors=$nuser->errors;
                    $db->rollback();
                }
            }
            else
            {
                $error=$nuser->error; $errors=$nuser->errors;
                $db->rollback();
            }
        }
        else
        {
            $error=$object->error; $errors=$object->errors;
        }
    }

    // Add contact
    if (GETPOST("action") == 'add' && $user->rights->societe->contact->creer)
    {
        $db->begin();

        if ($canvas) $object->canvas=$canvas;

        $object->socid			= $_POST["socid"];
        $object->name			= $_POST["name"];
        $object->firstname		= $_POST["firstname"];
        $object->civilite_id	= $_POST["civilite_id"];
        $object->poste			= $_POST["poste"];
        //$object->address		= $_POST["address"];
        $object->zip			= $_POST["zipcode"];
        $object->town			= $_POST["town"];
        $object->fk_pays		= $_POST["pays_id"];
        $object->fk_departement = $_POST["departement_id"];
        $object->email			= $_POST["email"];
        $object->phone_pro		= $_POST["phone_pro"];
        $object->phone_perso	= $_POST["phone_perso"];
        $object->phone_mobile	= $_POST["phone_mobile"];
        $object->fax			= $_POST["fax"];
//        $object->jabberid		= $_POST["jabberid"];
//        $object->priv			= $_POST["priv"];
        $object->note			= $_POST["note"];
		
		//novos campos usados
		$object->cp				= $_POST["cp"];
		$object->address		= $_POST["rua"];
		$object->default_lang 	= $_POST["numero"];
		$object->priv			= $_POST["complemento"];
		$object->jabberid		= $_POST["bairro"];
		$object->ville			= $_POST["ville"];

        // Note: Correct date should be completed with location to have exact GM time of birth.
        $object->birthday = dol_mktime(0,0,0,$_POST["birthdaymonth"],$_POST["birthdayday"],$_POST["birthdayyear"]);
        $object->birthday_alert = $_POST["birthday_alert"];

        if (! $_POST["name"])
        {
            $error++; $errors[]=$langs->trans("ErrorFieldRequired",$langs->transnoentities("Label"));
            $_GET["action"] = $_POST["action"] = 'create';
        }

        if ($_POST["name"])
        {
            $id =  $object->create($user);
            if ($id <= 0)
            {
                $error++; $errors[]=($object->error?array($object->error):$object->errors);
                $_GET["action"] = $_POST["action"] = 'create';
            }
        }

        if (! $error && $id > 0)
        {
            $db->commit();
            if (GETPOST('backtopage')) $url=GETPOST('backtopage');
            else $url='fiche.php?id='.$id;
            Header("Location: ".$url);
            exit;
        }
        else
        {
            $db->rollback();
        }
    }

    if (GETPOST("action") == 'confirm_delete' && GETPOST("confirm") == 'yes' && $user->rights->societe->contact->supprimer)
    {
        $result=$object->fetch($_GET["id"]);

        $object->old_name      = $_POST["old_name"];
        $object->old_firstname = $_POST["old_firstname"];

        $result = $object->delete();
        if ($result > 0)
        {
            Header("Location: index.php");
            exit;
        }
        else
        {
            $error=$object->error; $errors[]=$object->errors;
        }
    }

    if ($_POST["action"] == 'update' && ! $_POST["cancel"] && $user->rights->societe->contact->creer)
    {
        if (empty($_POST["name"]))
        {
            $error++; $errors=array($langs->trans("ErrorFieldRequired",$langs->transnoentities("Label")));
            $_GET["action"] = $_POST["action"] = 'edit';
        }

        if (! sizeof($errors))
        {
            $object->fetch($_POST["contactid"]);

            $object->oldcopy=dol_clone($object);

            $object->old_name		= $_POST["old_name"];
            $object->old_firstname	= $_POST["old_firstname"];

            $object->socid			= $_POST["socid"];
            $object->name			= $_POST["name"];
            $object->firstname		= $_POST["firstname"];
            $object->civilite_id	= $_POST["civilite_id"];
            $object->poste			= $_POST["poste"];

            $object->address		= $_POST["address"];
            $object->zip			= $_POST["zipcode"];
            $object->town			= $_POST["town"];
            $object->fk_departement	= $_POST["departement_id"];
            $object->fk_pays		= $_POST["pays_id"];

            $object->email			= $_POST["email"];
            $object->phone_pro		= $_POST["phone_pro"];
            $object->phone_perso	= $_POST["phone_perso"];
            $object->phone_mobile	= $_POST["phone_mobile"];
            $object->fax			= $_POST["fax"];
//            $object->jabberid		= $_POST["jabberid"];
//            $object->priv			= $_POST["priv"];
            $object->note			= $_POST["note"];
			
			//novos campos usados
			$object->cp				= $_POST["cp"];
			$object->address		= $_POST["rua"];
			$object->default_lang 	= $_POST["numero"];
			$object->priv			= $_POST["complemento"];
			$object->jabberid		= $_POST["bairro"];
			$object->ville			= $_POST["ville"];

            $result = $object->update($_POST["contactid"], $user);

            if ($result > 0)
            {
                $object->old_name='';
                $object->old_firstname='';
            }
            else
            {
                $error=$object->error; $errors=$object->errors;
            }
        }
    }
}


/*
 *	View
 */

$help_url='EN:Module_Third_Parties|FR:Module_Tiers|ES:Empresas';
llxHeader('',$langs->trans("ContactsAddresses"),$help_url);

$form = new Form($db);
$formcompany = new FormCompany($db);

$countrynotdefined=$langs->trans("ErrorSetACountryFirst").' ('.$langs->trans("SeeAbove").')';

if ($socid > 0)
{
    $objsoc = new Societe($db);
    $objsoc->fetch($socid);
}

if (is_object($objcanvas) && $objcanvas->displayCanvasExists($action))
{
    // -----------------------------------------
    // When used with CANVAS
    // -----------------------------------------
    if ($action == 'create')
    {
        $objcanvas->assign_post();            // TODO: Put code of assign_post into assign_values to keep only assign_values
        $objcanvas->assign_values($action);   // Set value for templates
        $objcanvas->display_canvas($action);  // Show template
    }
    else if ($action == 'edit')
    {
        $objcanvas->control->object=$objcanvas->getObject($id);  // TODO: Getting and storing object should be done into assign_values (for template with no code) or into tpl
        if (empty($objcanvas->control->object))
        {
            $object = new Contact($db);
            $object->fetch($id,$user);
            $objcanvas->control->object=$object;
        }
       	$objcanvas->assign_post();            // TODO: Put code of assign_post into assign_values to keep only assign_values
        $objcanvas->assign_values($action);   // Set value for templates
        $objcanvas->display_canvas($action);  // Show template
    }
    else
    {
        $objcanvas->control->object=$objcanvas->getObject($id);  // TODO: Getting and storing object should be done into assign_values (for template with no code) or into tpl
        if (empty($objcanvas->control->object))
        {
            $object = new Contact($db);
            $object->fetch($id,$user);
            $objcanvas->control->object=$object;
        }
        $objcanvas->assign_values('view');  // Assign values
        $objcanvas->display_canvas('view'); // Show template
    }
}
else
{
    // -----------------------------------------
    // When used in standard mode
    // -----------------------------------------

    // Confirm deleting contact
    if ($user->rights->societe->contact->supprimer)
    {
        if ($_GET["action"] == 'delete')
        {
            $ret=$form->form_confirm($_SERVER["PHP_SELF"]."?id=".$_GET["id"],$langs->trans("DeleteContact"),$langs->trans("ConfirmDeleteContact"),"confirm_delete",'',0,1);
            if ($ret == 'html') print '<br>';
        }
    }

    /*
     * Onglets
     */
    if (GETPOST("id") > 0)
    {
        // Si edition contact deja existant
        $object = new Contact($db);
        $return=$object->fetch($id, $user);
        if ($return <= 0)
        {
            dol_print_error('',$object->error);
            $_GET["id"]=0;
        }

        // Show tabs
        $head = contact_prepare_head($object);

        dol_fiche_head($head, 'card', $langs->trans("ContactsAddresses"), 0, 'contact');
    }

    if ($user->rights->societe->contact->creer)
    {
        if (GETPOST("action") == 'create')
        {
            /*
             * Fiche en mode creation
             */
            $object->fk_departement = $_POST["departement_id"];

            // We set pays_id, pays_code and label for the selected country
            $object->fk_pays=$_POST["pays_id"]?$_POST["pays_id"]:$mysoc->pays_id;
            if ($object->fk_pays)
            {
                $sql = "SELECT code, libelle";
                $sql.= " FROM ".MAIN_DB_PREFIX."c_pays";
                $sql.= " WHERE rowid = ".$object->fk_pays;
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

            print_fiche_titre($langs->trans("AddContact"));

            // Affiche les erreurs
            dol_htmloutput_errors($error,$errors);

            if ($conf->use_javascript_ajax)
            {
                print "\n".'<script type="text/javascript" language="javascript">';
                print 'jQuery(document).ready(function () {
							jQuery("#selectpays_id").change(function() {
								document.formsoc.action.value="create";
								document.formsoc.submit();
                        	});
						})';
                print '</script>'."\n";
            }

            print '<br>';
            print '<form method="post" name="formsoc" action="'.$_SERVER["PHP_SELF"].'">';
            print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
            print '<input type="hidden" name="action" value="add">';
            print '<input type="hidden" name="backtopage" value="'.GETPOST('backtopage').'">';
            print '<table class="border" width="100%">';

            // Name
			print '<tr><td width="10%" class="fieldrequired">'.$langs->trans("Label").'</td><td width="30%" colspan="3"><input name="name" type="text" size="30" maxlength="50" value="'.(isset($_POST["name"])?$_POST["name"]:$object->name).'"></td></tr>';
			print '<tr><td width="10%">'.$langs->trans("Company").'</td><td width="30%" colspan="3"><input name="firstname" type="text" size="80" maxlength="50" value="'.(isset($_POST["firstname"])?$_POST["firstname"]:$object->firstname).'"></td></tr>';

            // Company
            if (empty($conf->global->SOCIETE_DISABLE_CONTACTS))
            {
                if ($socid > 0)
                {
					print '<tr><td>'.$langs->trans("empreW").'</td>';
                    print '<td colspan="3">';
                    print $objsoc->getNomUrl(1);
                    print '</td>';
                    print '<input type="hidden" name="socid" value="'.$objsoc->id.'">';
                    print '</td></tr>';
                }
                else {
					print '<tr><td>'.$langs->trans("empreW").'</td><td colspan="3">';
                    print $form->select_societes(isset($_POST["socid"])?$_POST["socid"]:'','socid','',1);
                    //print $form->select_societes('','socid','');
                    //print $langs->trans("ContactNotLinkedToCompany");
                    print '</td></tr>';
                }
            }
			
			print '<tr><td>'.$langs->trans("deptoW").'</td><td colspan="3"><input name="poste" type="text" size="50" maxlength="80" value="'.(isset($_POST["poste"])?$_POST["poste"]:$object->poste).'"></td>';
			
			print '<tr><td width="15%">'.$langs->trans("UserTitle").'</td><td colspan="3">';
			print $formcompany->select_civilite(isset($_POST["civilite_id"])?$_POST["civilite_id"]:$object->civilite_id);
			print '</td></tr>';
			
			
			//fun��o que faz a consulta do cep
			echo '	<script>
					function getEndereco() {
					//limpa os campos
					$("#rua").val("");
					$("#bairro").val("");
					$("#ville").val("");
					// Se o campo CEP n�o estiver vazio
					if($.trim($("#cp").val()) != ""){
					/*
					Para conectar no servi�o e executar o json, precisamos usar a fun��o
					getScript do jQuery, o getScript e o dataType:"jsonp" conseguem fazer o cross-domain, os outros
					dataTypes n�o possibilitam esta intera��o entre dom�nios diferentes
					Estou chamando a url do servi�o passando o par�metro "formato=javascript" e o CEP digitado no formul�rio
					http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cp").val()
					*/
					$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cp").val(), function(){
					// o getScript d� um eval no script, ent�o � s� ler!
					//Se o resultado for igual a 1
					if(resultadoCEP["resultado"]){
					// troca o valor dos elementos
					$("#rua").val(unescape(resultadoCEP["logradouro"]));
					$("#bairro").val(unescape(resultadoCEP["bairro"]));
					$("#ville").val(unescape(resultadoCEP["cidade"]));
					}else{
					$("#rua").val("Endereco nao encontrado");
					}
					if ($("#rua").val() == ""){
					$("#rua").val("Endereco nao encontrado");
					}
					});
					}
					}
					</script>';

			//endere�o completo
			//CEP, cadastro
			print '<tr><td>'. $langs->trans('CEPW').'</td>';
			print '<td colspan="3"><input type="text" size="10" onBlur="getEndereco();" maxlength="10" name="cp" id="cp" value="'. $object->cp .'">
					<input type="button" class="button" value="Buscar CEP" onclick="getEndereco(); ">
					</td>';			
			print '</tr>';
			//rua, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('RuaW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="250" name="rua" id="rua" value="'. $object->address .'"></td>';			
			print '</tr>';	
			//numemro, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('NumW').'</td>';
			print '<td colspan="3"><input type="text" size="10" maxlength="10" name="numero" id="numero" value="'. $object->default_lang .'"></td>';			
			print '</tr>';
			//complemento, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('ComplementoW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="100" name="complemento" id="complemento" value="'. $object->priv .'"></td>';			
			print '</tr>';	
			//bairro, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('BairroW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="200" name="bairro" id="bairro" value="'. $object->jabberid .'"></td>';			
			print '</tr>';
			//cidade	
			print '</td><td>'.$langs->trans('CidadeW').'</td><td colspan="3">';
			print '<input type="text" size="70" maxlength="200" name="ville" id="ville" value="'. $object->ville .'">';
			print '</td></tr>';
			
			// EStado
			print '<input type="hidden" name="departement_id" value="1111">'; 

            // Address
//            if (($objsoc->typent_code == 'TE_PRIVATE' || ! empty($conf->global->CONTACT_USE_COMPANY_ADDRESS)) && dol_strlen(trim($object->address)) == 0) $object->address = $objsoc->address;	// Predefined with third party
//            print '<tr><td>'.$langs->trans("Address").'</td><td colspan="3"><textarea class="flat" name="address" cols="70">'.(isset($_POST["address"])?$_POST["address"]:$object->address).'</textarea></td>';

//            // Zip / Town
//            if (($objsoc->typent_code == 'TE_PRIVATE' || ! empty($conf->global->CONTACT_USE_COMPANY_ADDRESS)) && dol_strlen(trim($object->zip)) == 0) $object->zip = $objsoc->zip;			// Predefined with third party
//            if (($objsoc->typent_code == 'TE_PRIVATE' || ! empty($conf->global->CONTACT_USE_COMPANY_ADDRESS)) && dol_strlen(trim($object->town)) == 0) $object->town = $objsoc->town;	// Predefined with third party
//            print '<tr><td>'.$langs->trans("Zip").' / '.$langs->trans("Town").'</td><td colspan="3">';
//            print $formcompany->select_ziptown((isset($_POST["zipcode"])?$_POST["zipcode"]:$object->zip),'zipcode',array('town','selectpays_id','departement_id'),6).'&nbsp;';
//            print $formcompany->select_ziptown((isset($_POST["town"])?$_POST["town"]:$object->town),'town',array('zipcode','selectpays_id','departement_id'));
//            print '</td></tr>';

            // Country
            if (dol_strlen(trim($object->fk_pays)) == 0) $object->fk_pays = $objsoc->pays_id;	// Predefined with third party
            print '<tr><td>'.$langs->trans("Country").'</td><td colspan="3">';
            $form->select_pays((isset($_POST["pays_id"])?$_POST["pays_id"]:$object->fk_pays),'pays_id');
            if ($user->admin) print info_admin($langs->trans("YouCanChangeValuesForThisListFromDictionnarySetup"),1);
            print '</td></tr>';

//            // State
//            if (empty($conf->global->SOCIETE_DISABLE_STATE))
//            {
//                print '<tr><td>'.$langs->trans('State').'</td><td colspan="3">';
//                if ($object->fk_pays)
//                {
//                    $formcompany->select_departement(isset($_POST["departement_id"])?$_POST["departement_id"]:$object->fk_departement,$object->pays_code);
//                }
//                else
//                {
//                    print $countrynotdefined;
//                }
//                print '</td></tr>';
//            }

            // Phone / Fax
            if (($objsoc->typent_code == 'TE_PRIVATE' || ! empty($conf->global->CONTACT_USE_COMPANY_ADDRESS)) && dol_strlen(trim($object->phone_pro)) == 0) $object->phone_pro = $objsoc->tel;	// Predefined with third party
            print '<tr><td>'.$langs->trans("PhonePro").'</td><td><input name="phone_pro" type="text" size="18" maxlength="80" value="'.(isset($_POST["phone_pro"])?$_POST["phone_pro"]:$object->phone_pro).'"></td>';
            print '<td>'.$langs->trans("PhonePerso").'</td><td><input name="phone_perso" type="text" size="18" maxlength="80" value="'.(isset($_POST["phone_perso"])?$_POST["phone_perso"]:$object->phone_perso).'"></td></tr>';

            if (($objsoc->typent_code == 'TE_PRIVATE' || ! empty($conf->global->CONTACT_USE_COMPANY_ADDRESS)) && dol_strlen(trim($object->fax)) == 0) $object->fax = $objsoc->fax;	// Predefined with third party
            print '<tr><td>'.$langs->trans("PhoneMobile").'</td><td><input name="phone_mobile" type="text" size="18" maxlength="80" value="'.(isset($_POST["phone_mobile"])?$_POST["phone_mobile"]:$object->phone_mobile).'"></td>';
            print '<td>'.$langs->trans("Fax").'</td><td><input name="fax" type="text" size="18" maxlength="80" value="'.(isset($_POST["fax"])?$_POST["fax"]:$object->fax).'"></td></tr>';

            // EMail
            if (($objsoc->typent_code == 'TE_PRIVATE' || ! empty($conf->global->CONTACT_USE_COMPANY_ADDRESS)) && dol_strlen(trim($object->email)) == 0) $object->email = $objsoc->email;	// Predefined with third party
            print '<tr><td>'.$langs->trans("Email").'</td><td colspan="3"><input name="email" type="text" size="50" maxlength="80" value="'.(isset($_POST["email"])?$_POST["email"]:$object->email).'"></td></tr>';

//            // Instant message
//            print '<tr><td>'.$langs->trans("IM").'</td><td colspan="3"><input name="jabberid" type="text" size="50" maxlength="80" value="'.(isset($_POST["jabberid"])?$_POST["jabberid"]:$object->jabberid).'"></td></tr>';

//            // Visibility
//            print '<tr><td>'.$langs->trans("ContactVisibility").'</td><td colspan="3">';
//            $selectarray=array('0'=>$langs->trans("ContactPublic"),'1'=>$langs->trans("ContactPrivate"));
//            print $form->selectarray('priv',$selectarray,(isset($_POST["priv"])?$_POST["priv"]:$object->priv),0);
//            print '</td></tr>';

            // Note
            print '<tr><td valign="top">'.$langs->trans("Note").'</td><td colspan="3" valign="top"><textarea name="note" cols="70" rows="'.ROWS_3.'">'.(isset($_POST["note"])?$_POST["note"]:$object->note).'</textarea></td></tr>';

            print "</table><br>";


            // Add personnal information
            print_fiche_titre('<div class="comboperso">'.$langs->trans("PersonalInformations").'</div>','','');

            print '<table class="border" width="100%">';

            // Date To Birth
            print '<tr><td width="10%">'.$langs->trans("DateToBirth").'</td><td width="30%">';
            $html=new Form($db);
            if ($object->birthday)
            {
                print $html->select_date($object->birthday,'birthday',0,0,0,"perso");
            }
            else
            {
                print $html->select_date('','birthday',0,0,1,"perso");
            }
            print '</td>';

            print '<td colspan="2">'.$langs->trans("Alert").': ';
            if ($object->birthday_alert)
            {
                print '<input type="checkbox" name="birthday_alert" checked></td>';
            }
            else
            {
                print '<input type="checkbox" name="birthday_alert"></td>';
            }
            print '</tr>';

            print "</table><br>";


            print '<center>';
            print '<input type="submit" class="button" name="add" value="'.$langs->trans("Add").'">';
            if (GETPOST('backtopage'))
            {
                print ' &nbsp; &nbsp; ';
                print '<input type="submit" class="button" name="cancel" value="'.$langs->trans("Cancel").'">';
            }
            print '</center>';

            print "</form>";
        }
        elseif (GETPOST("action") == 'edit' && GETPOST("id"))
        {
            /*
             * Fiche en mode edition
             */

            // We set pays_id, and pays_code label of the chosen country
            if (isset($_POST["pays_id"]) || $object->fk_pays)
            {
                $sql = "SELECT code, libelle from ".MAIN_DB_PREFIX."c_pays where rowid = ".(isset($_POST["pays_id"])?$_POST["pays_id"]:$object->fk_pays);
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

            // Affiche les erreurs
            dol_htmloutput_errors($error,$errors);

            if ($conf->use_javascript_ajax)
            {
                print '<script type="text/javascript" language="javascript">';
                print 'jQuery(document).ready(function () {
							jQuery("#selectpays_id").change(function() {
								document.formsoc.action.value="edit";
								document.formsoc.submit();
							});
						})';
                print '</script>';
            }

            print '<form method="post" action="'.$_SERVER["PHP_SELF"].'?id='.GETPOST("id").'" name="formsoc">';
            print '<input type="hidden" name="token" value="'.$_SESSION['newtoken'].'">';
            print '<input type="hidden" name="id" value="'.GETPOST("id").'">';
            print '<input type="hidden" name="action" value="update">';
            print '<input type="hidden" name="backtopage" value="'.GETPOST('backtopage').'">';
            print '<input type="hidden" name="contactid" value="'.$object->id.'">';
            print '<input type="hidden" name="old_name" value="'.$object->name.'">';
            print '<input type="hidden" name="old_firstname" value="'.$object->firstname.'">';
            print '<table class="border" width="100%">';

            // Ref
            print '<tr><td>'.$langs->trans("Ref").'</td><td colspan="3">';
            print $object->ref;
            print '</td></tr>';

            // Name
			print '<tr><td width="10%" class="fieldrequired">'.$langs->trans("Label").'</td><td width="30%" colspan="3"><input name="name" type="text" size="20" maxlength="50" value="'.(isset($_POST["name"])?$_POST["name"]:$object->name).'"></td></tr>';
			print '<tr><td width="10%">'.$langs->trans("Company").'</td><td width="30%" colspan="3"><input name="firstname" type="text" size="20" maxlength="50" value="'.(isset($_POST["firstname"])?$_POST["firstname"]:$object->firstname).'"></td></tr>';

            // Company
            if (empty($conf->global->SOCIETE_DISABLE_CONTACTS))
            {
				print '<tr><td>'.$langs->trans("empreW").'</td>';
                print '<td colspan="3">';
                print $form->select_societes(isset($_POST["socid"])?$_POST["socid"]:($object->socid?$object->socid:-1),'socid','',1);
                print '</td>';
                print '</tr>';
            }

            // Civility
            print '<tr><td>'.$langs->trans("UserTitle").'</td><td colspan="3">';
            print $formcompany->select_civilite(isset($_POST["civilite_id"])?$_POST["civilite_id"]:$object->civilite_id);
            print '</td></tr>';

			print '<tr><td>'.$langs->trans("deptoW" ).'</td><td colspan="3"><input name="poste" type="text" size="50" maxlength="80" value="'.(isset($_POST["poste"])?$_POST["poste"]:$object->poste).'"></td></tr>';
			
			
			
			
			
			//fun��o que faz a consulta do cep
			echo '	<script>
					function getEndereco() {
					//limpa os campos
					$("#rua").val("");
					$("#bairro").val("");
					$("#ville").val("");
					// Se o campo CEP n�o estiver vazio
					if($.trim($("#cp").val()) != ""){
					/*
					Para conectar no servi�o e executar o json, precisamos usar a fun��o
					getScript do jQuery, o getScript e o dataType:"jsonp" conseguem fazer o cross-domain, os outros
					dataTypes n�o possibilitam esta intera��o entre dom�nios diferentes
					Estou chamando a url do servi�o passando o par�metro "formato=javascript" e o CEP digitado no formul�rio
					http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cp").val()
					*/
					$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cp").val(), function(){
					// o getScript d� um eval no script, ent�o � s� ler!
					//Se o resultado for igual a 1
					if(resultadoCEP["resultado"]){
					// troca o valor dos elementos
					$("#rua").val(unescape(resultadoCEP["logradouro"]));
					$("#bairro").val(unescape(resultadoCEP["bairro"]));
					$("#ville").val(unescape(resultadoCEP["cidade"]));
					}else{
					$("#rua").val("Endereco nao encontrado");
					}
					if ($("#rua").val() == ""){
					$("#rua").val("Endereco nao encontrado");
					}
					});
					}
					}
					</script>';
			
			//endere�o completo
			//CEP, cadastro
			print '<tr><td>'. $langs->trans('CEPW').'</td>';
			print '<td colspan="3"><input type="text" size="10" onBlur="getEndereco();" maxlength="10" name="cp" id="cp" value="'. $object->cp .'">
					<input type="button" class="button" value="Buscar CEP" onclick="getEndereco(); ">
					</td>';			
			print '</tr>';
			//rua, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('RuaW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="250" name="rua" id="rua" value="'. $object->address .'"></td>';			
			print '</tr>';	
			//numemro, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('NumW').'</td>';
			print '<td colspan="3"><input type="text" size="10" maxlength="10" name="numero" id="numero" value="'. $object->default_lang .'"></td>';			
			print '</tr>';
			//complemento, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('ComplementoW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="100" name="complemento" id="complemento" value="'. $object->priv .'"></td>';			
			print '</tr>';	
			//bairro, cadastro
			print '</tr>';
			print '<tr><td>'. $langs->trans('BairroW').'</td>';
			print '<td colspan="3"><input type="text" size="70" maxlength="200" name="bairro" id="bairro" value="'. $object->jabberid .'"></td>';			
			print '</tr>';
			//cidade	
			print '</td><td>'.$langs->trans('CidadeW').'</td><td colspan="3">';
			print '<input type="text" size="70" maxlength="200" name="ville" id="ville" value="'. $object->ville .'">';
			print '</td></tr>';
			
			
			
			

//            // Address
//            print '<tr><td>'.$langs->trans("Address").'</td><td colspan="3"><textarea class="flat" name="address" cols="70">'.(isset($_POST["address"])?$_POST["address"]:$object->address).'</textarea></td>';
//
//            // Zip / Town
//            print '<tr><td>'.$langs->trans("Zip").' / '.$langs->trans("Town").'</td><td colspan="3">';
//            print $formcompany->select_ziptown((isset($_POST["zipcode"])?$_POST["zipcode"]:$object->zip),'zipcode',array('town','selectpays_id','departement_id'),6).'&nbsp;';
//            print $formcompany->select_ziptown((isset($_POST["town"])?$_POST["town"]:$object->town),'town',array('zipcode','selectpays_id','departement_id'));
//            print '</td></tr>';
//
//            // Country
//            print '<tr><td>'.$langs->trans("Country").'</td><td colspan="3">';
//            $form->select_pays(isset($_POST["pays_id"])?$_POST["pays_id"]:$object->fk_pays,'pays_id');
//            if ($user->admin) print info_admin($langs->trans("YouCanChangeValuesForThisListFromDictionnarySetup"),1);
//            print '</td></tr>';
//
//            // State
//            if (empty($conf->global->SOCIETE_DISABLE_STATE))
//            {
//                print '<tr><td>'.$langs->trans('State').'</td><td colspan="3">';
//                $formcompany->select_departement($object->fk_departement,$object->pays_code);
//                print '</td></tr>';
//            }

            // Phone
            print '<tr><td>'.$langs->trans("PhonePro").'</td><td><input name="phone_pro" type="text" size="18" maxlength="80" value="'.(isset($_POST["phone_pro"])?$_POST["phone_pro"]:$object->phone_pro).'"></td>';
            print '<td>'.$langs->trans("PhonePerso").'</td><td><input name="phone_perso" type="text" size="18" maxlength="80" value="'.(isset($_POST["phone_perso"])?$_POST["phone_perso"]:$object->phone_perso).'"></td></tr>';

            print '<tr><td>'.$langs->trans("PhoneMobile").'</td><td><input name="phone_mobile" type="text" size="18" maxlength="80" value="'.(isset($_POST["phone_mobile"])?$_POST["phone_mobile"]:$object->phone_mobile).'"></td>';
            print '<td>'.$langs->trans("Fax").'</td><td><input name="fax" type="text" size="18" maxlength="80" value="'.(isset($_POST["fax"])?$_POST["fax"]:$object->fax).'"></td></tr>';

            // EMail
            print '<tr><td>'.$langs->trans("EMail").'</td><td><input name="email" type="text" size="40" maxlength="80" value="'.(isset($_POST["email"])?$_POST["email"]:$object->email).'"></td>';
            if ($conf->mailing->enabled)
            {
                $langs->load("mails");
                print '<td nowrap>'.$langs->trans("NbOfEMailingsReceived").'</td>';
                print '<td>'.$object->getNbOfEMailings().'</td>';
            }
            else
            {
                print '<td colspan="2">&nbsp;</td>';
            }
            print '</tr>';
//
//            // Jabberid
//            print '<tr><td>Jabberid</td><td colspan="3"><input name="jabberid" type="text" size="40" maxlength="80" value="'.(isset($_POST["jabberid"])?$_POST["jabberid"]:$object->jabberid).'"></td></tr>';

//            // Visibility
//            print '<tr><td>'.$langs->trans("ContactVisibility").'</td><td colspan="3">';
//            $selectarray=array('0'=>$langs->trans("ContactPublic"),'1'=>$langs->trans("ContactPrivate"));
//            print $form->selectarray('priv',$selectarray,$object->priv,0);
//            print '</td></tr>';

            print '<tr><td valign="top">'.$langs->trans("Note").'</td><td colspan="3">';
            print '<textarea name="note" cols="70" rows="'.ROWS_3.'">';
            print isset($_POST["note"])?$_POST["note"]:$object->note;
            print '</textarea></td></tr>';

            $object->load_ref_elements();

           /* if ($conf->commande->enabled)
            {
                print '<tr><td>'.$langs->trans("ContactForOrders").'</td><td colspan="3">';
                print $object->ref_commande?$object->ref_commande:$langs->trans("NoContactForAnyOrder");
                print '</td></tr>';
            }

            if ($conf->propal->enabled)
            {
                print '<tr><td>'.$langs->trans("ContactForProposals").'</td><td colspan="3">';
                print $object->ref_propal?$object->ref_propal:$langs->trans("NoContactForAnyProposal");
                print '</td></tr>';
            }

            if ($conf->contrat->enabled)
            {
                print '<tr><td>'.$langs->trans("ContactForContracts").'</td><td colspan="3">';
                print $object->ref_contrat?$object->ref_contrat:$langs->trans("NoContactForAnyContract");
                print '</td></tr>';
            }

            if ($conf->facture->enabled)
            {
                print '<tr><td>'.$langs->trans("ContactForInvoices").'</td><td colspan="3">';
                print $object->ref_facturation?$object->ref_facturation:$langs->trans("NoContactForAnyInvoice");
                print '</td></tr>';
            }

            // Login Dolibarr
            print '<tr><td>'.$langs->trans("DolibarrLogin").'</td><td colspan="3">';
            if ($object->user_id)
            {
                $dolibarr_user=new User($db);
                $result=$dolibarr_user->fetch($object->user_id);
                print $dolibarr_user->getLoginUrl(1);
            }
            else print $langs->trans("NoDolibarrAccess");
            print '</td></tr>';*/

            print '</table><br>';

            print '<center>';
            print '<input type="submit" class="button" name="save" value="'.$langs->trans("Save").'">';
            print ' &nbsp; ';
            print '<input type="submit" class="button" name="cancel" value="'.$langs->trans("Cancel").'">';
            print '</center>';

            print "</form>";
        }
    }

    if (GETPOST("id") && GETPOST("action") != 'edit')
    {
        $objsoc = new Societe($db);

        /*
         * Fiche en mode visualisation
         */

        dol_htmloutput_errors($error,$errors);

        if ($_GET["action"] == 'create_user')
        {
            // Full firstname and name separated with a dot : firstname.name
            include_once(DOL_DOCUMENT_ROOT.'/lib/functions2.lib.php');
            $login=dol_buildlogin($object->nom,$object->prenom);

            $generated_password='';
            if (! $ldap_sid) // TODO ldap_sid ?
            {
				include_once(DOL_DOCUMENT_ROOT.'/lib/security.lib.php');
	        	$generated_password=getRandomPassword('');
            }
            $password=$generated_password;

            // Create a form array
            $formquestion=array(
            array('label' => $langs->trans("LoginToCreate"), 'type' => 'text', 'name' => 'login', 'value' => $login),
            array('label' => $langs->trans("Password"), 'type' => 'text', 'name' => 'password', 'value' => $password),
            //array('label' => $form->textwithpicto($langs->trans("Type"),$langs->trans("InternalExternalDesc")), 'type' => 'select', 'name' => 'intern', 'default' => 1, 'values' => array(0=>$langs->trans('Internal'),1=>$langs->trans('External')))
            );
            $text=$langs->trans("ConfirmCreateContact").'<br>';
            if ($conf->societe->enabled)
            {
                if ($object->socid > 0) $text.=$langs->trans("UserWillBeExternalUser");
                else $text.=$langs->trans("UserWillBeInternalUser");
            }
            $ret=$form->form_confirm($_SERVER["PHP_SELF"]."?id=".$object->id,$langs->trans("CreateDolibarrLogin"),$text,"confirm_create_user",$formquestion,'yes');
            if ($ret == 'html') print '<br>';
        }

        print '<table class="border" width="100%">';

        // Ref
        print '<tr><td width="10%">'.$langs->trans("Ref").'</td><td colspan="3">';
        print $form->showrefnav($object,'id');
        print '</td></tr>';

        // Name
		print '<tr><td width="10%">'.$langs->trans("Label").'</td><td width="30%" colspan="3">'.$object->name.'</td></tr>';
		print '<tr><td width="10%">'.$langs->trans("Company").'</td><td width="30%" colspan="3">'.$object->firstname.'</td></tr>';

        // Company
        if (empty($conf->global->SOCIETE_DISABLE_CONTACTS))
        {
			print '<tr><td>'.$langs->trans("empreW").'</td><td colspan="3">';
            if ($object->socid > 0)
            {
                $objsoc->fetch($object->socid);
                print $objsoc->getNomUrl(1);
            }
            else
            {
                print $langs->trans("ContactNotLinkedToCompany");
            }
            print '</td></tr>';
        }

		// Role
		print '<tr><td>'.$langs->trans("deptoW" ).'</td><td colspan="3">'.$object->poste.'</td>';

        // Civility
        print '<tr><td width="15%">'.$langs->trans("UserTitle").'</td><td colspan="3">';
        print $object->getCivilityLabel();
        print '</td></tr>';

		//endere�o completo
		//CEP, cadastro
		print '<tr><td>'. $langs->trans('CEPW').'</td>';
		print '<td colspan="3">'. $object->cp .'</td>';			
		print '</tr>';
		//rua, cadastro
		print '</tr>';
		print '<tr><td>'. $langs->trans('RuaW').'</td>';
		print '<td colspan="3">'. $object->address .'</td>';			
		print '</tr>';	
		//numemro, cadastro
		print '</tr>';
		print '<tr><td>'. $langs->trans('NumW').'</td>';
		print '<td colspan="3">'. $object->default_lang .'</td>';			
		print '</tr>';
		//complemento, cadastro
		print '</tr>';
		print '<tr><td>'. $langs->trans('ComplementoW').'</td>';
		print '<td colspan="3">'. $object->priv .'</td>';			
		print '</tr>';	
		//bairro, cadastro
		print '</tr>';
		print '<tr><td>'. $langs->trans('BairroW').'</td>';
		print '<td colspan="3">'. $object->jabberid .'</td>';			
		print '</tr>';
		//cidade	
		print '</td><td>'.$langs->trans('CidadeW').'</td><td colspan="3">';
		print $object->ville;
		print '</td></tr>';


//        // Address
//        print '<tr><td>'.$langs->trans("Address").'</td><td colspan="3">';
//        dol_print_address($object->address,'gmap','contact',$object->id);
//        print '</td></tr>';
//
//        // Zip Town
//        print '<tr><td>'.$langs->trans("Zip").' / '.$langs->trans("Town").'</td><td colspan="3">';
//        print $object->cp;
//        if ($object->cp) print '&nbsp;';
//        print $object->ville.'</td></tr>';
//
//        // Country
//        print '<tr><td>'.$langs->trans("Country").'</td><td colspan="3">';
//        $img=picto_from_langcode($object->pays_code);
//        if ($img) print $img.' ';
//        print $object->pays;
//        print '</td></tr>';

        // State
//        if (empty($conf->global->SOCIETE_DISABLE_STATE))
//        {
//            print '<tr><td>'.$langs->trans('State').'</td><td colspan="3">'.$object->departement.'</td>';
//        }

        // Phone
        print '<tr><td>'.$langs->trans("PhonePro").'</td><td>'.dol_print_phone($object->phone_pro,$object->pays_code,$object->id,$object->socid,'AC_TEL').'</td>';
        print '<td>'.$langs->trans("PhonePerso").'</td><td>'.dol_print_phone($object->phone_perso,$object->pays_code,$object->id,$object->socid,'AC_TEL').'</td></tr>';

        print '<tr><td>'.$langs->trans("PhoneMobile").'</td><td>'.dol_print_phone($object->phone_mobile,$object->pays_code,$object->id,$object->socid,'AC_TEL').'</td>';
        print '<td>'.$langs->trans("Fax").'</td><td>'.dol_print_phone($object->fax,$object->pays_code,$object->id,$object->socid,'AC_FAX').'</td></tr>';

        // Email
        print '<tr><td>'.$langs->trans("EMail").'</td><td>'.dol_print_email($object->email,$object->id,$object->socid,'AC_EMAIL').'</td>';
        if ($conf->mailing->enabled)
        {
            $langs->load("mails");
            print '<td nowrap>'.$langs->trans("NbOfEMailingsReceived").'</td>';
            print '<td><a href="'.DOL_URL_ROOT.'/comm/mailing/liste.php?filteremail='.urlencode($object->email).'">'.$object->getNbOfEMailings().'</a></td>';
        }
        else
        {
            print '<td colspan="2">&nbsp;</td>';
        }
        print '</tr>';

        /*// Instant message
        print '<tr><td>'.$langs->trans("IM").'</td><td colspan="3">'.$object->jabberid.'</td></tr>';

        print '<tr><td>'.$langs->trans("ContactVisibility").'</td><td colspan="3">';
        print $object->LibPubPriv($object->priv);
        print '</td></tr>';*/

        print '<tr><td valign="top">'.$langs->trans("Note").'</td><td colspan="3">';
        print nl2br($object->note);
        print '</td></tr>';

        $object->load_ref_elements();

       /* if ($conf->commande->enabled)
        {
            print '<tr><td>'.$langs->trans("ContactForOrders").'</td><td colspan="3">';
            print $object->ref_commande?$object->ref_commande:$langs->trans("NoContactForAnyOrder");
            print '</td></tr>';
        }

        if ($conf->propal->enabled)
        {
            print '<tr><td>'.$langs->trans("ContactForProposals").'</td><td colspan="3">';
            print $object->ref_propal?$object->ref_propal:$langs->trans("NoContactForAnyProposal");
            print '</td></tr>';
        }

        if ($conf->contrat->enabled)
        {
            print '<tr><td>'.$langs->trans("ContactForContracts").'</td><td colspan="3">';
            print $object->ref_contrat?$object->ref_contrat:$langs->trans("NoContactForAnyContract");
            print '</td></tr>';
        }

        if ($conf->facture->enabled)
        {
            print '<tr><td>'.$langs->trans("ContactForInvoices").'</td><td colspan="3">';
            print $object->ref_facturation?$object->ref_facturation:$langs->trans("NoContactForAnyInvoice");
            print '</td></tr>';
        }*/

       /* print '<tr><td>'.$langs->trans("DolibarrLogin").'</td><td colspan="3">';
        if ($object->user_id)
        {
            $dolibarr_user=new User($db);
            $result=$dolibarr_user->fetch($object->user_id);
            print $dolibarr_user->getLoginUrl(1);
        }
        else print $langs->trans("NoDolibarrAccess");
        print '</td></tr>';*/

        print "</table>";

        print "</div>";

        // Barre d'actions
        if (! $user->societe_id)
        {
            print '<div class="tabsAction">';

            if ($user->rights->societe->contact->creer)
            {
                print '<a class="butAction" href="fiche.php?id='.$object->id.'&amp;action=edit">'.$langs->trans('Modify').'</a>';
            }

            if (! $object->user_id && $user->rights->user->user->creer)
            {
                print '<a class="butAction" href="fiche.php?id='.$object->id.'&amp;action=create_user">'.$langs->trans("CreateDolibarrLogin").'</a>';
            }

            if ($user->rights->societe->contact->supprimer)
            {
                print '<a class="butActionDelete" href="fiche.php?id='.$object->id.'&amp;action=delete">'.$langs->trans('Delete').'</a>';
            }

            print "</div><br>";
        }

        print show_actions_todo($conf,$langs,$db,$objsoc,$object);

        print show_actions_done($conf,$langs,$db,$objsoc,$object);
    }
}

$db->close();

llxFooter('$Date: 2011/07/31 23:54:12 $ - $Revision: 1.222 $');
?>
