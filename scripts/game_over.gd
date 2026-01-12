extends Control

@onready var score_label: Label = $score/score/Label2
@onready var water_label: Label = $umidade/umidade/Label

func _ready() -> void:
	score_label.text = "Score: %d" % Globals.score
	water_label.text = "Umidade: %d" % Globals.water
	get_tree().paused = false

func _on_restart_btn_pressed() -> void:
	if Globals.checkpoint_scene != "":
		Globals.score = Globals.checkpoint_score
		Globals.water = Globals.checkpoint_water
		Globals.player_lifes = Globals.checkpoint_lifes

		get_tree().change_scene_to_file(Globals.checkpoint_scene)
	else:
		get_tree().change_scene_to_file("res://scene/forest.tscn")

func _on_menu_pressed() -> void:
	reset_globals()
	get_tree().change_scene_to_file("res://scene/title_screen.tscn")

func reset_globals():
	Globals.player_lifes = 3
	Globals.score = 0
	Globals.water = 0
