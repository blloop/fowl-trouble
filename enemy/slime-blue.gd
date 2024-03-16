extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var SPEED = 18
var player

func _process(delta):
	velocity.y += gravity * delta
	
	if chase:
		$AnimatedSprite2D.play("Walk")
		player = $"../../Player"
		var diff = player.position.x - self.position.x
		if diff < 15 and diff > -15:
			$AnimatedSprite2D.play("Idle")
			velocity.x = 0
		else:
			var to_right = player.position.x - self.position.x > 0
			velocity.x = SPEED * (1 if to_right else -1)
			$AnimatedSprite2D.flip_h = to_right
	else:
		$AnimatedSprite2D.play("Idle")
		velocity.x = 0
	
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		chase = false

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		var diff = player.position.x - self.position.x
		Game.player_hp -= 1
		body.knock_back(diff)
		$"../../UI/Health".decrease()
