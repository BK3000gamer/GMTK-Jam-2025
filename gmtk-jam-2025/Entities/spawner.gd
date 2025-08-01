extends Node3D

var hallway_path = preload("res://Levels/hallway.tscn")
var hallway

func _instantiate() -> void:
	hallway = hallway_path.instantiate()
	get_parent().add_child(hallway)
	hallway.global_position = global_position
