extends TextureButton



var muted := false
@export var scheisse: AudioStreamPlayer

func _on_pressed() -> void:
	if muted:
		muted = false
		scheisse.volume_linear = 1.0
	else:
		muted= true
		scheisse.volume_linear = 0.0
