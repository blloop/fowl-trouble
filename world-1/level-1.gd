extends Node2D

var time_elapsed := 0.0
var format_string = "Time: %02d:%1d%.2f"

@onready var pause_menu = $UI/Pause
@onready var control = $UI/Control
@onready var recap = $UI/Recap
@onready var death = $UI/Death
@onready var sign_layer = $UI/SignLayer
@onready var sign_layer_2 = $UI/SignLayer2

func _ready():
	pause_menu.visible = true
	pause_menu.hide()
	sign_layer.visible = true
	sign_layer.show()
	sign_layer_2.visible = true
	sign_layer_2.show()
	
	get_node("Player/Camera2D").limit_right = 2024
	get_node("Controls/Control1").play("Idle")
	get_node("Controls/Control2").play("Idle")
	get_node("Controls/Control3").play("Idle")

func _process(_delta):
	if not Game.recap and Input.is_action_just_pressed("ui_pause"):
		pause()
	if !Game.paused and !Game.recap:
		time_elapsed += _delta

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
	control.update(Game.paused)

func _on_control_pressed():
	pause()

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	Game.recap = false

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://world-1/level-1.tscn")
	Game.player_hp = 10
	Game.gold = 0
	Game.recap = false

func _on_bounds_body_entered(body):
	if body.name == "Player":
		Game.recap = true
		body.hide()
		control.queue_free()
		death.get_node("Label1").text = Game.splashes.pick_random()
		death.open_sign()
	elif body.name != "TileMap":
		body.queue_free()

func _on_flag_body_entered(body):
	if body.name == "Player":
		body.get_node("AnimatedSprite2D").stop()
		control.queue_free()
		recap.get_node("Label2").text = format_string % [time_elapsed / 60, floor(time_elapsed) / 10, fmod(time_elapsed, 10)]
		recap.open_sign()
		Game.recap = true

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
