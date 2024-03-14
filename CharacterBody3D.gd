extends CharacterBody3D

@export_category("Movement")
@export var SPEED : float = 3.75
@export var JUMP_VELOCITY : float = 1.25

var points = 0
var oxygen = 100

# Onready variables
@onready var head = $Head
@onready var camera = $Head/Camera

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * 0.004)
		camera.rotate_x(-event.relative.y * 0.004)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-75), deg_to_rad(60))

func _process(delta):
	$Label.text = "maintenance " + str(global.maintenance)
	$Label2.text = "oxygen " + str(oxygen)
	$Label3.text = str(points) + " rocks"
	oxygen -= 1.5 * delta
	if oxygen <= 0:
		get_tree().change_scene("res://node_3d.tscn")
	
	if Input.is_action_just_pressed("ui_cancel"):
		if !OS.has_feature("web"):
			get_tree().quit()
		
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * 2) * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		if is_on_floor():
			velocity.x = lerp(velocity.x, direction.x * SPEED, delta * 15)
			velocity.z = lerp(velocity.z, direction.z * SPEED, delta * 15)
		else:
			velocity.x = lerp(velocity.x, direction.x * SPEED * 1.5, delta)
			velocity.z = lerp(velocity.z, direction.z * SPEED * 1.5, delta)
	else:
		if is_on_floor():
			velocity.x = lerp(velocity.x, 0.0, delta * 10)
			velocity.z = lerp(velocity.z, 0.0, delta * 10)
		else:
			velocity.x = lerp(velocity.x, 0.0, delta / 2)
			velocity.z = lerp(velocity.z, 0.0, delta / 2)

	move_and_slide()
