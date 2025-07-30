extends Node3D

var spawner_1: Node3D
var spawner_2: Node3D
var player: CharacterBody3D

func _ready() -> void:
	spawner_1 = get_parent().get_node("Spawner 1")
	spawner_2 = get_parent().get_node("Spawner 2")
	player = get_parent().get_node("Player")

func _physics_process(delta: float) -> void:
	if abs(player.global_position.x - global_position.x) > 75:
		queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		spawner_1.global_position.x = global_position.x + 50
		spawner_2.global_position.x = global_position.x - 50
		spawner_1._instantiate()
		spawner_2._instantiate()

func _on_area_3d_body_exited(body: Node3D) -> void:
	queue_free()
