extends KinematicBody2D


var active = false

export var speed = 12


func _physics_process(delta):
	look_at(Global.playerPos)
	var difference = (Global.playerPos - position)
	
	if active:
		position += difference.normalized() * speed

func Active():
	active = true

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		pass
	if body.name != "Bullet":
		queue_free()
