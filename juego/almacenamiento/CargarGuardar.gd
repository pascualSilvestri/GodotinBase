class_name GuardarCargar
extends Node


enum {
	JUEGO,CONFIG
}


#func guardar_datos_json(datos_a_guardar:Dictionary)->int:
#	if not OS.get_name() in DatosConfiguracion.OS_ADMITIDOS_GUARDADO:
#		return -1
#	
#	var archivo:File = File.new()
#	
#	var resultado:int = archivo.open(seleccionar_ruta(".json"),File.WRITE)
#	
#		archivo.store_line(to_json(datos_a_guardar))
#		archivo.close()
##	return resultado


#func guardar_datos_tres(datos_a_guardar:Dictionary)->int:
##		return -1
#	
#	var datos : DatosUsuarioGuardado = DatosUsuarioGuardado. new()
#	
#	datos.nombre = datos_a_guardar.nombre
#	
#	var resultado : int = ResourceSaver.save(seleccionar_ruta(".tres"),datos)
#	
#	return resultado



func seleccionar_ruta(archivo:int)->String:
	var ruta : String
	
	if OS.is_debug_build():
		ruta = DatosConfiguracion.RUTA_GUARDADO_DEBUG
	else:
		ruta = DatosConfiguracion.RUTA_GUARDADO_RELEASE
	
	chequear_existencia_directorio(ruta)
	
	match archivo:
		JUEGO:
			ruta += DatosConfiguracion.NOMBRE_ARCHIVO_DATOS
		CONFIG:
			ruta += DatosConfiguracion.NOMBRE_ARCHIVO_CONFIG
		_:
			printerr("No existe ese tipo de archivo")
	
	return ruta




func chequear_existencia_directorio(ruta:String)->void:
	var dir = Directory.new()
	
	if not dir.dir_exists(ruta):
		Directory.new().make_dir_recursive(ruta)


#CargarDatos

#func cargar_datos_json()->Dictionary:
###
#	var archivo:File = File.new()
#	
##	if resultado == OK:
#		var datos_cargados :Dictionary = parse_json(archivo.get_line())
#		archivo.close()
#		
#		return datos_cargados
#	return {}

#func cargar_datos_tres()->Dictionary:
#	var datos :Resource = load(seleccionar_ruta(".tres"))
#	
#	return {
#		"nombre":datos.nombre
#	}

#func borrar_datos()->int:
#	if not OS.get_name() in DatosConfiguracion.OS_ADMITIDOS_GUARDADO:
#		return -1
##	var dir = Directory.new()
##	
#	return resultado

func cargar_datos_configuracion()->void:
	var ruta :String = seleccionar_ruta(CONFIG)
	var dir : Directory = Directory.new()
	
	if not dir.file_exists(ruta):
		guardar_datos_configuracion()
	else:
		var datos:Resource = load(ruta)
		OS.window_fullscreen = datos.pantalla_completa
		OS.window_size = datos.pantalla_resolucion
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),datos.volumen_buses.master)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Musica"),datos.volumen_buses.musica)
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),datos.volumen_buses.sfx)
		var tamanio_pantalla := OS.get_screen_size()
		OS.set_window_position((tamanio_pantalla - datos.pantalla_resolucion) * 0.5)

func guardar_datos_configuracion() ->int:
	if not OS.get_name() in DatosConfiguracion.OS_ADMITIDOS_GUARDADO:
		return -1
	
	var ruta:String = seleccionar_ruta(CONFIG)
	
	var datos:DatosAjustesGuardado = DatosAjustesGuardado.new()
	datos.pantalla_completa = OS.window_fullscreen
	datos.pantalla_resolucion = OS.window_size 
	datos.volumen_buses = {
		"master":AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")),
		"musica":AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Musica")),
		"sfx":AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")),
	}
	var resultado:int = ResourceSaver.save(ruta,datos)
	return resultado


func guardar_datos_juego()->int:
	if not get_name() in DatosConfiguracion.OS_ADMITIDOS_GUARDADO:
		return -1
	
	var ruta:String = seleccionar_ruta(JUEGO)
	
	var datos:DatosUsuarioGuardado = DatosUsuarioGuardado.new()
	
	datos.vidas = DatosJuego.vidas
	datos.monedas_oro = DatosJuego.moneda_oro
	datos.nivel_actual = DatosJuego.nivel_actual
	datos.num_nivel_actual = DatosJuego.num_nivel_actual
	datos.nivel_proximo = DatosJuego.proximo_nivel
	
	var resultado : int = ResourceSaver.save(ruta,datos)
	
	return resultado

func cargar_datos_juego()->void:
	var ruta:String = seleccionar_ruta(JUEGO)
	var datos: Resource = load(ruta)
	
	DatosJuego.vidas =datos.vidas 
	DatosJuego.moneda_oro =datos.monedas_oro 
	DatosJuego.nivel_actual =datos.nivel_actual 
	DatosJuego.num_nivel_actual = datos.num_nivel_actual 
	DatosJuego.proximo_nivel = datos.nivel_proximo 
	
	

