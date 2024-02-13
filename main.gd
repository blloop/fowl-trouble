extends Node2D

func _ready():
	Utils.save_game()
	Utils.load_game()

func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	get_node("Start").visible = false
	get_node("Select").visible = true

func _on_return_pressed():
	get_node("Start").visible = true
	get_node("Select").visible = false

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://world-1/level-1.tscn")
	Game.player_hp = 10

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://world-1/level-2.tscn")
	Game.player_hp = 10
