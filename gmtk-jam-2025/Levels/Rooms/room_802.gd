extends Node3D

@export var room_810: Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		room_810.global_position = global_position + Vector3(10.0, 0.0, 0.0)


func _on_lava_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		body.position = position + Vector3(0.0, 0.5, -4.5)
