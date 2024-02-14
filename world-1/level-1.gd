extends Node2D

@onready var pause_menu = $UI/Pause

func _onready():
	pause_menu.hide()

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pause()

func pause():
	if Game.paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	Game.paused = !Game.paused
