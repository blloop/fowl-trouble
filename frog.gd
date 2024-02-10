extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 50
var player
var chase = false

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if get_node("AnimatedSprite2D").animation == "Death":
		return
	
	if chase:
		get_node("AnimatedSprite2D").play("Jump")
		player = get_node("../../Player/Player")
		var to_right = player.position.x - self.position.x > 0
		velocity.x = SPEED * (1 if to_right else -1)
		get_node("AnimatedSprite2D").flip_h = to_right
	else:
		get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
	
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_player_death_body_entered(body):
	if body.name == "Player":
		get_node("CollisionShape2D").queue_free()
		get_node("AnimatedSprite2D").play("Death")
		await get_node("AnimatedSprite2D").animation_finished
		self.queue_free()
