extends Node2D

var Bubble:PackedScene = null

func _ready():
	$Timer.start()
	Global.start_level($Timer.time_left, $Graffitis.get_child_count())
	Bubble = load("res://Bullet.tscn")
	
func _on_Player_shoot(gun_position):
	var bubble = Bubble.instance()
	bubble.position = gun_position
	$BulletSponge.add_child(bubble)

func _process(delta):
	Global.time_remaining = int($Timer.time_left)
	Global.graffiti_remaining = $Graffitis.get_child_count()
