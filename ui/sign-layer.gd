extends Node2D

var tween : Tween

func _ready():
	if self.has_meta("sign_image"):
		$Sign.texture = self.get_meta("sign_image")

func open_sign():
	if tween:
		tween.kill()
	if get_tree():
		tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(1, 1), 0.4)

func close_sign():
	if tween:
		tween.kill()
	if get_tree():
		tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(0, 0), 0.2)
