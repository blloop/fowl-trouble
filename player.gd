extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const SPEED = 280.0
const JUMP_VELOCITY = -185.0
var hurt = false
var tween : Tween

func _ready():
	$AnimatedSprite2D.speed_scale = 1

func _physics_process(delta):
	# Skip if game is paused
	if Game.paused:
		return
	if Game.recap:
		# TODO: Add auto-restart variable + function
		if Input.is_action_just_pressed("ui_restart"):
			$"../../World"._on_restart_pressed()
		return
	
	# If no hp remaining, return to menu
	if Game.player_hp <= 0:
		Game.recap = true
		$AnimatedSprite2D.play("Fly")
		var tween_a = get_tree().create_tween()
		tween_a.tween_property(self, "position", position - Vector2(0, 20), 0.4)
		tween_a.tween_property(self, "modulate:a", 0, 0.4)
		tween_a.tween_callback(call_menu)
		return
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("Fly")
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if hurt:
		velocity.x /= 1.1
	elif direction:
		$AnimatedSprite2D.flip_h = true if direction == 1 else false
		velocity.x = direction * SPEED
		if velocity.y == 0:
			$AnimatedSprite2D.play("Run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			$AnimatedSprite2D.play("Idle")
	
	if velocity.y > 0:
		$AnimatedSprite2D.play("Fly")
		
	move_and_slide()
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if "Crate" in collider.name:
			var diff = self.position.x - collider.position.x
			if diff > 15:
				collider.set_axis_velocity(Vector2(-50, 0))
			elif diff < -15:
				collider.set_axis_velocity(Vector2(50, 0))

func call_menu():
	$"../../World"._on_bounds_body_entered(self)

func knock_back(diff):
	if hurt or Game.player_hp == 0: 
		return
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "modulate", Color.RED, 0.1)
	tween.tween_property(self, "modulate", Color.WHITE, 0.2)

	hurt = true
	$AnimatedSprite2D.play("Fly")
	self.velocity = Vector2(diff * 10, -120)
	$Timer.start()
	move_and_slide()

func _on_timer_timeout():
	hurt = false
