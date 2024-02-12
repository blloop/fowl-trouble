extends Node2D

var cherry = preload("res://item/cherry.tscn")

func _on_timer_timeout():
	var cherry_temp = cherry.instantiate()
	var rng = RandomNumberGenerator.new()
	cherry_temp.position.x += rng.randi_range(-80, 80)
	add_child(cherry_temp)
