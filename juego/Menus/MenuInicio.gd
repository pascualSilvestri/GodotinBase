tool
extends Control

export(String,FILE,"*.tscn") var menu_ajuste=""


onready var btn_fsx = $AudioStreamPlayer

func _on_BotonSalir_pressed() -> void:
	get_tree().quit()




func _on_BotonOpciones_pressed() -> void:
	btn_fsx.play()
	get_tree().change_scene(menu_ajuste)

func _get_configuration_warning() -> String:
	if menu_ajuste == "":
		return "chequear rutas"
	return ""
