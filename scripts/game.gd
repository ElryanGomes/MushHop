extends Node2D

@onready var player := $Player as CharacterBody2D
@onready var camera := $Camera as Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Globals.checkpoint_scene = "res://scene/game.tscn"
	Globals.checkpoint_score = Globals.score
	Globals.checkpoint_water = Globals.water
	Globals.player_lifes = 3
	player.follow_camera(camera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



#func _on_area_sign_body_entered(body: Node2D) -> void:
	#pass # Replace with function body.
