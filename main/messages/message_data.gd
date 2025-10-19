class_name MessageData
extends Resource

@export var title: String = ""
@export var message: String = ""


func _init(p_title: String = "", p_message: String = "") -> void:
	title = p_title
	message = p_message
