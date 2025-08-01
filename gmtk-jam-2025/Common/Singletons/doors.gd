extends Node

var closed := true

func _process(_delta: float) -> void:
	for door in get_tree().get_nodes_in_group("doors"):
		if door.open.opened:
			closed = false
		else:
			closed = true
