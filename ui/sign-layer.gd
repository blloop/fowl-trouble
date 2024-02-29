extends Node2D

var tween : Tween

func open_sign():
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.5)

func close_sign():
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(0, 0), 0.5)
