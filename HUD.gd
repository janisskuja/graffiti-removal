extends Control

func _process(delta):
	$HBoxContainer2/Time.text = String(Global.time_remaining)
	$HBoxContainer/Graffiti.text = String(Global.graffiti_remaining)
