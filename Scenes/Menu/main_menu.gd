extends Control

@export var magic_circle_shader: ColorRect
var color_theme := Color("8c73ff")
@export var book_closed: Control
@export var title: AutoSizeRichTextLabel

func _process(_delta: float) -> void:
	if(visible):
		magic_circle_shader.material.set_shader_parameter("color",color_theme)

func _on_magic_circle_color_change_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,'color_theme',Color(randf(),randf(),randf()),2)

func _on_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1.0,1.0,1.0,0.0),.5)
	tween.parallel().tween_property(title,"modulate",Color(1.0,1.0,1.0,0.0),.5)
	await tween.finished
	hide()
	book_closed.show()
	book_closed.animate(5)
