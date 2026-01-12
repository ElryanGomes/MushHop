extends Area2D

@onready var collect_sfx: AudioStreamPlayer = $collect_sfx as AudioStreamPlayer

@export var score_itens := 100

func _ready() -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	Globals.player_lifes += 1

	collect_sfx.reparent(get_tree().current_scene)
	collect_sfx.play()
	Globals.score += score_itens

	queue_free()
