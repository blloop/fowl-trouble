extends Node2D

var tween : Tween

func open_sign():
	tween = get_tree().create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.4)

func close_sign():
	if self.is_inside_tree(): 
		tween = get_tree().create_tween()
		tween.tween_property(self, "scale", Vector2(0, 0), 0.2)
