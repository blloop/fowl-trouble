extends CharacterBody2D

const SPEED = 120.0
const JUMP_VELOCITY = -180.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimatedSprite2D")

func _onready():
	anim.speed_scale = 0.5

func _physics_process(delta):
	# Skip if game is paused
	if Game.paused:
		return
	
	# If no hp remaining, return to menu
	if Game.player_hp <= 0:
		get_tree().change_scene_to_file("res://main.tscn")
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Fly")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		get_node("AnimatedSprite2D").flip_h = true if direction == 1 else false
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
	
	if velocity.y > 0:
		anim.play("Fly")
		
	move_and_slide()
