extends Node3D

@export var room_804: Node3D
@export var room_807: Node3D

var hallway_path = preload("res://Levels/hallway.tscn")
var hallway
var hallway2

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		hallway = hallway_path.instantiate()
		get_parent().add_child(hallway)
		hallway.global_position = global_position + Vector3(10.0, 0.0, 0.0) - Vector3(10.0, 0, 7.5)
		
		hallway2 = hallway_path.instantiate()
		get_parent().add_child(hallway2)
		hallway2.global_position = global_position + Vector3(-10.0, 0.0, 0.0) - Vector3(-10.0, 0, -7.5)
		
		room_804.global_position = global_position + Vector3(10.0, 0.0, 0.0)
		room_807.global_position = global_position + Vector3(-10.0, 0.0, 0.0)
