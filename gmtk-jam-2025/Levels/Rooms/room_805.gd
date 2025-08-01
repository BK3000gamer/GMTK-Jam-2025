extends Node3D

@export var room_803: Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		room_803.global_position = global_position + Vector3(10.0, 0.0, 0.0)
