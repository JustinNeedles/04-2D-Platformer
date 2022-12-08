extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

onready var prev_direction = player.direction

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Moving")
	
func physics_process(delta):
	if not player.is_on_floor():
		SM.set_state("Falling")
	else:
		player.velocity.y = 0
	if Input.is_action_just_pressed("up"):
		SM.set_state("Jumping")
	if player.is_moving():
		if player.direction != prev_direction:
			player.velocity.x = 0
			prev_direction = player.direction
		player.velocity += player.move_speed * player.move_vector() + player.gravity
		player.move_and_slide(player.velocity, Vector2.UP)
	else:
		player.velocity = Vector2.ZERO
		SM.set_state("Idle")
