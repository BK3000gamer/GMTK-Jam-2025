extends Node3D

@export var room_903: Node3D

@onready var player = $"../Player"
var collided := false

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		room_903.global_position = global_position + Vector3(0.0, 0.0, -10.0)
		collided = true

func _physics_process(delta: float) -> void:
	if collided:
		player.SPEED = 3.5
		player.scale.x = move_toward(player.scale.x, 0.2, delta)
		player.scale.y = move_toward(player.scale.y, 0.2, delta)
		player.scale.z = move_toward(player.scale.z, 0.2, delta)
