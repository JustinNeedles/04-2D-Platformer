extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Falling")

func physics_process(delta):
	if player.is_on_floor() and player.velocity.y > 0:
		player.velocity.y = 0
		if player.is_moving():
			SM.set_state("Moving")
		else:
			SM.set_state("Idle")
		return
	if Input.is_action_just_pressed("down"):
		SM.set_state("BoostDown")
	elif (Input.is_action_just_pressed("up") and not player.boostUp) or (Input.is_action_just_pressed("right") and not player.boostRight) or (Input.is_action_just_pressed("left") and not player.boostLeft):
		SM.set_state("Boost")
	if player.is_on_ceiling():
		player.velocity.y = 0
	if player.is_on_wall():
		player.velocity.x = 0
	player.velocity += player.gravity
	player.move_and_slide(player.velocity, Vector2.UP)
