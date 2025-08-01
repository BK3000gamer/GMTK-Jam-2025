extends CharacterBody3D

@export var sensitivity: float
@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float

@export var swim_up_speed: float

@onready var raycast = $Camera3D/RayCast3D
@onready var prompt = $InteractPromp/Label

var SPEED = 7.0
var input_dir := Vector2.ZERO

var jump_velocity: float
var jump_gravity: float
var fall_gravity: float
var camera: Camera3D
var mouse_captured:= true

var timer: Timer
var text: String = "Press [LMB] to interact"

func _timeout():
	text = "Press [LMB] to interact"

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	camera = get_tree().current_scene.get_viewport().get_camera_3d()
	
	jump_velocity = (2.0 * jump_height) / jump_time_to_peak
	jump_gravity =  (-2.0 * jump_height) / pow(jump_time_to_peak, 2)
	fall_gravity = (-2.0 * jump_height) / pow(jump_time_to_descent, 2)
	
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 1
	timer.one_shot = true
	timer.timeout.connect(_timeout)

func _get_gravity() -> float:
	return jump_gravity if velocity.y > 0.0 else fall_gravity

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and mouse_captured:
		rotate_y(-event.relative.x * sensitivity * 0.001)
		camera.rotate_x(-event.relative.y * sensitivity * 0.001)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2.2, PI/4)
	
	if event.is_action_pressed("menu"):
		mouse_captured = !mouse_captured
		if mouse_captured:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	input_dir = Input.get_vector("left", "right", "forward", "backward")

func _water_physics(delta) -> bool:
	if get_tree().get_nodes_in_group("water_area").all(func(area): return !area.overlaps_body(self)):
		return false
	
	var direction := (camera.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if Input.is_action_pressed("jump"):
		print("swiming up")
		velocity.y = swim_up_speed
	elif not is_on_floor():
		velocity.y += _get_gravity() * 0.1 * delta
	
	velocity = velocity.lerp(Vector3.ZERO, 2 * delta)
	
	return true

func _physics_process(delta: float) -> void:
	if raycast.is_colliding():
		prompt.text = text
		var collider = raycast.get_collider()
		if Input.is_action_just_pressed("interact"):
			collider._interact()
			timer.start()
			if collider.locked:
				text = "Door locked"
	else:
		prompt.text = ""
	
	if !_water_physics(delta):
		# Add the gravity.
		if not is_on_floor():
			velocity.y += _get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = jump_velocity

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
