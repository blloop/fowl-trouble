extends Node2D

func _ready():
	# Utils.save_game()
	# Utils.load_game()
	$AudioStreamPlayer.play()
	
	# Display last opened menu
	$World1.visible = false
	# ... repeat for other worlds
	if Game.menu_num < 1:
		$Start.visible = true if Game.menu_num == -1 else false
		$Worlds.visible = false if Game.menu_num == -1 else true
		$Back.visible = false
	else:
		$Start.visible = false
		$Worlds.visible = false
		$Back.visible = true
		get_node("World%d" % Game.menu_num).visible = true
	
	# Enable completed levels
	if Game.w1_unlocked[0]:
		$World1/Level2.disabled = false
	if Game.w1_unlocked[1]:
		$World1/Level3.disabled = false
	if Game.w1_unlocked[2]:
		$World1/Level4.disabled = false
	
	# Mute locked worlds
	#$Worlds/Buttons/Button2.disabled = true
	#$Worlds/Buttons/Button2.set("theme_override_colors/font_color", Color(0, 0, 0, 0.5))
	
func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	$Start.visible = false
	$Worlds.visible = true
	Game.menu_num = 0

func _on_return_pressed():
	$Start.visible = true
	$Worlds.visible = false
	Game.menu_num = -1

func _on_back_pressed():
	$Worlds.visible = true
	$World1.visible = false
	$Back.visible = false
	Game.menu_num = 0

func prep_world(num):
	$Worlds.visible = false
	$Back.visible = true
	Game.menu_num = num

func prep_level(time, path):
	Game.player_hp = Game.max_hp
	Game.gold = 0
	Game.gem = 0
	Game.time_goal = time
	Game.this_scene = path
	get_tree().change_scene_to_file(path)

# World Buttons

func _on_button_1_pressed():
	prep_world(1)
	$World1.visible = true

# Level Buttons

func _on_level_1_pressed():
	prep_level(40, "res://world-1/level-1.tscn")

func _on_level_2_pressed():
	prep_level(45, "res://world-1/level-2.tscn")

func _on_level_3_pressed():
	prep_level(55, "res://world-1/level-3.tscn")

func _on_level_4_pressed():
	prep_level(50, "res://world-1/level-4.tscn")
