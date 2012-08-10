<?php
/* Copyright (C) 2001-2003 Rodolphe Quiedeville  <rodolphe@quiedeville.org>
 * Copyright (C) 2004-2011 Laurent Destailleur   <eldy@users.sourceforge.net>
 * Copyright (C) 2005-2009 Regis Houssin         <regis@dolibarr.fr>
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
 *       \file        htdocs/compta/stats/casoc.php
 *       \brief       Page reporting CA par societe
 *       \version     $Id: casoc.php,v 1.49 2011/07/31 22:23:14 eldy Exp $
 */

require('../../main.inc.php');
require_once(DOL_DOCUMENT_ROOT."/lib/report.lib.php");
require_once(DOL_DOCUMENT_ROOT."/lib/tax.lib.php");
require_once(DOL_DOCUMENT_ROOT."/lib/date.lib.php");

$langs->load("companies");

// Define modecompta ('CREANCES-DETTES' or 'RECETTES-DEPENSES')
$modecompta = $conf->global->COMPTA_MODE;
if (GETPOST("modecompta")) $modecompta=GETPOST("modecompta");

$sortorder=isset($_GET["sortorder"])?$_GET["sortorder"]:$_POST["sortorder"];
$sortfield=isset($_GET["sortfield"])?$_GET["sortfield"]:$_POST["sortfield"];
if (! $sortorder) $sortorder="asc";
if (! $sortfield) $sortfield="nom";

// Security check
$socid = isset($_REQUEST["socid"])?$_REQUEST["socid"]:'';
if ($user->societe_id > 0) $socid = $user->societe_id;
if (!$user->rights->compta->resultat->lire && !$user->rights->accounting->comptarapport->lire) accessforbidden();

// Date range
$year=GETPOST("year");
$month=GETPOST("month");
if (empty($year))
{
	$year_current = strftime("%Y",dol_now());
	$month_current = strftime("%m",dol_now());
	$year_start = $year_current;
} else {
	$year_current = $year;
	$month_current = strftime("%m",dol_now());
	$year_start = $year;
}
$date_start=dol_mktime(0,0,0,$_REQUEST["date_startmonth"],$_REQUEST["date_startday"],$_REQUEST["date_startyear"]);
$date_end=dol_mktime(23,59,59,$_REQUEST["date_endmonth"],$_REQUEST["date_endday"],$_REQUEST["date_endyear"]);
// Quarter
if (empty($date_start) || empty($date_end)) // We define date_start and date_end
{
	$q=GETPOST("q")?GETPOST("q"):0;
	if ($q==0)
	{
		// We define date_start and date_end
		$month_start=GETPOST("month")?GETPOST("month"):($conf->global->SOCIETE_FISCAL_MONTH_START?($conf->global->SOCIETE_FISCAL_MONTH_START):1);
		$year_end=$year_start;
		$month_end=$month_start;
		if (! GETPOST("month"))	// If month not forced
		{
			if (! GETPOST('year') && $month_start > $month_current)
			{
				$year_start--;
				$year_end--;
			}
			$month_end=$month_start-1;
			if ($month_end < 1) $month_end=12;
			else $year_end++;
		}
		$date_start=dol_get_first_day($year_start,$month_start,false); $date_end=dol_get_last_day($year_end,$month_end,false);
	}
	if ($q==1) { $date_start=dol_get_first_day($year_start,1,false); $date_end=dol_get_last_day($year_start,3,false); }
	if ($q==2) { $date_start=dol_get_first_day($year_start,4,false); $date_end=dol_get_last_day($year_start,6,false); }
	if ($q==3) { $date_start=dol_get_first_day($year_start,7,false); $date_end=dol_get_last_day($year_start,9,false); }
	if ($q==4) { $date_start=dol_get_first_day($year_start,10,false); $date_end=dol_get_last_day($year_start,12,false); }
}
else
{
	// TODO We define q

}



/*
 * View
 */

llxHeader();

$html=new Form($db);
$thirdparty_static=new Societe($db);

