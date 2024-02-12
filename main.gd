extends Node2D

func _ready():
	Utils.save_game()
	Utils.load_game()

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	#get_tree().change_scene_to_file("res://world.tscn")
	get_node("Start").visible = false
	get_node("Select").visible = true

func _on_return_pressed():
	get_node("Start").visible = true
	get_node("Select").visible = false
