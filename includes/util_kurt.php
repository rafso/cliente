<?php

//arquivo de apoio

if ($_REQUEST['lignesubcentro']) { //está editando uma transação
	subCentroCusto($_REQUEST['lignecentro'], $_REQUEST['lignesubcentro'], 1);
}
else if (strstr($_POST['action'], '1')){
	subCentroCusto($_POST['id_centro'], $_POST['id_sub'], $_POST['action']);
} else if (strstr($_POST['action'], '2'))  { //controlando os selects da busca
		subCentroCusto($_POST['id_centro'], $_POST['SubCentroSearch'], $_POST['action']);
} else if (strstr($_POST['action'], 'datepicker'))  { //controlando os selects do calendário do site
	datePickerSite();
}else if (strstr($_POST['action'], 'exibedia'))  { //controlando os selects do calendário do site
		exibeDia($_POST['#038;mes'], $_POST['#038;ano']);
} else if (strstr($_POST['action'], 'exibeHora'))  { //controlando os selects do calendário do site
	exibeHora($_POST['dia'], $_POST['mes'],  $_POST['ano']);
} else if (strstr($_POST['action'], 'gravaDados'))  { //controlando os selects do calendário do site
		gravaDados($_POST['ano'], $_POST['mes'], $_POST['dia'], $_POST['hora']);
	}
	else { //buscando
	subCentroCusto($_POST['centroSearch'], $_POST['SubCentroSearch'], $_POST['action']);
	}

function subCentroCusto($id, $selected, $controle){
	if ($id == '') $id = 0;
	if ($selected == '') $selected = 0;
	$usu = "tescom_cliente"; //usuario - tescom_cliente
	$pass = "1kSP03180a"; //senha - 1kSP03180a
	$db = "tescom_cliente"; //banco
	$host = "localhost";
	$link = mysql_connect($host, $usu, $pass) or die("Não foi possível conectar: " . mysql_error());
	mysql_select_db($db);

	$sql1 = 'SELECT id, descricao FROM llx_sub_centro_custo WHERE fk_id_centro = '. $id;
	$resql1 = mysql_query($sql1);
	if ($controle == 1) {
	$select .= '<td><div id="divCentro"><select name="subcentro1">';
	} else { 
		$select .= '<td><div id="divCentro"><select name="SubCentroSearch">';
		}
	$select .= '<option value="0"></option>';
	while ($row = mysql_fetch_array($resql1)) {
		$id_sub = $row['id'];
		$desc_sub = $row['descricao'];
		if ($selected == $id_sub){
			$select .= '<option value="'.$id_sub.'" selected>'.$desc_sub.'</option>';
		} else {
			$select .= '<option value="'.$id_sub.'">'.$desc_sub.'</option>';
		}
	}
		$select .= '</select></div></td>';
			
	echo utf8_encode($select);
}

function datePickerSite(){
	//incluindo os arquivos do jquery

	?>
		<script type="text/javascript" src="cliente/includes/jquery/js/jquery-latest.min.js"></script>
		<script type="text/javascript">
		function exibeDia(mes) {
		if (mes > 2000) { //usado para reiniciar os campos quando o ano é trocado
			$("#hora").html("Escolha um dia");
			$("#dia").html("Escolha um mes");
			document.getElementById('mes').selectedIndex = 0;
		} //usado para o ajax de alterar o dia de acordo com o mes selecionado
		else {
		$.ajax(
		{
		type: "POST",
		url: "cliente/includes/util_kurt.php",
		data: "action=exibedia&mes="+ mes + "&ano=" + document.getElementById('ano').value,
		beforeSend: function() {
		// enquanto a função esta sendo processada, você
		// pode exibir na tela uma
		// msg de carregando
		$("#hora").html("Escolha um dia");
		$("#dia").html("Aguarde");
		},
		success: function(txt) {
		// pego o id da div que envolve o select com
		// name="id_modelo" e a substituiu
		// com o texto enviado pelo php, que é um novo 
		//select com dados
		$("#dia").html(txt);
		},
		error: function(txt) {
		// em caso de erro você pode dar um alert('erro');
		alert(txt.responseText);
		}
		}
		);
		} //fim do else
		}
	</script>

		<?
	
	//select do ano
	$ano = '<select name="ano" id="ano" onChange="exibeDia(this.value)">';
	for ($i = 2012; $i <= 2030; $i++){
		$ano .= '<option value="'. $i .'">'. $i .'</option>';
		}
	$ano .= '</select>';
	
	//select do mes
	$mes = '<select name="mes" id="mes" onChange="exibeDia(this.value)">';
	$mes .= '<option value="00">Selecione</option>';
	$mes .= '<option value="01">Janeiro</option>';
	$mes .= '<option value="02">Fevereiro</option>';
	$mes .= '<option value="03">Março</option>';
	$mes .= '<option value="04">Abril</option>';
	$mes .= '<option value="05">Maio</option>';
	$mes .= '<option value="06">Junho</option>';
	$mes .= '<option value="07">Julho</option>';
	$mes .= '<option value="08">Agosto</option>';
	$mes .= '<option value="09">Setembro</option>';
	$mes .= '<option value="10">Outubro</option>';
	$mes .= '<option value="11">Novembro</option>';
	$mes .= '<option value="12">Dezembro</option>';
	$mes .= '</select>';
	
	$dia = '<div id="dia">Escolha um mês</div>';
	
	$hora = '<div name="hora" id="hora">Escolha um dia</div>';
	
	
	$selects = '<table width="100%"><tr>';
	$selects .= '<td width="20%">Ano:</td>';
	$selects .= '<td width="30%">Mês:</td>';
	$selects .= '<td width="20%">Dia:</td>';
	$selects .= '<td width="20%">Hora:</td></tr>';
	$selects .= '<tr><td>'. $ano .'</td>';
	$selects .= '<td>'. $mes .'</td>';
	$selects .= '<td>'. $dia .'</td>';
	$selects .= '<td>'. $hora .'</td>';
	$selects .= '</tr></table>';
	
	
	
	echo utf8_encode($selects);
	
}

