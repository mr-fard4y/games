extends RigidBody2D

class_name Player

signal hit_obstacle


const GRAVITY_SCALE = 5.0
const MAX_ROTATION_DEGREES = -30.0
const FLAP_FORCE = -200
const ANGULAR_VELOCITY = -8.0


onready var animation = $AnimationPlayer
onready var hit = $hit
onready var wing = $wing

var is_game_started = false
var is_alive = true


func _physics_process(delta):
	if Input.is_action_just_pressed("flap") && is_alive:
		if !is_game_started:
			setup_animation()
		flap_player()

	if rotation_degrees <= MAX_ROTATION_DEGREES:
		angular_velocity = 0
		rotation_degrees = MAX_ROTATION_DEGREES

	if linear_velocity.y > 0:
		angular_velocity = 3.0 if rotation_degrees <= 90 else 0.0

func setup_animation():
	if is_game_started:
		return

	is_game_started = true
	gravity_scale = GRAVITY_SCALE
	animation.play("flap")

func flap_player():
	linear_velocity.y = FLAP_FORCE
	angular_velocity = ANGULAR_VELOCITY
	wing.play()
	

func hit_obstacle():
	if !is_alive:
		return
	is_alive = false
	animation.stop()
	hit.play()
	emit_signal("hit_obstacle")
