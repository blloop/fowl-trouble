extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -180.0
var hurt = false
var tween : Tween

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimatedSprite2D")

func _ready():
	anim.speed_scale = 0.5

func _physics_process(delta):
	# Skip if game is paused
	if Game.paused or Game.recap:
		return
	
	# If no hp remaining, return to menu
	if Game.player_hp <= 0:
		get_tree().change_scene_to_file("res://main.tscn")
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("Fly")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if hurt:
		velocity.x /= 1.1
	elif direction:
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

func knock_back(is_left):
	if hurt: 
		return
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "modulate", Color.RED, 0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.2)

	hurt = true
	anim.play("Fly")
	self.velocity = Vector2(-180 if is_left else 180, -120)
	get_node("Timer").start()
	move_and_slide()

func _on_timer_timeout():
	hurt = false
