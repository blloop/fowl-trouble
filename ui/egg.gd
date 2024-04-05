extends AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate.a8 = 100
	self.modulate.v = 0.5

func grow():
	self.modulate.a8 = 255
	self.modulate.v = 1
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(5, 5), 0.1)
	tween.tween_property(self, "scale", Vector2(3, 3), 0.4)
	self.play("Idle")
