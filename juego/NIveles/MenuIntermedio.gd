extends Control


onready var titulo = $Titulo
onready var puntos = $Puntos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	titulo.text = "Nivel {num} Completo".format({"num":DatosJuego.num_nivel_actual})
	puntos.text = "{puntos} \nPuntos Totales".format({"puntos":DatosJuego.generar_puntaje()})
	


func _on_Button_pressed() -> void:
	get_tree().change_scene(DatosJuego.proximo_nivel)
