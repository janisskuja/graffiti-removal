extends Control

func _ready():
	if Global.new_game:
		$Started.set_visible(true)
	elif Global.winner:
		$Win.set_visible(true)
	else:
		$Lose.set_visible(true)

func _on_Button_pressed():
	get_tree().change_scene("res://Main.tscn")
