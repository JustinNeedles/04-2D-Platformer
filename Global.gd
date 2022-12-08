extends Node

var playerPos = Vector2.ZERO

func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
