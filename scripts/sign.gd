extends Area2D

@export var messages : Array[String] = []

@onready var message_label: Label = %message_label
@onready var panel: Panel = $Panel

@onready var current_message_index := 0

func _ready():
	message_label.text = messages[current_message_index]
	
func _on_player_interaction():
	if current_message_index >= messages.size() -1:
		current_message_index = 0
		message_label.text = messages[current_message_index]
	else:
		current_message_index += 1
		panel.visible = true
		message_label.visible = true
		message_label.text = messages[current_message_index]

func _unhandled_input(event):
	if (event.is_action_pressed("ui_cancel")):
		panel.visible = false
		message_label.visible = false
