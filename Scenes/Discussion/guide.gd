extends TextureButton

@export var panel: Panel


func _on_pressed() -> void:
	panel.visible = !panel.visible
