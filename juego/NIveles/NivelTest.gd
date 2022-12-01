extends Node


export var numero_nivel:int = 0
export(String,FILE,"*.tscn") var proximi_nivel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DatosJuego.num_nivel_actual = numero_nivel
	DatosJuego.nivel_actual = get_tree().current_scene.filename
	DatosJuego.proximo_nivel = proximi_nivel
	
func _get_configuration_warning() -> String:
	if numero_nivel == 0 or proximi_nivel =="":
		return "chequea valores de nivel"
	return ""
