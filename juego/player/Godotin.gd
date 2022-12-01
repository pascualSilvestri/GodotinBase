class_name Godotin
extends KinematicBody


const direccion_arriba:Vector3 = Vector3.UP

enum {SUELO,AIRE}

export var velocidad_max:Vector2 = Vector2(10.0,60.0)
export var gravedad: float = 0.5
export var impulso: float = 50.0
export var fuerza_salto: float = 18.0

var movimiento : Vector3 = Vector3.ZERO
var vector_snap:Vector3 = Vector3.DOWN
var salto_interrumpudi = false
var saltando = false
var cayendo = false
var disparando = false


onready var brazo_camara:SpringArm = $BrazoCamara
onready var armadura:Spatial = $Armature
onready var arbol_animaciones:ArbolAnimaciones = $ArbolAnimaciones
onready var linterna:SpotLight = $Linterna

func _process(delta: float) -> void:
	brazo_camara.translation = translation

func _physics_process(delta: float) -> void:
	movimiento_horizontal()
	movimiento_vertical()
	movimiento = move_and_slide_with_snap(movimiento,vector_snap,direccion_arriba,true)
	
	var direccion_vista_player = Vector2(movimiento.z,movimiento.x)
	if direccion_vista_player.length() > 0:
		armadura.rotation.y = direccion_vista_player.angle()
	
	if disparando:
		linterna.rotation.y = armadura.rotation.y - 3.14159


func respawn()->void:
	DatosJuego.restar_vidas()
	get_tree().reload_current_scene()

func movimiento_vertical()->void:
	
	if not is_on_floor():
		movimiento.y -= gravedad
		movimiento.y = clamp(movimiento.y,-velocidad_max.y,impulso)
		if Input.is_action_just_released("saltar"):
			salto_interrumpudi = true
	else:
		saltando = false
	
	var tocando_suelo:bool = is_on_floor() and vector_snap == Vector3.ZERO
	var inicio_salto: bool = is_on_floor() and Input.is_action_just_pressed("saltar")
	
	if inicio_salto:
		arbol_animaciones.set_transicion_suelo_aire(AIRE)
		arbol_animaciones.set_mezcla_saltar_caer(0)
		vector_snap = Vector3.ZERO
		saltando = true
		salto_interrumpudi = false
		cayendo = false
	elif tocando_suelo:
		arbol_animaciones.set_transicion_suelo_aire(SUELO)
		vector_snap = Vector3.DOWN
	
	if movimiento.y >= velocidad_max.y:
		salto_interrumpudi = true
	
	if Input.is_action_pressed("saltar") and saltando and not salto_interrumpudi:
		movimiento.y += fuerza_salto
	
	if movimiento.y <= 0 and not cayendo:
		cayendo = true
		for i in range(1,11,1):
			arbol_animaciones.set_mezcla_saltar_caer(i*0.1)
	
func movimiento_horizontal()->void:
	movimiento.x = tomar_direccion().x * velocidad_max.x
	movimiento.z = tomar_direccion().z * velocidad_max.x

func tomar_direccion()->Vector3:
	var direccion : Vector3 = Vector3.ZERO
	direccion.x = Input.get_action_strength("mov_derecha") - Input.get_action_strength("mov_izquierda")
	direccion.z = Input.get_action_strength("mov_atras") - Input.get_action_strength("mov_frente")
	arbol_animaciones.set_valor_mezcla_idle_caminar(direccion.length())
	direccion = direccion.rotated(Vector3.UP,brazo_camara.rotation.y).normalized()
	
	return direccion


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("disparar"):
		arbol_animaciones.set_mezcla_disparar(1)
		disparando = true
		linterna.light_energy = 15 
	elif event.is_action_released("disparar"):
		arbol_animaciones.set_mezcla_disparar(0)
		disparando = false
		linterna.light_energy = 0








