extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var detected = false
var SPEED = 48
var player

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	
	if chase:
		get_node("AnimatedSprite2D").play("Run")
		player = get_node("../../Player")
		var diff = player.position.x - self.position.x
		if diff < 15 and diff > -20:
			get_node("AnimatedSprite2D").play("Wait")
			velocity.x = 0
		else:
			var to_left = player.position.x - self.position.x < 0
			velocity.x = SPEED * (-1 if to_left else 1)
			get_node("AnimatedSprite2D").flip_h = to_left
	else:
		get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
	
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		detected = true
		get_node("Timer").start()
		get_node("Exclamation").play("Idle")
		

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		detected = false
		chase = false

func _on_timer_timeout():
	chase = detected

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		var diff = player.position.x - self.position.x
		body.knock_back(diff < 0)
		Game.player_hp -= 1
		get_node("../../UI/Health").decrease()