// Affiche en-tete de rapport
if ($modecompta=="CREANCES-DETTES")
{
	$nom=$langs->trans("SalesTurnover").', '.$langs->trans("ByThirdParties");
	$nom.='<br>('.$langs->trans("SeeReportInInputOutputMode",'<a href="'.$_SERVER["PHP_SELF"].'?year='.$year.'&modecompta=RECETTES-DEPENSES">','</a>').')';
	$period=$html->select_date($date_start,'date_start',0,0,0,'',1,0,1).' - '.$html->select_date($date_end,'date_end',0,0,0,'',1,0,1);
	//$periodlink='<a href="'.$_SERVER["PHP_SELF"].'?year='.($year-1).'&modecompta='.$modecompta.'">'.img_previous().'</a> <a href="'.$_SERVER["PHP_SELF"].'?year='.($year+1).'&modecompta='.$modecompta.'">'.img_next().'</a>';
	$description=$langs->trans("RulesCADue");
	if (! empty($conf->global->FACTURE_DEPOSITS_ARE_JUST_PAYMENTS)) $description.= $langs->trans("DepositsAreNotIncluded");
	else  $description.= $langs->trans("DepositsAreIncluded");
	$builddate=time();
	//$exportlink=$langs->trans("NotYetAvailable");
}
else {
	$nom=$langs->trans("SalesTurnover").', '.$langs->trans("ByThirdParties");
	$nom.='<br>('.$langs->trans("SeeReportInDueDebtMode",'<a href="'.$_SERVER["PHP_SELF"].'?year='.$year.'&modecompta=CREANCES-DETTES">','</a>').')';
	$period=$html->select_date($date_start,'date_start',0,0,0,'',1,0,1).' - '.$html->select_date($date_end,'date_end',0,0,0,'',1,0,1);
	//$periodlink='<a href="'.$_SERVER["PHP_SELF"].'?year='.($year-1).'&modecompta='.$modecompta.'">'.img_previous().'</a> <a href="'.$_SERVER["PHP_SELF"].'?year='.($year+1).'&modecompta='.$modecompta.'">'.img_next().'</a>';
	$description=$langs->trans("RulesCAIn");
	$description.= $langs->trans("DepositsAreIncluded");
	$builddate=time();
	//$exportlink=$langs->trans("NotYetAvailable");
}
$moreparam=array();
if (! empty($modecompta)) $moreparam['modecompta']=$modecompta;
report_header($nom,$nomlink,$period,$periodlink,$description,$builddate,$exportlink,$moreparam);


// Charge tableau
$catotal=0;
if ($modecompta == 'CREANCES-DETTES')
{
	$sql = "SELECT s.rowid as socid, s.nom as name, sum(f.total) as amount, sum(f.total_ttc) as amount_ttc";
	$sql.= " FROM ".MAIN_DB_PREFIX."societe as s";
	$sql.= ", ".MAIN_DB_PREFIX."facture as f";
	$sql.= " WHERE f.fk_statut in (1,2)";
	if (! empty($conf->global->FACTURE_DEPOSITS_ARE_JUST_PAYMENTS)) $sql.= " AND f.type IN (0,1,2)";
	else $sql.= " AND f.type IN (0,1,2,3)";
	$sql.= " AND f.fk_soc = s.rowid";
	if ($date_start && $date_end) $sql.= " AND f.datef >= '".$db->idate($date_start)."' AND f.datef <= '".$db->idate($date_end)."'";
}
else
{
	/*
	 * Liste des paiements (les anciens paiements ne sont pas vus par cette requete car, sur les
	 * vieilles versions, ils n'etaient pas lies via paiement_facture. On les ajoute plus loin)
	 */
	$sql = "SELECT s.rowid as socid, s.nom as name, sum(pf.amount) as amount_ttc";
	$sql .= " FROM ".MAIN_DB_PREFIX."societe as s";
	$sql.= ", ".MAIN_DB_PREFIX."facture as f";
	$sql.= ", ".MAIN_DB_PREFIX."paiement_facture as pf";
	$sql.= ", ".MAIN_DB_PREFIX."paiement as p";
	$sql .= " WHERE p.rowid = pf.fk_paiement";
	$sql.= " AND pf.fk_facture = f.rowid";
	$sql.= " AND f.fk_soc = s.rowid";
	if ($date_start && $date_end) $sql.= " AND p.datep >= '".$db->idate($date_start)."' AND p.datep <= '".$db->idate($date_end)."'";
}
$sql.= " AND f.entity = ".$conf->entity;
if ($socid) $sql.= " AND f.fk_soc = ".$socid;
$sql.= " GROUP BY s.rowid, s.nom";
$sql.= " ORDER BY s.rowid";

$result = $db->query($sql);
if ($result)
{
	$num = $db->num_rows($result);
	$i=0;
	while ($i < $num)
	{
		$obj = $db->fetch_object($result);
		$amount[$obj->socid] += $obj->amount_ttc;
		$name[$obj->socid] = $obj->name;
		$catotal+=$obj->amount_ttc;
		$i++;
	}
}
else {
	dol_print_error($db);
}

// On ajoute les paiements anciennes version, non lies par paiement_facture
if ($modecompta != 'CREANCES-DETTES')
{
	$sql = "SELECT '0' as socid, 'Autres' as name, sum(p.amount) as amount_ttc";
	$sql.= " FROM ".MAIN_DB_PREFIX."bank as b";
	$sql.= ", ".MAIN_DB_PREFIX."bank_account as ba";
	$sql.= ", ".MAIN_DB_PREFIX."paiement as p";
	$sql.= " LEFT JOIN ".MAIN_DB_PREFIX."paiement_facture as pf ON p.rowid = pf.fk_paiement";
	$sql.= " WHERE pf.rowid IS NULL";
	$sql.= " AND p.fk_bank = b.rowid";
	$sql.= " AND b.fk_account = ba.rowid";
	$sql.= " AND ba.entity = ".$conf->entity;
	//feito para o kurt, um sql diferente se o usu�rio for o CBA (id 7), ele s� pode ver a conta mineirao (id 3)
	if ($user->id == 7) {
		$sql .= " AND ba.rowid = 3";
	}
	if ($date_start && $date_end) $sql.= " AND p.datep >= '".$db->idate($date_start)."' AND p.datep <= '".$db->idate($date_end)."'";
	$sql.= " GROUP BY socid, name";
	$sql.= " ORDER BY name";

	$result = $db->query($sql);
	if ($result)
	{
		$num = $db->num_rows($result);
		$i=0;
		while ($i < $num)
		{
			$obj = $db->fetch_object($result);
			$amount[$obj->rowid] += $obj->amount_ttc;
			$name[$obj->rowid] = $obj->name;
			$catotal+=$obj->amount_ttc;
			$i++;
		}
	}
	else {
		dol_print_error($db);
	}
}


