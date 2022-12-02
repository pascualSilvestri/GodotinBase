tool
extends Button


export var accion:String

func _get_configuration_warning() -> String:
	if accion == "":
		return "no hay accion asignada"
	return ""
