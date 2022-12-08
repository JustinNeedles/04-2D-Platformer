extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Jumping")

func physics_process(delta):
	player.velocity.y = 0
	player.velocity += player.jump_power
	player.move_and_slide(player.velocity, Vector2.UP)
	SM.set_state("Falling")

