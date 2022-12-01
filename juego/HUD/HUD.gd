extends Control

onready var vidas = $contenedorVidas/cantidad
onready var eti_monedas_dorada = $contenedorMonedasOro/cantidad


func _ready():
	Eventos.connect("actualizar_hud",self,"actualizar_hud")
	actualizar_hud()


func actualizar_hud():
	vidas.text = "%s" % DatosJuego.vidas
	eti_monedas_dorada.text = "%s" % DatosJuego.moneda_oro
