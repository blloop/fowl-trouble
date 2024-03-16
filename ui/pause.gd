extends Control

func _ready():
	self.hide()
	$Confirm.visible = false

func _on_resume_pressed():
	self.hide()
	$"../Control".button_pressed = false
	Engine.time_scale = 1
	Game.paused = false

func _on_quit_pressed():
	$Confirm.visible = true
	$Options.visible = false

func _on_yes_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	Engine.time_scale = 1
	Game.paused = false	

func _on_no_pressed():
	$Confirm.visible = false
	$Options.visible = true
