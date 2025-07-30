extends Area3D

var opened := false
var rotating := false
var target_rotation := 0.0
@onready var parent = get_parent()

func _interact() -> void:
	if rotating:
		return
	
	rotating = true
	var angle = 90 if !opened else -90
	target_rotation = parent.rotation_degrees.y + angle

func _process(delta: float) -> void:
	if rotating:
		var current = parent.rotation_degrees.y
		var new_rotation = move_toward(current, target_rotation, delta * 90)
		parent.rotation_degrees.y = new_rotation
		
		if is_equal_approx(new_rotation, target_rotation):
			parent.rotation_degrees.y = target_rotation
			opened = !opened
			rotating = false
