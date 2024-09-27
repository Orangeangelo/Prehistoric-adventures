extends CharacterBody2D

#This code initializes the characters parameters like speed, jump velocity, acceleration etc.
const SPEED = 500
@export var speed = 500.0
@export var  jump_velocity = -400.0
@export var acceleration : float = 75.0
@export var jumps = 1
enum state {IDLE, RUNNING, JUMPUP, JUMPDOWN, HURT}
var anim_state = state.IDLE
@onready var animator = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#This block of code updates the characters animation state based on their current situation.
func update_state():
	if anim_state == state.HURT:
		return
	if is_on_floor():
		if velocity == Vector2.ZERO:
			anim_state = state.IDLE
		elif velocity.x !=0:
			anim_state = state.RUNNING
	else:
		if velocity.y < 0:
			anim_state = state.JUMPUP
		else:
			anim_state = state.JUMPDOWN

#This block of code updates the characters animation and current state.
func update_animation(direction):
	if direction > 0:
		animator.flip_h = false
	elif direction < 0:
		animator.flip_h = true
	match anim_state:
		state.IDLE:
			animation_player.play("idle")
		state.RUNNING:
			animation_player.play("run")
		state.JUMPUP:
			animation_player.play("jump_up")
		state.JUMPDOWN:
			animation_player.play("jump_down")
		state.HURT:
			animation_player.play("hurt")

#This code manages the players movement and jumping while applying gravity.
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x,direction*speed,acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration)
		
	update_state()
	update_animation(direction)
	move_and_slide()



#This block of code makes the player reset whenever it collides with a spike, causing the scene to reset and the score resets as well.
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		GameManager.reset_score() #This is the code that resets the score
		get_tree().reload_current_scene() #This is the code that reloads the world when the player dies.
