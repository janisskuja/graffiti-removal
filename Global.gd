extends Node

var time_remaining = 0
var graffiti_remaining = 0
var started = false
var new_game = true
var winner = false

func start_level(time, graffiti_count):
	started = true
	new_game = false
	time_remaining = time
	graffiti_remaining = graffiti_count

func _process(delta):
	if started:
		if (time_remaining <= 0):
			_game_over(false)
		elif (graffiti_remaining <= 0):
			_game_over(true)

func _game_over(win):
	winner = win
	started = false
	get_tree().change_scene("res://MainMenu.tscn")
