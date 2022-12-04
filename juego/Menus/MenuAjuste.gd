tool
extends Control


export(String,FILE,"*.tscn") var menu_inicial=""

onready var boton_pantalla_completa: CheckBox = $ContenedorTabulador/AudioVideo/PanelPrincipal/ContenedorPrincipal/PantallaCompleta
onready var opciones_resolucion = $ContenedorTabulador/AudioVideo/PanelPrincipal/ContenedorPrincipal/Resolucion/OptionResolucion
onready var resoluciones:Dictionary = {
	"640 X 480":Vector2(640,480),
	"960 X 640":Vector2(960,640),
	"1280 X 720":Vector2(1280,720),
	"1366 x 768":Vector2(1366,768),
	"1600 x 900":Vector2(1600,900),
	"1920 x 1080":Vector2(1920,1080)
}

onready var bus_indice := {
	"Master":AudioServer.get_bus_index("Master"),
	"Musica":AudioServer.get_bus_index("Musica"),
	"SFX":AudioServer.get_bus_index("SFX")
}

onready var bus_etiquetas := {
	"Master":$ContenedorTabulador/AudioVideo/PanelPrincipal/ContenedorPrincipal/VolumenGeneral/NivelVolumen,
	"Musica":$ContenedorTabulador/AudioVideo/PanelPrincipal/ContenedorPrincipal/VolumenMusica/NivelVolumen,
	"SFX":$ContenedorTabulador/AudioVideo/PanelPrincipal/ContenedorPrincipal/VolumenSFX/NivelVolumen
}


func _ready() -> void:
	boton_pantalla_completa.set_pressed(OS.window_fullscreen)
	cargar_resolucion()
	chequear_resolucion_actual()
	cargar_volumen_buses()

func cargar_resolucion()->void:
	for resolucion in resoluciones.keys():
		opciones_resolucion.add_item(resolucion)

func chequear_resolucion_actual()->void:
	var texto_resolucion_actual = String(OS.window_size.x) + "x"+ String(OS.window_size.y)
	var indice_resolucion_seleccionado:int = 0
	
	for i in range(opciones_resolucion.get_item_count()):
		if texto_resolucion_actual == opciones_resolucion.get_item_text(i):
			opciones_resolucion.select(i)
			indice_resolucion_seleccionado = i

func cargar_volumen_buses()->void:
	for bus in bus_indice.values():
		var volumen_actual:float = AudioServer.get_bus_volume_db(bus)
		var nombre_bus:String = AudioServer.get_bus_name(bus)
		var texto_volumen:String = "%01d" % (volumen_actual+50)
		bus_etiquetas[nombre_bus].text = texto_volumen
		

func _on_Button_pressed() -> void:
	var guardar:GuardarCargar = GuardarCargar.new()
	guardar.guardar_datos_configuracion()
	get_tree().change_scene(menu_inicial)


func _on_PantallaCompleta_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = button_pressed


func _on_OptionResolucion_item_selected(index: int) -> void:
	var nueva_resolucion:Vector2 = resoluciones[opciones_resolucion.get_item_text(index)]
	OS.window_size = nueva_resolucion
	centrar_pantalla(OS.window_size)

func centrar_pantalla(resolucion:Vector2)->void:
	var tamanio_pantalla := OS.get_screen_size()
	OS.set_window_position((tamanio_pantalla - resolucion) * 0.5)

func cambiar_volumen(indice_bus:int,subir:bool):
	var volumen_anterior:float  = AudioServer.get_bus_volume_db(indice_bus)
	var nuevo_volumen:float 
	
	if subir:
		nuevo_volumen = volumen_anterior + 1
	else:
		nuevo_volumen = volumen_anterior - 1
	
	nuevo_volumen = clamp(nuevo_volumen, -50,150)
	AudioServer.set_bus_volume_db(indice_bus,nuevo_volumen)
	cargar_volumen_buses()



func _on_SubirVolumen_general_pressed() -> void:
	cambiar_volumen(bus_indice.Master,true)


func _on_Bajarvolumen_general_pressed() -> void:
	cambiar_volumen(bus_indice.Master,false)


func _on_SubirVolumen_musica_pressed() -> void:
	cambiar_volumen(bus_indice.Musica,true)


func _on_Bajarvolumen_musica_pressed() -> void:
	cambiar_volumen(bus_indice.Musica,false)


func _on_SubirVolumen_sfx_pressed() -> void:
	cambiar_volumen(bus_indice.SFX,true)


func _on_Bajarvolumen_sfx_pressed() -> void:
	cambiar_volumen(bus_indice.SFX,false)
