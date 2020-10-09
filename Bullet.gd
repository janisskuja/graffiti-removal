extends RigidBody2D

var force = Vector2.ZERO

func _ready():
	randomize()
	force = Vector2(10 + randi() % 20, 10 + randi() % 20)
	add_force(Vector2.ZERO, force)

func _on_Timer_timeout():
	queue_free()
