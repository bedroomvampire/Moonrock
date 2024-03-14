extends Area3D

var size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	size = randi() % 3
	scale = Vector3(size,size,size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body):
	if body.name == "Player":
		body.points += size
		queue_free()
