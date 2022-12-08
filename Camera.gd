extends Camera2D

func _process(_delta):
	var player = null
	if get_parent().get_child(0).get_children().count(0) > 0: 
		player = get_parent().get_child(0).get_child(0)
	if player != null:
		position = player.position

func _on_Area2D_body_entered(body):
	if body.has_method("Active"):
		body.Active()