// Show array
$i = 0;
print "<table class=\"noborder\" width=\"100%\">";
print "<tr class=\"liste_titre\">";
print_liste_field_titre($langs->trans("Company"),$_SERVER["PHP_SELF"],"nom","",'&amp;year='.($year).'&modecompta='.$modecompta,"",$sortfield,$sortorder);
print_liste_field_titre($langs->trans("AmountTTC"),$_SERVER["PHP_SELF"],"amount_ttc","",'&amp;year='.($year).'&modecompta='.$modecompta,'align="right"',$sortfield,$sortorder);
print_liste_field_titre($langs->trans("Percentage"),$_SERVER["PHP_SELF"],"amount_ttc","",'&amp;year='.($year).'&modecompta='.$modecompta,'align="right"',$sortfield,$sortorder);
print_liste_field_titre($langs->trans("OtherStatistics"),$_SERVER["PHP_SELF"],"","","",'align="center" width="20%"');
print "</tr>\n";
$var=true;

if (sizeof($amount))
{
	$arrayforsort=$name;

	// On definit tableau arrayforsort
	if ($sortfield == 'nom' && $sortorder == 'asc') {
		asort($name);
		$arrayforsort=$name;
	}
	if ($sortfield == 'nom' && $sortorder == 'desc') {
		arsort($name);
		$arrayforsort=$name;
	}
	if ($sortfield == 'amount_ttc' && $sortorder == 'asc') {
		asort($amount);
		$arrayforsort=$amount;
	}
	if ($sortfield == 'amount_ttc' && $sortorder == 'desc') {
		arsort($amount);
		$arrayforsort=$amount;
	}

	foreach($arrayforsort as $key=>$value)
	{
		$var=!$var;
		print "<tr ".$bc[$var].">";

		// Third party
		$fullname=$name[$key];
		if ($key > 0) {
		    $thirdparty_static->id=$key;
		    $thirdparty_static->name=$fullname;
		    $thirdparty_static->client=1;
		    $linkname=$thirdparty_static->getNomUrl(1,'customer');
		}
		else {
			$linkname=$langs->trans("PaymentsNotLinkedToInvoice");
		}
		print "<td>".$linkname."</td>\n";

		// Amount
		print '<td align="right">';
		if ($modecompta != 'CREANCES-DETTES')
		{
    		if ($key > 0) print '<a href="'.DOL_URL_ROOT.'/compta/paiement/liste.php?socid='.$key.'">';
    		else print '<a href="'.DOL_URL_ROOT.'/compta/paiement/liste.php?orphelins=1">';
		}
		else
		{
            if ($key > 0) print '<a href="'.DOL_URL_ROOT.'/compta/facture.php?socid='.$key.'">';
            else print '<a href="#">';
		}
		print price($amount[$key]);
		print '</a>';
		print '</td>';

		// Percent;
		print '<td align="right">'.($catotal > 0 ? round(100 * $amount[$key] / $catotal, 2).'%' : '&nbsp;').'</td>';

        // Other stats
        print '<td align="center">';
        if ($conf->propal->enabled && $key>0) print '&nbsp;<a href="'.DOL_URL_ROOT.'/comm/propal/stats/index.php?socid='.$key.'">'.img_picto($langs->trans("ProposalStats"),"stats").'</a>&nbsp;';
        if ($conf->commande->enabled && $key>0) print '&nbsp;<a href="'.DOL_URL_ROOT.'/commande/stats/index.php?socid='.$key.'">'.img_picto($langs->trans("OrderStats"),"stats").'</a>&nbsp;';
        if ($conf->facture->enabled && $key>0) print '&nbsp;<a href="'.DOL_URL_ROOT.'/compta/facture/stats/index.php?socid='.$key.'">'.img_picto($langs->trans("InvoiceStats"),"stats").'</a>&nbsp;';
        print '</td>';

		print "</tr>\n";
		$i++;
	}

	// Total
	print '<tr class="liste_total"><td>'.$langs->trans("Total").'</td><td align="right">'.price($catotal).'</td><td>&nbsp;</td>';
	print '<td>&nbsp;</td>';
	print '</tr>';

	$db->free($result);
}

print "</table>";
print '<br>';


llxFooter();

$db->close();
?>