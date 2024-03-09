extends Node2D

@onready var start = $Start
@onready var worlds = $Worlds
@onready var world_1 = get_node("World 1")
@onready var back = $Back

func _ready():
	# Utils.save_game()
	# Utils.load_game()
	start.visible = !Game.visited
	worlds.visible = Game.visited
	world_1.visible = false
	back.visible = false
	
	# Mute locked worlds
	get_node("Worlds/Buttons/Button2").disabled = true
	get_node("Worlds/Buttons/Button3").disabled = true
	get_node("Worlds/Buttons/Button4").disabled = true
	get_node("Worlds/Buttons/Button5").disabled = true
	get_node("Worlds/Buttons/Button6").disabled = true
	#get_node("Worlds/Buttons/Button2").set("theme_override_colors/font_color", Color(0, 0, 0, 0.5))
	
func _on_quit_pressed():
	get_tree().quit()

func _on_play_pressed():
	worlds.visible = true
	start.visible = false
	Game.visited = true

func _on_return_pressed():
	start.visible = true
	worlds.visible = false

func _on_back_pressed():
	worlds.visible = true
	world_1.visible = false
	back.visible = false

# World Buttons

func _on_button_1_pressed():
	world_1.visible = true
	worlds.visible = false
	back.visible = true

# Level Buttons

func _on_level_1_pressed():
	get_tree().change_scene_to_file("res://world-1/level-1.tscn")
	Game.player_hp = 10
	Game.gold = 0

func _on_level_2_pressed():
	get_tree().change_scene_to_file("res://world-1/level-2.tscn")
	Game.player_hp = 10
	Game.gold = 0
