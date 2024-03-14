extends Node

var maintenance = 100

func _process(delta):
	maintenance -= .5 * delta
	if maintenance <= 0:
		get_tree().change_scene("res://node_3d.tscn")
