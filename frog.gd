extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPEED = 50
var player
var chase = false

func _physics_process(delta):
	velocity.y += gravity * delta
	
	if chase:
		player = get_node("../../Player/Player")
		if player.position.x - self.position.x > 0:
			velocity.x = SPEED
		else:
			velocity.x = -1 * SPEED
	
	move_and_slide()
	
func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false
