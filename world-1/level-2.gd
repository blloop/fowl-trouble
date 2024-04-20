extends Node2D

var to_unlock = 1
var time_elapsed := 0.0
var format_string = "...in %02d:%1d%.2f"
# var format_string = "Time: %02d:%02d"

func _ready():
	$UI/Recap/Time.text = "<%2.2f" % Game.time_goal
	$AudioStreamPlayer.play()
	$Player/Camera2D.limit_right = 2392
	
	$UI/Pause.visible = true
	$UI/Pause.hide()
	
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
		$AudioStreamPlayer.play()
	else:
		Engine.time_scale = 0
		$UI/Pause.show()
		$UI/Pause/Confirm.visible = false
		$UI/Pause/Options.visible = true
		$AudioStreamPlayer.stop()
	
	Game.paused = !Game.paused
	$UI/Control.update(Game.paused)

func _on_control_pressed():
	pause()

func _on_exit_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
	Game.recap = false

func _on_restart_pressed():
	get_tree().change_scene_to_file(Game.this_scene)
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
		$UI/Recap/Label2.text = format_string % [time_elapsed / 60, floor(time_elapsed) / 10, fmod(time_elapsed, 10)]
		#$UI/Recap/Label2.text = format_string % [time_elapsed / 60, int(floor(time_elapsed)) % 60]
		
		Game.recap = true
		Game.w1_unlocked[to_unlock] = 1
		for mob in $Mobs.get_children():
			mob._stop()
		
		# Configure recap screen
		$UI/Recap.open_sign()
		$UI/Recap/Gems.text = "%d/1" % Game.gem
		$UI/Recap/Coins.text = "%d/20" % Game.gold
		if time_elapsed < Game.time_goal:
			await get_tree().create_timer(0.8).timeout
			$UI/Recap/Egg1.grow()
		if Game.gem == 1:
			await get_tree().create_timer(0.8).timeout
			$UI/Recap/Egg2.grow()
		if Game.gold > 19:
			await get_tree().create_timer(0.8).timeout
			$UI/Recap/Egg3.grow()
		await get_tree().create_timer(0.8).timeout
		$UI/Recap/Exit.fade_in()

func _on_sign_body_entered(body):
	if body.name == "Player":
		$UI/SignLayer.open_sign()
		$Features/Note.visible = false

func _on_sign_body_exited(body):
	if body.name == "Player":
		$UI/SignLayer.close_sign()
