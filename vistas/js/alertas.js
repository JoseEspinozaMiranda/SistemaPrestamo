const formularios_ajax = document.querySelectorAll(".FormularioAjax");

function enviar_formulario_ajax(e){
	e.preventDefault();

	let data = new FormData(this);
	let method = this.getAttribute("method");
	let action = this.getAttribute("action");
	let tipo = this.getAttribute("data-form");

	let encabezados = new Headers();

	let config = {
		method: method,
		headers: encabezados,
		mode: 'cors',
		cache: 'no-cache',
		body: data
	}

	let texto_alerta;

	if(tipo==="save"){
		texto_alerta="Los Datos Quedaran Guardados en el Sistema";
	}else if(tipo==="delete"){
		texto_alerta="Los Datos Serán Eliminados Completamente del Sistema";
	}else if(tipo==="update"){
		texto_alerta="Los Datos del Sistema Serán Actualizados";
	}else if(tipo==="search"){
		texto_alerta="Se Eliminará el Término de Búsqueda y Tendrás que Escribir uno Nuevo";
	}else if(tipo==="loans"){
		texto_alerta="Desea Remover los Datos Seleccionados para Préstamos o Reservaciones";
	}else{
		texto_alerta="Quieres Realizar la Operación Solicitada";
	}

	Swal.fire({
		title: '¿Estás seguro?',
		text: texto_alerta,
		type: 'question',
		showCancelButton: true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor: '#d33',
		confirmButtonText: 'Aceptar',
		cancelButtonText: 'Cancelar'
	}).then((result) => {
		if(result.value){
			fetch(action,config)
			.then(respuesta => respuesta.json())
			.then(respuesta => {
				return alertas_ajax(respuesta);
			});
		}
	});

}

formularios_ajax.forEach(formularios => {
	formularios.addEventListener("submit", enviar_formulario_ajax);
});

function alertas_ajax(alerta){
	if(alerta.Alerta==="simple"){
		Swal.fire({
			title: alerta.Titulo,
			text: alerta.Texto,
			type: alerta.Tipo,
			confirmButtonText: 'Aceptar'
		});
	}else if(alerta.Alerta==="recargar"){
		Swal.fire({
			title: alerta.Titulo,
			text: alerta.Texto,
			type: alerta.Tipo,
			confirmButtonText: 'Aceptar'
		}).then((result) => {
			if(result.value){
				location.reload();
			}
		});
	}else if(alerta.Alerta==="limpiar"){
		Swal.fire({
			title: alerta.Titulo,
			text: alerta.Texto,
			type: alerta.Tipo,
			confirmButtonText: 'Aceptar'
		}).then((result) => {
			if(result.value){
				document.querySelector(".FormularioAjax").reset();
			}
		});
	}else if(alerta.Alerta==="redireccionar"){
		window.location.href=alerta.URL;
	}
}