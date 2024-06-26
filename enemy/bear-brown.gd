extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var chase = false
var detected = false
var SPEED = 48
var player

func _process(delta):
	velocity.y += gravity * delta
	
	if chase:
		$AnimatedSprite2D.play("Run")
		player = $"../../Player"
		var diff = player.position.x - self.position.x
		if diff < 18 and diff > -18:
			$AnimatedSprite2D.play("Wait")
			velocity.x = 0
		else:
			var to_left = player.position.x - self.position.x < 0
			velocity.x = SPEED * (-1 if to_left else 1)
			$AnimatedSprite2D.flip_h = to_left
	else:
		$AnimatedSprite2D.play("Idle")
		velocity.x = 0
	
	move_and_slide()

func _stop():
	$PlayerDetection.queue_free()

func _on_player_detection_body_entered(body):
	if body.name == "Player":
		detected = true
		$Timer.start()
		$Exclamation.play("Idle")

func _on_player_detection_body_exited(body):
	if body.name == "Player":
		detected = false
		chase = false

func _on_timer_timeout():
	chase = detected

func _on_player_collision_body_entered(body):
	if body.name == "Player":
		var diff = body.position.x - self.position.x
		body.knock_back(diff)
		Game.player_hp -= 1
		$"../../UI/Health".decrease()
