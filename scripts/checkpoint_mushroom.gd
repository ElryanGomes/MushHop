extends Area2D

@onready var anim: AnimatedSprite2D = $anim
@onready var audio: AudioStreamPlayer = $audio

var activated := false

func _ready() -> void:
	anim.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if activated:
		return

	if body.is_in_group("Player"):
		activated = true

		# salva checkpoint
		Globals.checkpoint_scene = get_tree().current_scene.scene_file_path
		Globals.checkpoint_position = body.global_position
		Globals.checkpoint_score = Globals.score
		Globals.checkpoint_water = Globals.water
		Globals.checkpoint_lifes = Globals.player_lifes

		anim.play("explosion3")
		audio.play()
		await anim.animation_finished
		queue_free()
