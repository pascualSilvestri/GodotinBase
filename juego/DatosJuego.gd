extends Node

var vidas:int = 3
var moneda_oro:int = 0
var nivel_actual:String = ''
var num_nivel_actual:int = 0
var proximo_nivel:String = ""
var puntaje:int = 0


func reset()->void:
	vidas = 3
	moneda_oro = 0
	puntaje = 0

func generar_puntaje()->int:
	var valor_oro = moneda_oro *10
	puntaje = valor_oro
	return puntaje

func restar_vidas()->void:
	vidas -= 1
	if vidas == 0:
		Eventos.emit_signal("game_over")
	Eventos.emit_signal("actualizar_hud")


func sumar_monedas():
	moneda_oro+=1
	Eventos.emit_signal("actualizar_hud")
