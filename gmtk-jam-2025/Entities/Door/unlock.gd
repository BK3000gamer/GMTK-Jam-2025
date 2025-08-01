extends Area3D

static var colliding : bool

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		colliding = true

func _on_body_exited(body: Node3D) -> void:
	if body is CharacterBody3D:
		colliding = false
