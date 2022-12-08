extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

onready var prev_direction = player.direction
var direction = Vector2.ZERO

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Boost") 
	direction = player.boostDirection

func physics_process(delta):
	if direction.x != sign(player.velocity.x) and direction.y > -1:
		player.velocity.x = 0
		prev_direction = direction.x
		
	if direction.x == 1:
		direction.y = -0.1
		player.boostRight = true
	if direction.x == -1:
		direction.y = -0.1
		player.boostLeft = true
	if direction.y == -1:
		player.boostUp = true
		
	player.velocity.y = 0
	
	player.velocity += (direction.normalized() * player.boost_power.length())
	player.move_and_slide(player.velocity, Vector2.UP)
	SM.set_state("Falling")
