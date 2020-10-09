extends KinematicBody2D

# character walking code stolen from here: https://kidscancode.org/godot_recipes/2d/platform_character/
# animation state machine stolen from here: https://www.youtube.com/watch?v=CPDlaKWnQPM

export (int) var speed = 1200
export (int) var jump_speed = -1800
export (int) var gravity = 4000
export (float, 0, 1.0) var friction = 0.1
export (float, 0, 1.0) var acceleration = 0.25

var velocity = Vector2.ZERO

var playback = AnimationNodeStateMachinePlayback
var jumping = false

signal shoot(gun_position)

func _ready():
	playback = $AnimationTree.get("parameters/playback")
	playback.start("idle")
	$AnimationTree.set_active(true)

func get_input():
	var dir = 0
	if Input.is_action_pressed("right"):
		dir += 1
		if !jumping && playback.is_playing():
			playback.travel("walk_right")
	if Input.is_action_pressed("left"):
		if !jumping && playback.is_playing():
			playback.travel("walk_left")
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
		if !jumping && playback.is_playing():
			playback.travel("idle")
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		jumping = true
		$JumpSound.play()
		if playback.is_playing():
			playback.travel("jump")
		velocity.y = jump_speed
	
	if Input.is_action_pressed("shoot"):
		emit_signal("shoot", $Sprite/GunPosition.global_position)
		if !$ShootSound.is_playing():
			$ShootSound.play()
	if Input.is_action_just_released("shoot"):
		$ShootSound.stop()
	
func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if jumping && is_on_floor():
		jumping = false
