extends Node2D

var time_elapsed := 0.0
var format_string = "%02d:%1d%.2f"
# var format_string = "Time: %02d:%02d"

func _ready():
	Game.player_hp = Game.max_hp
	Game.gold = 0
	$Player/Camera2D.limit_right = 2392
	
	$UI/Pause.visible = true
	$UI/Pause.hide()
	$UI/SignLayer.visible = true
	$UI/SignLayer.show()
	
	$Features/Note.play("Idle")
	
func _process(_delta):
	if not Game.recap and Input.is_action_just_pressed("ui_pause"):
		pause()
	if !Game.paused and !Game.recap:
		time_elapsed += _delta

func pause():
	if Game.paused:
		Engine.time_scale = 1
		$UI/Pause.hide()
	else:
		Engine.time_scale = 0
		$UI/Pause.show()
		$UI/Pause/Confirm.visible = false
		$UI/Pause/Options.visible = true
	
	Game.paused = !Game.paused
	$UI/Control.update(Game.paused)

func _on_control_pressed():
	pause()

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	Game.recap = false

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://world-1/level-2.tscn")
	Game.player_hp = Game.max_hp
	Game.gold = 0
	Game.recap = false

func _on_bounds_body_entered(body):
	if body.name == "Player":
		Game.recap = true
		body.hide()
		$UI/Control.queue_free()
		$UI/Death/Label1.text = Game.bad_splashes.pick_random()
		$UI/Death.open_sign()
	elif body.name != "TileMap":
		body.queue_free()

func _on_flag_body_entered(body):
	if body.name == "Player":
		body.get_node("AnimatedSprite2D").stop()
		$UI/Control.queue_free()
		$UI/Recap/Label2.text = format_string % [time_elapsed / 60, fmod(time_elapsed, 60) / 10, fmod(time_elapsed, 10)]
		#$UI/Recap/Label2.text = format_string % [time_elapsed / 60, int(floor(time_elapsed)) % 60]
		if time_elapsed >= 6000:
			$UI/Recap/Label2.text = format_string % [99, 9, 9.99]
		$UI/Recap.open_sign()
		Game.recap = true
		Game.w1_unlocked[1] = 1

func _on_sign_body_entered(body):
	if body.name == "Player":
		$UI/SignLayer.open_sign()
		$Features/Note.visible = false

func _on_sign_body_exited(body):
	if body.name == "Player":
		$UI/SignLayer.close_sign()
