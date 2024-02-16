extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var SPEED = 25
var player

# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.y += gravity * delta
	
	if chase:
		get_node("AnimatedSprite2D").play("Walk")
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
