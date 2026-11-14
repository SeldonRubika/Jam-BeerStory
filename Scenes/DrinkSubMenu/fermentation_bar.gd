extends TextureRect

@export var textures : Array[Texture2D] = []

func animate(duration:float):
	for i in range(1,textures.size()):
		texture=textures[i]
		await get_tree().create_timer(duration/(textures.size()-1)).timeout
	texture = textures[0]
