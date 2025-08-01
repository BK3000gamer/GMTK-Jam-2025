extends Node3D

@onready var spawner_1 = $"../Spawner 1"
@onready var spawner_2 = $"../Spawner 2"
@onready var player = $"../Player"

@onready var room_801 = $"../Room 801"
@onready var room_803 = $"../Room 803"
@onready var room_805 = $"../Room 805"
@onready var room_807 = $"../Room 807"
@onready var room_809 = $"../Room 809"
@onready var room_802 = $"../Room 802"
@onready var room_804 = $"../Room 804"
@onready var room_806 = $"../Room 806"
@onready var room_808 = $"../Room 808"
@onready var room_810 = $"../Room 810"

func _physics_process(_delta: float) -> void:
	if abs(player.global_position.x - global_position.x) > 75:
		queue_free()
	elif abs(player.global_position.x - global_position.x) > 25 and abs(player.global_position.z - global_position.z) > 3:
		queue_free()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		spawner_1.global_position.x = global_position.x + 50
		spawner_1.global_position.z = global_position.z
		spawner_2.global_position.x = global_position.x - 50
		spawner_2.global_position.z = global_position.z
		if (body.global_position.x - global_position.x) > 22:
			spawner_2._instantiate()
		elif (body.global_position.x - global_position.x) < -22:
			spawner_1._instantiate()
		else:
			spawner_1._instantiate()
			spawner_2._instantiate()
	
	if body is CharacterBody3D and Doors.closed:
		room_801.global_position = global_position + Vector3(20.0, 0, -7.5)
		room_803.global_position = global_position + Vector3(10.0, 0, -7.5)
		room_805.global_position = global_position + Vector3(0.0, 0, -7.5)
		room_807.global_position = global_position + Vector3(-10.0, 0, -7.5)
		room_809.global_position = global_position + Vector3(-20.0, 0, -7.5)
		room_802.global_position = global_position + Vector3(20.0, 0, 7.5)
		room_804.global_position = global_position + Vector3(10.0, 0, 7.5)
		room_806.global_position = global_position + Vector3(0.0, 0, 7.5)
		room_808.global_position = global_position + Vector3(-10.0, 0, 7.5)
		room_810.global_position = global_position + Vector3(-20.0, 0, 7.5)


func _on_area_3d_body_exited(_body: Node3D) -> void:
	if abs(player.global_position.z - global_position.z) > 12:
		queue_free()
