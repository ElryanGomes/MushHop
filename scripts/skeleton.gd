extends CharacterBody2D

var direction := -1
var dead := false

@export var SPEED = 1200
@export var enemy_score := 100

@onready var wall_detector: RayCast2D = $wall_detector
@onready var anima: AnimatedSprite2D = $anim
@onready var die_sfx: AudioStreamPlayer = $die_sfx as AudioStreamPlayer

func _physics_process(delta: float) -> void:
	if dead:
		return

	if not is_on_floor():
		velocity += get_gravity() * delta

	# Detecta parede
	if wall_detector.is_colliding():
		direction *= -1
		wall_detector.scale.x *= -1
	
	if direction == 1:
		anima.flip_h = true
	else:
		anima.flip_h = false

	anima.play("walk")
	velocity.x = direction * SPEED * delta

	move_and_slide()


func die():
	if dead:
		return

	dead = true
	velocity = Vector2.ZERO
	set_physics_process(false)
	anima.play("hurt")

	die_sfx.reparent(get_tree().current_scene)
	die_sfx.play()
	Globals.score += enemy_score

func _on_anim_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hurt":
		queue_free()
