extends CharacterBody2D


<<<<<<< HEAD
@export var speed = 300.0
@export var  jump_velocity = -400.0
@export var acceleration : float = 15.0
@export var jumps = 1

enum state {IDLE, RUNNING, JUMPUP, JUMPDOWN, HURT}

var anim_state = state.IDLE

@onready var animator = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

=======
const SPEED = 500
@export var speed = 500.0
@export var  jump_velocity = -400.0
@export var acceleration : float = 75.0
@export var jumps = 1
enum state {IDLE, RUNNING, JUMPUP, JUMPDOWN, HURT}
var anim_state = state.IDLE
@onready var animator = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
>>>>>>> f38c8cb8d02cfdb5151e0a26969a4125ef72b916
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


<<<<<<< HEAD
=======
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

>>>>>>> f38c8cb8d02cfdb5151e0a26969a4125ef72b916
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
<<<<<<< HEAD
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
=======
	if Input.is_action_just_pressed("jump") and is_on_floor():
>>>>>>> f38c8cb8d02cfdb5151e0a26969a4125ef72b916
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
<<<<<<< HEAD
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = move_toward(velocity.x,direction * speed,acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration/2)
		

	move_and_slide()
=======
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = move_toward(velocity.x,direction*speed,acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0, acceleration)
		
	update_state()
	update_animation(direction)
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		get_tree().reload_current_scene()
>>>>>>> f38c8cb8d02cfdb5151e0a26969a4125ef72b916
