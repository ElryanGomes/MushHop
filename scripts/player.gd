extends CharacterBody2D

enum PlayerState {
	idle,
	walk,
	jump,
	duck,
	dead
}

var speed_bonus := 0.0
var inverted_controls := false
var knockback_vector := Vector2.ZERO
var dead := false

@onready var anima: AnimatedSprite2D = $anim
@onready var remote_transform := $remote as RemoteTransform2D
@onready var jump_sfx: AudioStreamPlayer = $audios/jump_sfx as AudioStreamPlayer
@onready var damage_sfx: AudioStreamPlayer = $audios/damage_sfx as AudioStreamPlayer
@onready var loser_sfx: AudioStreamPlayer = $audios/loser_sfx as AudioStreamPlayer

@onready var interaction_area: Area2D = $interaction_area
@onready var sign: Area2D = %sign

@export var SPEED = 80.0
@export var JUMP_VELOCITY = -300.0

var status: PlayerState

func _ready() -> void:
	if Globals.checkpoint_position != Vector2.ZERO:
		global_position = Globals.checkpoint_position
	go_to_idle_state()

func _physics_process(delta: float) -> void:
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	match status:
		PlayerState.idle:
			idle_state()
		PlayerState.walk:
			walk_state()
		PlayerState.jump:
			jump_state()
		PlayerState.duck:
			duck_state()
		PlayerState.dead:
			dead_state()
			
	if knockback_vector != Vector2.ZERO:
		velocity = knockback_vector
			
	move_and_slide()
	check_enemy_collision()
	check_fall_death()

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		var signs_in_range = interaction_area.get_overlapping_areas()
		for sign in signs_in_range:
			if sign.is_in_group("signs"):
				sign._on_player_interaction()

func go_to_idle_state():
	status = PlayerState.idle
	anima.play("idle")
	
func go_to_walk_state():
	status = PlayerState.walk
	anima.play("walk")
	
func go_to_jump_state():
	status = PlayerState.jump
	jump_sfx.play()
	anima.play("jump")
	velocity.y = JUMP_VELOCITY
	
func go_to_duck_state():
	status = PlayerState.duck
	anima.play("duck")
	
func go_to_dead_state():
	status = PlayerState.dead
	anima.play("dead")
	velocity = Vector2.ZERO

func idle_state():
	move()
	if velocity.x != 0:
		go_to_walk_state()
		return
		
	if Input.is_action_just_pressed("jump"):
		go_to_jump_state()
		return
		
	if Input.is_action_pressed("duck"):
		go_to_duck_state()
		return
	
func walk_state():
	move()
	if velocity.x == 0:
		go_to_idle_state()
		return
		
	if Input.is_action_just_pressed("jump"):
		go_to_jump_state()
		return
		
	if Input.is_action_pressed("duck"):
		go_to_duck_state()
		velocity.x = 0
		return
	
func jump_state():
	move()
	if is_on_floor():
		if velocity.x == 0:
			go_to_idle_state()
		else:
			go_to_walk_state()
		return
		
func duck_state():
	if Input.is_action_just_released("duck"):
		go_to_idle_state()
		
func dead_state():
	pass
	
func move():
	var direction := Input.get_axis("left", "right")

	if inverted_controls:
		direction = -direction

	velocity.x = direction * SPEED

	if direction < 0:
		anima.flip_h = true
	elif direction > 0:
		anima.flip_h = false


func add_speed_buff(amount: float, duration: float):
	speed_bonus = amount
	await get_tree().create_timer(duration).timeout
	speed_bonus = 0.0
	
func add_invert_control_debuff(duration: float):
	inverted_controls = true
	await get_tree().create_timer(duration).timeout
	inverted_controls = false

func _on_hitbox_area_entered(area: Area2D) -> void:
	print("COLIDIU COM:", area.name)

func check_enemy_collision():
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()

		if collider and collider.is_in_group("enemy"):
			# normal Y > 0.7 = colisão sentindo de cima
			if collision.get_normal().y > 0.7:
				collider.queue_free()
				velocity.y = JUMP_VELOCITY * 0.6
				
				print("inimigo morre")
				return
			else:
				go_to_dead_state()
				anima.play("dead")

				print("player morre")

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if dead:
		return

	if Globals.player_lifes <= 1:
		die()
	else:
		if $ray_right.is_colliding():
			take_damage(Vector2(-200, -200))
		elif $ray_left.is_colliding():
			take_damage(Vector2(200, -200))
			
func check_fall_death():
	if dead:
		return

	if global_position.y > 200:
		die()
		
func die():
	if dead:
		return

	dead = true
	status = PlayerState.dead
	velocity = Vector2.ZERO

	anima.play("dead")

	loser_sfx.reparent(get_tree().current_scene)
	loser_sfx.play()

	# pequeno delay para a animação aparecer
	await get_tree().create_timer(0.5).timeout

	get_tree().change_scene_to_file("res://scene/game_over.tscn")


func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path

func take_damage(knockback_force := Vector2.ZERO, duration := 0.25):
	Globals.player_lifes -= 1

	if knockback_force != Vector2.ZERO:
		knockback_vector = knockback_force
		
		var knockback_tween := get_tree().create_tween()
		knockback_tween.parallel().tween_property(self, "knockback_vector", Vector2.ZERO, duration)
		anima.modulate = Color(1,0,0,1)
		knockback_tween.parallel().tween_property(anima, "modulate", Color(1,1,1,1), duration + 0.30)
		damage_sfx.play()
