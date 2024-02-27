extends Node2D

@onready var pause_menu = $UI/Pause
@onready var sign_layer = $UI/SignLayer

func _onready():
	pause_menu.visible = true
	pause_menu.hide()
	sign_layer.visible = true
	sign_layer.hide()

func _process(_delta):
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

func _on_bounds_body_entered(body):
	Utils.handle_bounds(body)

func _on_sign_body_entered(body):
	if body.name == "Player":
		sign_layer.show()

func _on_sign_body_exited(body):
	if body.name == "Player":
		sign_layer.hide()
