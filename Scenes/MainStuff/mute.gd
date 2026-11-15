extends TextureButton



var muted := false
@export var scheisse: AudioStreamPlayer

func _on_pressed() -> void:
	if muted:
		scheisse.volume_linear = 1.0
	else:
		scheisse.volume_linear = 0.0
