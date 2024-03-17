extends Node2D


func _ready():
	# Utils.save_game()
	# Utils.load_game()
	$Start.visible = !Game.visited
	$Worlds.visible = Game.visited
	$World1.visible = false
	$Back.visible = false
	
	# Enable completed levels
	if Game.w1_unlocked[1]:
		$World1/Level2.disabled = false
	if Game.w1_unlocked[2]:
		$World1/Level3.disabled = false
	
	# Mute locked worlds
	#$Worlds/Buttons/Button2.disabled = true
	#$Worlds/Buttons/Button2.set("theme_override_colors/font_color", Color(0, 0, 0, 0.5))
	
func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	$Start.visible = false
	$Worlds.visible = true
	Game.visited = true

func _on_return_pressed():
	$Start.visible = true
	$Worlds.visible = false

func _on_back_pressed():
	$Worlds.visible = true
	$World1.visible = false
	$Back.visible = false

# World Buttons

func _on_button_1_pressed():
	$World1.visible = true
	$Worlds.visible = false
	$Back.visible = true

# Level Buttons

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://world-1/level-1.tscn")

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://world-1/level-2.tscn")
	Game.player_hp = Game.max_hp
	Game.gold = 0