function exibeDia($mes, $ano){
	
	?>
	<script type="text/javascript" src="cliente/includes/jquery/js/jquery-latest.min.js"></script>
	<script type="text/javascript">
	function exibeHora(dia) {
	$.ajax(
	{
	type: "POST",
	url: "cliente/includes/util_kurt.php",
	data: "action=exibeHora&dia=" + dia + "&mes=" + document.getElementById('mes').value + "&ano=" + document.getElementById('ano').value,
	beforeSend: function() {
	// enquanto a função esta sendo processada, você
	// pode exibir na tela uma
	// msg de carregando
	$("#hora").html("Aguarde");
	},
	success: function(txt) {
	// pego o id da div que envolve o select com
	// name="id_modelo" e a substituiu
	// com o texto enviado pelo php, que é um novo 
	//select com dados
	$("#hora").html(txt);
	},
	error: function(txt) {
	// em caso de erro você pode dar um alert('erro');
	alert(txt.responseText);
	}
	}
	);
	}
	</script>
	
	<?

	//verifica se foi selecionado algum mes
	if ($mes <> '00') {
		//pega o ultimo dia do mes escolhido
		$data = mktime(0, 0, 0, $mes, 1, $ano);
		$ultimoDia = date("d",$data-1);
		//criando um array multidimensional com todos os dias do mês e 4 espaços em cada dia para os horários
		for ($k = 1; $k <= $ultimoDia; $k++){
			$arr[$k] = array(8, 10, 13, 15);
		}
		
		$usu = "tescom_cliente"; //usuario - tescom_cliente
		$pass = "1kSP03180a"; //senha - 1kSP03180a
		$db = "tescom_cliente"; //banco
		$host = "localhost";
		$link = mysql_connect($host, $usu, $pass) or die("Não foi possível conectar: " . mysql_error());
		mysql_select_db($db);
		
		//verifica na agenda por todos os dias do mês pedido para
		
		//selecionar para um determinado mês, quais dias e horários possuem visita na agenda
		$sql1 = 'SELECT id as mes, EXTRACT(DAY FROM datep) as dia, EXTRACT(hour FROM datep) as hora FROM llx_actioncomm WHERE (fk_action = 51 OR fk_action = 52) AND (EXTRACT(MONTH FROM datep) = "'. $mes .'") AND (EXTRACT(YEAR FROM datep) = "'. $ano .'")';
		$resql1 = mysql_query($sql1);
		//$select .= '<td><div id="divCentro"><select name="subcentro1">';
		$select = '<select name="dia1" id="dia1" onChange="exibeHora(this.value)"><option value="0">Selecione</option>';
		while ($row = mysql_fetch_array($resql1)) {
			//preencher o array de dias com os dias e horários ocupados
			for ($k = 1; $k <= $ultimoDia; $k++){
				if ($k == $row['dia']){
					//verifica se o indice foi preenchido, se foi passa para o próximo indice
					if (($row['hora'] >= 8) && ($row['hora'] < 10)){
						unset($arr[$k][0]);
					} else if (($row['hora'] >= 10) && ($row['hora'] < 13)){
						unset($arr[$k][1]);
					}  else if (($row['hora'] >= 13) && ($row['hora'] < 15)){
						unset($arr[$k][2]);
					}  else if ($row['hora'] >= 15){
						unset($arr[$k][3]);
						}
				}
			}
		}
		
		//for para preencher o select com os indices que sobraram no array
		for ($k = 1; $k <= $ultimoDia; $k++){
			//for ($h = 0; $h < count($arr[$k]); $h++) {
			if (count($arr[$k]) > 0){
				$select .= '<option value="'. $k .'">'. $k .'</option>';	
			}
			//}
		}
		
		$select .= '</select>';
		echo $select;
	}
}

