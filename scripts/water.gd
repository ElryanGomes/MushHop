extends Area2D

var water := 1

@onready var collision: CollisionShape2D = $collision
@onready var anima: AnimatedSprite2D = $anima
@onready var water_collect_sfx: AudioStreamPlayer = $water_collect_sfx

@export var score_itens = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	anima.play("sumir")
	water_collect_sfx.play()
	await collision.call_deferred("queue_free")
	Globals.water += water
	Globals.score += score_itens


func _on_anima_animation_finished() -> void:
	queue_free()
