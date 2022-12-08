extends KinematicBody2D

onready var SM = $StateMachine

var velocity = Vector2.ZERO
var jump_power = Vector2(0, -600)
var direction = 1
var momentum = 0

export var gravity = Vector2(0, 20)

export var move_speed = 30
export var max_move = 500

export var min_boost_down = 1000
export var boost_power = Vector2(0, -1000)

export var maxBoost = 4000

var boostLeft = false
var boostRight = false
var boostUp = false

var boostDirection = Vector2.ZERO

var moving = false
var is_jumping = false
var double_jumped = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite


func _physics_process(_delta):
	if is_on_floor():
		boostLeft = false
		boostRight = false
		boostUp = false
		velocity.x = clamp(velocity.x,-max_move,max_move)
	else:
		velocity.x = clamp(velocity.x, -maxBoost, maxBoost)
		
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = true
		if direction > 0 and $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = false
	
	if is_on_floor():
		set_wall_raycasts(true)
	
	Global.playerPos = position

func is_moving():
	if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), 0.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"):
		direction = -1
		boostDirection = Vector2.LEFT
	elif event.is_action_pressed("right"):
		direction = 1
		boostDirection = Vector2.RIGHT
	elif event.is_action_pressed("up"):
		boostDirection = Vector2.UP
	else:
		boostDirection = Vector2.ZERO

func set_animation(anim):
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func is_on_floor():
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			return true
	return false

func is_on_right_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func is_on_left_wall():
	if $Wall/Right.is_colliding():
		return true
	return false

func get_right_collider():
	return $Wall/Right.get_collider()

func get_left_collider():
	return $Wall/Left.get_collider()
	
func set_wall_raycasts(is_enabled):
	$Wall/Left.enabled = is_enabled
	$Wall/Right.enabled = is_enabled

func die():
	queue_free()
