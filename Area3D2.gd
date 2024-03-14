extends Area3D

func _on_body_entered(body):
	if body.name == "Player":
		body.oxygen = 100
		global.maintenance += body.points
		body.points = 0
