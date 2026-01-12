extends CanvasLayer

@onready var resume_btn: Button = $menu_holder/resume_btn

func _ready() -> void:
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		resume_btn.grab_focus()
		toggle_pause()

func toggle_pause():
	if get_tree().paused:
		resume_game()
	else:
		pause_game()

func pause_game():
	get_tree().paused = true
	visible = true
	resume_btn.grab_focus()

func resume_game():
	get_tree().paused = false
	visible = false

func _on_resume_btn_pressed() -> void:
	resume_game()

func _on_quit_btn_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/title_screen.tscn")
