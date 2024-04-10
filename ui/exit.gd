extends Button

func fade_in():
	self.disabled = false
	var tween_a = get_tree().create_tween()
	tween_a.tween_property(self, "modulate:a", 1, 0.5)
