extends Node2D

@onready var pause_menu = $UI/Pause
@onready var sign_layer = $UI/SignLayer
@onready var sign_layer_2 = $UI/SignLayer2

func _ready():
	pause_menu.visible = true
	pause_menu.hide()
	sign_layer.visible = true
	sign_layer.show()
	sign_layer_2.visible = true
	sign_layer_2.show()
	get_node("Controls/Control1").play("Idle")
	get_node("Controls/Control2").play("Idle")
	get_node("Controls/Control3").play("Idle")

func _process(_delta):
	if Input.is_action_just_pressed("ui_pause"):
		pause()

func pause():
	if Game.paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0		
		get_node("UI/Pause/Confirm").visible = false
		get_node("UI/Pause/Options").visible = true
	
	Game.paused = !Game.paused
	get_node("UI/Control").update(Game.paused)

func _on_bounds_body_entered(body):
	Utils.handle_bounds(body)

func _on_sign_body_entered(body):
	if body.name == "Player":
		sign_layer.open_sign()

func _on_sign_body_exited(body):
	if body.name == "Player":
		sign_layer.close_sign()

func _on_sign_2_body_entered(body):
	if body.name == "Player":
		sign_layer_2.open_sign()

func _on_sign_2_body_exited(body):
	if body.name == "Player":
		sign_layer_2.close_sign()

func _on_control_pressed():
	pause()
