extends Node



func _on_Button_pressed() -> void:
	if $NombreJSON.text != "":
		var guardar :GuardarCargar = GuardarCargar.new()
		var resultado:int = guardar.guardar_datos_json(
			{
				"nombre":$NombreJSON.text
			}
		)
		$Label2.text = "%s" % resultado
	else:
		$Label2.text = "El campo no puede estar vacio"


func _on_Button2_pressed() -> void:
	var cargar: GuardarCargar = GuardarCargar.new()
	var datos: Dictionary = cargar.cargar_datos_json()
	
	if not datos.empty():
		$NombreJSON.text = datos.nombre
		$Label2.text = "Carga Exitosa"
	else:
		$Label2.text = "Error en la carga"


func _on_Button3_pressed() -> void:
	if $NombreTRES.text != "":
		var guardar:GuardarCargar = GuardarCargar.new()
		var resultado: int = guardar.guardar_datos_tres(
			{
				"nombre":$NombreTRES.text
			}
		)
		$Label3.text = "%s" % resultado
	else:
		$Label3.text = "El campo no puede estar vacio"


func _on_Button4_pressed() -> void:
	var cargar : GuardarCargar = GuardarCargar.new()
	var datos : Dictionary = cargar.cargar_datos_tres()
	
	if not datos.empty():
		$NombreTRES.text = datos.nombre
		$Label3.text = "Carga exitosa"
	else:
		$Label3.text = "Error en la carga"




func _on_Button5_pressed() -> void:
	var borrar :GuardarCargar = GuardarCargar.new()
	var resultado : int = borrar.borrar_datos()
	$Label3.text = "%s" % resultado
