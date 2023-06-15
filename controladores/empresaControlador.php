<?php

	if($peticionAjax){
		require_once "../modelos/empresaModelo.php";
	}else{
		require_once "./modelos/empresaModelo.php";
	}

	class empresaControlador extends empresaModelo{

		/*--------- Controlador Datos Empresa ---------*/
		public function datos_empresa_controlador(){
			return empresaModelo::datos_empresa_modelo();
		}/* Fin Controlador */


		/*--------- Controlador Agregar Empresa ---------*/
		public function agregar_empresa_controlador(){
			$nombre=mainModel::limpiar_cadena($_POST['empresa_nombre_reg']);
			$email=mainModel::limpiar_cadena($_POST['empresa_email_reg']);
			$telefono=mainModel::limpiar_cadena($_POST['empresa_telefono_reg']);
			$direccion=mainModel::limpiar_cadena($_POST['empresa_direccion_reg']);

			/*== comprobar campos vacios ==*/
			if($nombre=="" || $email=="" || $telefono=="" || $direccion==""){
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"No has LLenado Todos los Campos que son Obligatorios",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			/*== Verificando integridad de los datos ==*/
			if(mainModel::verificar_datos("[a-zA-z0-9áéíóúÁÉÍÓÚñÑ. ]{1,70}",$nombre)){
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"El Nombre no Coincide con el Formato Solicitado",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			if(mainModel::verificar_datos("[0-9()+]{8,20}",$telefono)){
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"El Telefono no Coincide con el Formato Solicitado",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			if(mainModel::verificar_datos("[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ().,#\- ]{1,190}",$direccion)){
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"La Direccion no Coincide con el Formato Solicitado",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"Ha Ingresado un Email no Valido",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			/*== Comprobar Empresas Registradas ==*/
			$check_empresas=mainModel::ejecutar_consulta_simple("SELECT empresa_id FROM empresa");
			if ($check_empresas->rowCount()>=1) {
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"Ya Existe una Empresa Registrada, ya no puedes Registrar mas",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			$datos_empresa_reg=[
				"Nombre"=>$nombre,
				"Email"=>$email,
				"Telefono"=>$telefono,
				"Direccion"=>$direccion
			];

			$agregar_empresa=empresaModelo::agregar_empresa_modelo($datos_empresa_reg);
			if ($agregar_empresa->rowCount()==1) {
				$alerta=[
					"Alerta"=>"recargar",
					"Titulo"=>"Empresa Registrada",
					"Texto"=>"Los Datos de la Empresa se Registraron con Exito",
					"Tipo"=>"success"
				];
			} else {
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"No Hemos Podido Registrar la Empresa, por Favor Intente Nuevamente",
					"Tipo"=>"error"
				];
			}
			echo json_encode($alerta);
		}/* Fin Controlador */


		/*--------- Controlador Actualizar Empresa ---------*/
		public function actualizar_empresa_controlador(){
			$id=mainModel::limpiar_cadena($_POST['empresa_id_up']);
			$nombre=mainModel::limpiar_cadena($_POST['empresa_nombre_up']);
			$email=mainModel::limpiar_cadena($_POST['empresa_email_up']);
			$telefono=mainModel::limpiar_cadena($_POST['empresa_telefono_up']);
			$direccion=mainModel::limpiar_cadena($_POST['empresa_direccion_up']);

			/*== comprobar campos vacios ==*/
			if($nombre=="" || $email=="" || $telefono=="" || $direccion==""){
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"No has LLenado Todos los Campos que son Obligatorios",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			/*== Verificando integridad de los datos ==*/
			if(mainModel::verificar_datos("[a-zA-z0-9áéíóúÁÉÍÓÚñÑ. ]{1,70}",$nombre)){
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"El Nombre no Coincide con el Formato Solicitado",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			if(mainModel::verificar_datos("[0-9()+]{8,20}",$telefono)){
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"El Telefono no Coincide con el Formato Solicitado",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			if(mainModel::verificar_datos("[a-zA-Z0-9áéíóúÁÉÍÓÚñÑ().,#\- ]{1,190}",$direccion)){
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"La Direccion no Coincide con el Formato Solicitado",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"Ha Ingresado un Email no Valido",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}


			/*== Comprobando Privlegios ==*/
			session_start(['name'=>'SPM']);
			if ($_SESSION['privilegio_spm']<1 || $_SESSION['privilegio_spm']>2) {
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"Ha Ingresado un Email no ValidNo 	Tienes los Permiosos Necesarios para Ejecutar esta Operacion",
					"Tipo"=>"error"
				];
				echo json_encode($alerta);
				exit();
			}

			$datos_empresa_up=[
				"ID"=>$id,
				"Nombre"=>$nombre,
				"Email"=>$email,
				"Telefono"=>$telefono,
				"Direccion"=>$direccion
			];

			if (empresaModelo::actualizar_empresa_modelo($datos_empresa_up)) {
				$alerta=[
					"Alerta"=>"recargar",
					"Titulo"=>"Empresa Actualizado",
					"Texto"=>"Los Datos de la Empresa han Sido Actualizados con Exito",
					"Tipo"=>"success"
				];
			} else {
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"No Hemos Podido Actualizar los Datos de la Empresa, por Favor Intente Nuevamente",
					"Tipo"=>"error"
				];
			}
			echo json_encode($alerta);
		}/* Fin Controlador */
	}