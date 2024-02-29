extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func open_scale():
	self.scale.x = 1
	self.scale.y = 1

func close_scale():
	self.scale.x = 0
	self.scale.y = 0

func open_sign():
	var tween_a = get_tree().create_tween()
	tween_a.tween_property(self, "scale", Vector2(1, 1), 0.5)
	#tween_a.tween_callback(open_scale)
	tween_a.play()

func close_sign():
	var tween_a = get_tree().create_tween()
	tween_a.tween_property(self, "scale", Vector2(0, 0), 0.5)
	tween_a.play()
	#close_scale()
