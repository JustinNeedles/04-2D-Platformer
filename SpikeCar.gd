extends KinematicBody2D

var velocity = -2000

export var maxSpeed = 2000
export var acc = 400
export var correctionAcc = 2000

var active = false

func _physics_process(delta):
	var difference = Global.playerPos - position
	
	if difference.x != 0:
		if sign(velocity) != sign(difference.x):
			velocity += correctionAcc * delta * sign(difference.x)
		else:
			velocity += acc * delta * sign(difference.x)
		
	velocity = clamp(velocity, -maxSpeed, maxSpeed)
	
	if is_on_wall():
		velocity = -sign(velocity) 
	
	if active:
		move_and_slide(Vector2(velocity, 0), Vector2.UP)

func Active():
	active = true

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print(true)
		queue_free()
