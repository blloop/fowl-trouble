extends Node

var SAVE_PATH = "res://savegame.bin"

func save_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		"gold": Game.gold
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH) == true:
		if not file.eof_reached():
			var current_line = JSON.parse_string(file.get_line())
			if current_line:
				Game.gold = current_line["gold"]

func handle_bounds(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://main.tscn")
	else:
		body.queue_free()
