extends Node3D

@onready var rocks = preload("res://area_3d.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(5000):
		generate()

func generate():
	var instance = rocks.instantiate()
	instance.position.x = randf_range(-600, 600)
	instance.position.z = randf_range(-600, 600)
	add_child(instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
