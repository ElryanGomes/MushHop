extends Area2D

@export var duration := 8.0
@onready var collect_sfx: AudioStreamPlayer = $collect_sfx as AudioStreamPlayer

@export var score_itens := 50

func _ready() -> void:
	pass

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("add_invert_control_debuff"):
		body.add_invert_control_debuff(duration)

		collect_sfx.reparent(get_tree().current_scene)
		collect_sfx.play()
		Globals.score += score_itens

		queue_free()
