extends Control
@export var main_part: Panel

@export var magic_circle_shader: ColorRect
var color_theme := Color("8c73ff")

func _process(_delta: float) -> void:
	if(visible):
		magic_circle_shader.material.set_shader_parameter("color",color_theme)
		main_part.get_theme_stylebox("panel").border_color = color_theme

func _on_magic_circle_color_change_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,'color_theme',Color(randf(),randf(),randf()),2)


func _on_start_pressed() -> void:
	hide()


func _on_options_pressed() -> void:
	print("nope")


func _on_quit_pressed() -> void:
	get_tree().quit()
