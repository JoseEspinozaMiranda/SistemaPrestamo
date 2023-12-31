<?php
	if($peticionAjax){
		require_once "../modelos/loginModelo.php";
	}else{
		require_once "./modelos/loginModelo.php";
	}

	class loginControlador extends loginModelo{

		/*--------- Controlador para Iniciar Sesion ---------*/
		public function iniciar_sesion_controlador(){
			$usuario=mainModel::limpiar_cadena($_POST['usuario_log']);
			$clave=mainModel::limpiar_cadena($_POST['clave_log']);

			/*== Comprobar Campos Vacios ==*/
			if ($usuario=="" || $clave=="") {
				echo '
				<script>
				    Swal.fire({
					    title: "Ocurrió un Error Inesperado",
					    text: "No has LLenado Todos los Campos que son Requeridos",
				    	type: "error",
				    	confirmButtonText: "Aceptar"
		  		  	});
				</script>
				';
				exit();
			}


				/*== Verificando la Integridad de los Datos ==*/
				if (mainModel::verificar_datos("[a-zA-Z0-9]{1,35}",$usuario)) {
					echo '
					<script>
					    Swal.fire({
					    title: "Ocurrió un Error Inesperado",
					    text: "El NOMBRE DE USUARIO no Coincide con el Formato Solicitado",
					  	type: "error",
				    	confirmButtonText: "Aceptar"
				    	});
					</script>
					';
					exit();
				}

				if (mainModel::verificar_datos("[a-zA-Z0-9$@.-]{7,100}",$clave)) {
					echo '
					<script>
					    Swal.fire({
					    	title: "Ocurrió un Error Inesperado",
					   		 text: "La CLAVE no Coincide con el Formato Solicitado",
					  		type: "error",
				    		confirmButtonText: "Aceptar"
				    	});
					</script>
					';
					exit();
				}

				$clave=mainModel::encryption($clave);

				$datos_login=[
					"Usuario"=>$usuario,
					"Clave"=>$clave
				];

				$datos_cuenta=loginModelo::iniciar_sesion_modelo($datos_login);

				if ($datos_cuenta->rowCount()==1) {
					$row=$datos_cuenta->fetch();

					session_start(['name'=>'SPM']);

					$_SESSION['id_spm']=$row['usuario_id'];
					$_SESSION['nombre_spm']=$row['usuario_nombre'];
					$_SESSION['apellido_spm']=$row['usuario_apellido'];
					$_SESSION['usuario_spm']=$row['usuario_usuario'];
					$_SESSION['privilegio_spm']=$row['usuario_privilegio'];
					$_SESSION['token_spm']=md5(uniqid(mt_rand(),true));

					if (headers_sent()) {
						echo "<script> window.location.href='".SERVERURL."home/'; </script>";
					} else {
						return header("Location: ".SERVERURL."home/");
					}
				} else {
					echo '
					<script>
					   Swal.fire({
						title: "Ocurrió un Error Inesperado",
						text: "El USUARIO o CLAVE son Incorrectos",
					  	type: "error",
					    confirmButtonText: "Aceptar"
					    });
					</script>
					';
				}
		} /* Fin Controlador */



		/*--------- Controlador para Forzar Cierre de Sesion ---------*/
		public function forzar_cierre_sesion_controlador(){
			session_unset();
			session_destroy();
			if (headers_sent()) {
				echo "<script> window.location.href='".SERVERURL."login/'; </script>";
			} else {
				return header("Location: ".SERVERURL."login/");
			}
		}/* Fin Controlador */


		/*--------- Controlador para Cierre de Sesion ---------*/
		public function cerrar_sesion_controlador(){
			session_start(['name'=>'SPM']);
			$token=mainModel::decryption($_POST['token']);
			$usuario=mainModel::decryption($_POST['usuario']);

			if ($token==$_SESSION['token_spm'] && $usuario==$_SESSION['usuario_spm']) {
				session_unset();
				session_destroy();
				$alerta=[
					"Alerta"=>"redireccionar",
					"URL"=>SERVERURL."login/"
				];
			} else {
				$alerta=[
					"Alerta"=>"simple",
					"Titulo"=>"Ocurrió un Error Inesperado",
					"Texto"=>"No se Pudo Cerrar la Sesion en el Sistema",
					"Tipo"=>"error"
				];
			}
			echo json_encode($alerta);
		}/* Fin Controlador */
	}