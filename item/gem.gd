extends Area2D

func _ready():
	$AnimatedSprite2D.play("Idle")

func _on_body_entered(body):
	if body.name == "Player" and $AnimatedSprite2D.get_animation() == "Idle":
		#Game.gold += 1
		#$AnimatedSprite2D.play("Collect")
		#await $AnimatedSprite2D.animation_finished
		Game.gem = 1
		$"../../UI/Gold".show_gem()
		queue_free()
