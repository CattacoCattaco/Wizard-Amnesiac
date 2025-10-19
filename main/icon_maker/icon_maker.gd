class_name IconMaker
extends SubViewport


func _ready() -> void:
	if OS.has_feature("editor"):
		await RenderingServer.frame_post_draw
		get_texture().get_image().save_png("res://icon.png")
		print("hi")
