extends Area2D


var health_points = 100.0
var random_idx

func _ready():
	randomize()
	random_idx = 1 + randi() % 9
	get_node("Graffiti_" + String(random_idx)).set_visible(true)

func _process(delta):
	var opacity = health_points / 100
	if opacity < 0.1:
		opacity = 0.1
	modulate.a = opacity
	if health_points <= 0:
		queue_free()

func _on_Graffiti_body_entered(body):
	$AnimationPlayer.play("flash")
	health_points -= 1
