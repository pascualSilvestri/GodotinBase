extends SpringArm

export var velocidad_mov_camara:Vector2 = Vector2(0.10,0.10)
export var rango_rotacion_camara_x:Vector2 = Vector2(-90.0,30.0)
export var rango_rotacion_camara_y:Vector2 = Vector2(0.0,360) 
export var camara_x_invertidad: bool = false
export var camara_y_invertidad: bool = false


var c:=0

func _ready() -> void:
	set_as_toplevel(true)
	velocidad_mov_camara *= chequear_camara_invertidad()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#rotacion en el eje x
		rotation_degrees.x -= event.relative.y * velocidad_mov_camara.y
		rotation_degrees.x = clamp(
			rotation_degrees.x,
			rango_rotacion_camara_x.x,
			rango_rotacion_camara_x.y
		)
		#ROTACION EN EL EJE Y
		rotation_degrees.y -= event.relative.x * velocidad_mov_camara.x
		rotation_degrees.y = wrapf(
			rotation_degrees.y,
			rango_rotacion_camara_y.x,
			rango_rotacion_camara_y.y
		)
		
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func chequear_camara_invertidad()-> Vector2:
	var vector_camara = Vector2(1,1)
	if camara_x_invertidad:
		vector_camara.x = -1
	if camara_y_invertidad:
		vector_camara.y = -1
	return vector_camara
