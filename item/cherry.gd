extends Area2D

func _ready():
	get_node("AnimatedSprite2D").play("Idle")

func _on_body_entered(body):
	if body.name == "Player":
		Game.gold += 5
		var tween_a = get_tree().create_tween()
		var tween_b = get_tree().create_tween()
		tween_a.tween_property(self, "position", position - Vector2(0, 30), 0.3)
		tween_b.tween_property(self, "modulate:a", 0, 0.3)
		tween_a.tween_callback(queue_free)
