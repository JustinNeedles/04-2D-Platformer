extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

var momentum = 0

var timeout = false

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("HoldMomentum")
	player.velocity = Vector2.ZERO
	$Timer.wait_time = 1
	$Timer.start()
	timeout = false
	momentum = player.momentum

func physics_process(delta):
	if not timeout:
		if player.move_vector().length() != 0:
			player.velocity += (player.move_vector() + Vector2.UP * 0.3).normalized() * momentum
			player.move_and_slide(player.velocity, Vector2.UP)
			SM.set_state("Falling")
	else:
		SM.set_state("Idle")
		
	if Input.is_action_just_pressed("up"):
		player.velocity += Vector2.UP * momentum
		player.move_and_slide(player.velocity, Vector2.UP)
		SM.set_state("Falling")

func end():
	$Timer.stop()

func _on_Timer_timeout():
	timeout = true
