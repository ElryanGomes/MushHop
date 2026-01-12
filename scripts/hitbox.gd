extends Area2D

var used := false

func _on_body_entered(body: Node2D) -> void:
	if used:
		return

	if body.name == "Player":
		used = true
		set_deferred("monitoring", false)
		set_deferred("monitorable", false)
		owner.queue_free()

		if owner.has_method("die"):
			
			owner.die()

		body.velocity.y = body.JUMP_VELOCITY * 0.6
