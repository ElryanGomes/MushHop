extends Control

@onready var water_counter: Label = $container/water_container/water_counter as Label
@onready var score_counter: Label = $container/score_container/score_counter as Label
@onready var life_counter: Label = $container/life_container/life_counter as Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	water_counter.text = str("%04d" % Globals.water)
	score_counter.text = str("%06d" % Globals.score)
	life_counter.text = str("%02d" % Globals.player_lifes)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	water_counter.text = str("%04d" % Globals.water)
	score_counter.text = str("%06d" % Globals.score)
	life_counter.text = str("%02d" % Globals.player_lifes)
