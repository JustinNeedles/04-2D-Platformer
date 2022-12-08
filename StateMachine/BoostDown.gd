extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

var momentum = 0

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Boost")
	momentum = player.velocity.length()
	player.velocity = Vector2(0, momentum)
	player.momentum = 0

func physics_process(delta):
	player.velocity.y += player.gravity.length() * 6
	player.move_and_slide(player.velocity, Vector2.UP)
	if player.is_on_floor():
		player.momentum = momentum
		player.velocity = Vector2.ZERO
		SM.set_state("HoldMomentum")
