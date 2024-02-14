extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	self.hide()
	get_node("Confirm").visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _on_resume_pressed():
	self.hide()
	Engine.time_scale = 1
	Game.paused = false

func _on_quit_pressed():
	get_node("Confirm").visible = true
	get_node("Options").visible = false

func _on_yes_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	Engine.time_scale = 1
	Game.paused = false	

func _on_no_pressed():
	get_node("Confirm").visible = false
	get_node("Options").visible = true
