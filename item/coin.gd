extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("AnimatedSprite2D").play("Idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	if body.name == "Player" and get_node("AnimatedSprite2D").get_animation() == "Idle":
		# TODO: Add temporary value as level instance
		Game.gold += 1
		get_node("AnimatedSprite2D").play("Collect")
		await get_node("AnimatedSprite2D").animation_finished
		queue_free()
