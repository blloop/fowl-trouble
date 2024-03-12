extends ParallaxBackground

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("ParallaxLayer/Sun").play("Idle")
	get_node("ParallaxLayer3/Water1").play("Idle")
	get_node("ParallaxLayer3/Water2").play("Idle")
	get_node("ParallaxLayer3/Water3").play("Idle")
	get_node("ParallaxLayer3/Water4").play("Idle")
