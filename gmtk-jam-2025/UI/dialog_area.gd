extends Area3D

@export var dialog_key = ""
@export var dialog_lines: int
var dialog_played := false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		_play_dialog()

func _on_body_entered(body: Node3D) -> void:
	_play_dialog()

func _play_dialog() -> void:
	if dialog_lines > 0:
		SignalBus.emit_signal("display_dialog", dialog_key)
		dialog_lines -= 1