function exibeHora($dia, $mes, $ano) {
	
	?>
	<script type="text/javascript" src="cliente/includes/jquery/js/jquery-latest.min.js"></script>
	<script type="text/javascript">
	function gravaDados(ano, mes, dia, hora) {
	$.ajax(
	{
	type: "POST",
	url: "cliente/includes/util_kurt.php",
	data: "action=gravaDados&ano=" + ano + "&mes=" + mes + "&dia=" + dia + "&hora=" + hora,
	beforeSend: function() {
	// enquanto a função esta sendo processada, você
	// pode exibir na tela uma
	// msg de carregando
	},
	success: function(txt) {
	// pego o id da div que envolve o select com
	// name="id_modelo" e a substituiu
	// com o texto enviado pelo php, que é um novo 
	//select com dados
	},
	error: function(txt) {
	// em caso de erro você pode dar um alert('erro');
	alert(txt.responseText);
	}
	}
	);
	}
	</script>
	
	<?
		
	//verifica se foi selecionado algum mes
	if ($dia <> '0') {
		
		//array com as horas disponiveis para visita por dia
		$arr = array(8, 10, 13, 15);
		
		
		$usu = "tescom_cliente"; //usuario - tescom_cliente
		$pass = "1kSP03180a"; //senha - 1kSP03180a
		$db = "tescom_cliente"; //banco
		$host = "localhost";
		$link = mysql_connect($host, $usu, $pass) or die("Não foi possível conectar: " . mysql_error());
		mysql_select_db($db);
		
		//verifica na agenda por todos os dias do mês pedido para
		
		//selecionar para um determinado mês, quais dias e horários possuem visita na agenda
		$sql1 = 'SELECT id, EXTRACT(hour FROM datep) as hora FROM llx_actioncomm WHERE (fk_action = 51 OR fk_action = 52) AND (EXTRACT(MONTH FROM datep) = "'. $mes .'") AND (EXTRACT(DAY FROM datep) = "'. $dia .'") AND (EXTRACT(YEAR FROM datep) = "'. $ano .'")';
		$resql1 = mysql_query($sql1);
		//$select .= '<td><div id="divCentro"><select name="subcentro1">';
		$select = '<select name="hora1" id="hora1" onChange="gravaDados('. $ano .', '. $mes .', '. $dia .', this.value)"><option value="0">Selecione</option>';
		while ($row = mysql_fetch_array($resql1)) {
			//preencher o array de dias com os dias e horários ocupados
			for ($k = 0; $k < 4; $k++){
					//verifica se o indice foi preenchido, se foi passa para o próximo indice
					if (($row['hora'] >= 8) && ($row['hora'] < 10)){
						$arr[0] = 0;
					} else if (($row['hora'] >= 10) && ($row['hora'] < 13)){
						$arr[1] = 0;
					}  else if (($row['hora'] >= 13) && ($row['hora'] < 15)){
						$arr[2] = 0;
					}  else if ($row['hora'] >= 15){
							$arr[3] = 0;
						}
			}
		}
		
		for ($k = 0; $k < count($arr); $k++){
			if ($arr[$k] > 0) {
				$select .= '<option value="'. $arr[$k] .'">'. $arr[$k] .':00</option>';	
			}
		}
		$select .= '</select>';
		
		echo $select;
	}
		
}

function gravaDados($ano, $mes, $dia, $hora){
	//datavisita.txt
	$fp = fopen("datavisita.txt", "w");
	ftruncate($fp, 0);
	$escreve = fwrite($fp, $dia .";". $mes .";". $ano .";". $hora);
	fclose($fp);
}

?>