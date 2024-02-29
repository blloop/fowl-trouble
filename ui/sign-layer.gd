extends Node2D

var tween : Tween

func _ready():
	tween = create_tween()

func _process(_delta):
	#if tween_a.
	pass

func open_sign():
	tween.tween_property(self, "scale", Vector2(1, 1), 0.5)
	tween.play()

func close_sign():
	tween.tween_property(self, "scale", Vector2(0, 0), 0.5)
	tween.play()
