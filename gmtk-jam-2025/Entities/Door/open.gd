extends Area3D

@onready var door = $".."
@onready var lock = $"../Lock"
@onready var unlock = $"../Unlock"
@onready var frame = $"../Frame"

var opened := false
var rotating := false
var locked := false
var target_rotation := 0.0
var has_opened_once := false

func _interact() -> void:
	if rotating:
		return
	
	if !locked and !rotating:
		rotating = true
		var angle = 90 if !opened else -90
		opened = !opened
		target_rotation = rotation_degrees.y + angle
		if opened:
			has_opened_once = true

func _process(delta: float) -> void:
	if rotating:
		var current = rotation_degrees.y
		var new_rotation = move_toward(current, target_rotation, delta * 180)
		rotation_degrees.y = new_rotation
		
		if is_equal_approx(new_rotation, target_rotation):
			rotation_degrees.y = target_rotation
			frame.colliding = false
			rotating = false
	
	if lock.colliding and frame.colliding and opened:
		_interact()
	
	if unlock.colliding and frame.colliding and opened:
		_interact()
	
	if !opened:
		if lock.colliding:
			if door.one_way or door.one_time:
				locked = true
		elif unlock.colliding:
			if !door.one_time:
				locked = false
			elif door.one_time and !has_opened_once:
				locked = false
