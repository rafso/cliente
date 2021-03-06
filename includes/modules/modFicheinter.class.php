<?php
/* Copyright (C) 2003      Rodolphe Quiedeville <rodolphe@quiedeville.org>
 * Copyright (C) 2004-2009 Laurent Destailleur  <eldy@users.sourceforge.net>
 * Copyright (C) 2004      Sebastien Di Cintio  <sdicintio@ressource-toi.org>
 * Copyright (C) 2004      Benoit Mortier       <benoit.mortier@opensides.be>
 * Copyright (C) 2005-2009 Regis Houssin        <regis@dolibarr.fr>
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
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

/**
 *	\defgroup   ficheinter     Module intervention cards
 *	\brief      Module to manage intervention cards
 *	\version	$Id$
 */

/**
 *	\file       htdocs/includes/modules/modFicheinter.class.php
 *	\ingroup    ficheinter
 *	\brief      Fichier de description et activation du module Ficheinter
 */

include_once(DOL_DOCUMENT_ROOT ."/includes/modules/DolibarrModules.class.php");


/**
 *	\class      modFicheinter
 *	\brief      Classe de description et activation du module Ficheinter
 */
class modFicheinter  extends DolibarrModules
{

    /**
     *   \brief      Constructeur. Definit les noms, constantes et boites
     *   \param      DB      Database access handler
     */
    function modFicheinter($DB)
    {
        global $conf;

        $this->db = $DB ;
        $this->numero = 70 ;

        $this->family = "crm";
        // Module label (no space allowed), used if translation string 'ModuleXXXName' not found (where XXX is value of numeric property 'numero' of module)
        $this->name = preg_replace('/^mod/i','',get_class($this));
        $this->description = "Gestion des fiches d'intervention";

        // Possible values for version are: 'development', 'experimental', 'dolibarr' or version
        $this->version = 'dolibarr';

        $this->const_name = 'MAIN_MODULE_'.strtoupper($this->name);
        $this->special = 0;
        $this->picto = "intervention";

        // Data directories to create when module is enabled
        $this->dirs = array("/ficheinter/temp");

        // Dependencies
        $this->depends = array("modSociete");
        $this->requiredby = array();
        $this->conflictwith = array();
        $this->langfiles = array("bills","companies","interventions");

        // Config pages
        $this->config_page_url = array("fichinter.php");

        // Constantes
        $this->const = array();
        $r=0;

        $this->const[$r][0] = "FICHEINTER_ADDON_PDF";
        $this->const[$r][1] = "chaine";
        $this->const[$r][2] = "soleil";
        $r++;

        $this->const[$r][0] = "FICHEINTER_ADDON";
        $this->const[$r][1] = "chaine";
        $this->const[$r][2] = "pacific";
        $r++;

        // Boites
        $this->boxes = array();

        // Permissions
        $this->rights = array();
        $this->rights_class = 'ficheinter';
        $r=0;

        $r++;
        $this->rights[$r][0] = 61;
        $this->rights[$r][1] = 'Lire les fiches d\'intervention';
        $this->rights[$r][2] = 'r';
        $this->rights[$r][3] = 1;
        $this->rights[$r][4] = 'lire';

        $r++;
        $this->rights[$r][0] = 62;
        $this->rights[$r][1] = 'Creer/modifier les fiches d\'intervention';
        $this->rights[$r][2] = 'w';
        $this->rights[$r][3] = 0;
        $this->rights[$r][4] = 'creer';

        $r++;
        $this->rights[$r][0] = 64;
        $this->rights[$r][1] = 'Supprimer les fiches d\'intervention';
        $this->rights[$r][2] = 'd';
        $this->rights[$r][3] = 0;
        $this->rights[$r][4] = 'supprimer';

        $r++;
        $this->rights[$r][0] = 67;
        $this->rights[$r][1] = 'Exporter les fiches interventions';
        $this->rights[$r][2] = 'r';
        $this->rights[$r][3] = 0;
        $this->rights[$r][4] = 'export';

        $r++;
        $this->rights[$r][0] = 68;
        $this->rights[$r][1] = 'Envoyer les fiches d\'intervention par courriel';
        $this->rights[$r][2] = 'r';
        $this->rights[$r][3] = 0;
        $this->rights[$r][4] = 'ficheinter_advance';      // Visible if option MAIN_USE_ADVANCED_PERMS is on
        $this->rights[$r][5] = 'send';

        //Exports
        //--------
        $r=1;

        $this->export_code[$r]=$this->rights_class.'_'.$r;
        $this->export_label[$r]='InterventionCardsAndInterventionLines';	// Translation key (used only if key ExportDataset_xxx_z not found)
        $this->export_permission[$r]=array(array("ficheinter","export"));
        $this->export_fields_array[$r]=array('s.rowid'=>"IdCompany",'s.nom'=>'CompanyName','s.address'=>'Address','s.cp'=>'Zip','s.ville'=>'Town','s.fk_pays'=>'Country','s.tel'=>'Phone','s.siren'=>'ProfId1','s.siret'=>'ProfId2','s.ape'=>'ProfId3','s.idprof4'=>'ProfId4','s.code_compta'=>'CustomerAccountancyCode','s.code_compta_fournisseur'=>'SupplierAccountancyCode','f.rowid'=>"InterId",'f.ref'=>"InterRef",'f.datec'=>"InterDateCreation",'f.duree'=>"InterDuration",'f.fk_statut'=>'InterStatus','f.description'=>"InterNote",'fd.rowid'=>'InterLineId','fd.date'=>"InterLineDate",'fd.duree'=>"InterLineDuration",'fd.description'=>"InterLineDesc");
        $this->export_entities_array[$r]=array('s.rowid'=>"company",'s.nom'=>'company','s.address'=>'company','s.cp'=>'company','s.ville'=>'company','s.fk_pays'=>'company','s.tel'=>'company','s.siren'=>'company','s.siret'=>'company','s.ape'=>'company','s.idprof4'=>'company','s.code_compta'=>'company','s.code_compta_fournisseur'=>'company','f.rowid'=>"intervention",'f.ref'=>"intervention",'f.datec'=>"intervention",'f.duree'=>"intervention",'f.fk_statut'=>"intervention",'f.description'=>"intervention",'fd.rowid'=>"inter_line",'fd.date'=>"inter_line",'fd.duree'=>'inter_line','fd.description'=>'inter_line');

        $this->export_sql_start[$r]='SELECT DISTINCT ';
        $this->export_sql_end[$r]  =' FROM ('.MAIN_DB_PREFIX.'fichinter as f, '.MAIN_DB_PREFIX.'fichinterdet as fd, '.MAIN_DB_PREFIX.'societe as s)';
        $this->export_sql_end[$r] .=' WHERE f.fk_soc = s.rowid AND f.rowid = fd.fk_fichinter';
        $this->export_sql_end[$r] .=' AND f.entity = '.$conf->entity;
        $r++;

    }


    /**
     *   \brief      Fonction appelee lors de l'activation du module. Insere en base les constantes, boites, permissions du module.
     *               Definit egalement les repertoires de donnees a creer pour ce module.
     */
    function init()
    {
        global $conf;

        // Permissions
        $this->remove();

        $sql = array(
			 "DELETE FROM ".MAIN_DB_PREFIX."document_model WHERE nom = '".$this->const[0][2]."' AND entity = ".$conf->entity,
			 "INSERT INTO ".MAIN_DB_PREFIX."document_model (nom, type, entity) VALUES('".$this->const[0][2]."','ficheinter',".$conf->entity.")",
        );

        return $this->_init($sql);
    }

    /**
     *    \brief      Fonction appelee lors de la desactivation d'un module.
     *                Supprime de la base les constantes, boites et permissions du module.
     */
    function remove()
    {
        $sql = array();

        return $this->_remove($sql);
    }
}
?>
