extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -180.0
var hurt = false
var tween : Tween

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimatedSprite2D")

func _ready():
	anim.speed_scale = 1

func _physics_process(delta):
	# Skip if game is paused
	if Game.paused:
		return
	if Game.recap:
		# TODO: Add auto-restart variable + function
		if Input.is_action_just_pressed("ui_restart"):
			get_node("../../World")._on_restart_pressed()
		return
	
	# If no hp remaining, return to menu
	if Game.player_hp <= 0:
		Game.recap = true
		var tween_a = get_tree().create_tween()
		tween_a.tween_property(self, "position", position - Vector2(0, 20), 0.4)
		tween_a.tween_property(self, "modulate:a", 0, 0.4)
		tween_a.tween_callback(call_menu)
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
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider.name == "Crate":
			var diff = self.position.x - collider.position.x
			if diff > 15:
				collider.set_axis_velocity(Vector2(-50, 0))
			elif diff < -15:
				collider.set_axis_velocity(Vector2(50, 0))

func call_menu():
	get_node("../../World")._on_bounds_body_entered(self)

func knock_back(diff):
	if hurt: 
		return
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "modulate", Color.RED, 0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.2)

	hurt = true
	anim.play("Fly")
	self.velocity = Vector2(diff * 10, -120)
	get_node("Timer").start()
	move_and_slide()

func _on_timer_timeout():
	hurt = false
