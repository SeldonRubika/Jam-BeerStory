extends Control

@export var book_open: Control
@export var textures : Array[Texture2D] = []
@export var couverture: TextureRect



func animate(duration:float):
	for i in range(1,textures.size()):
		couverture.texture=textures[i]
		await get_tree().create_timer(duration/(textures.size()-1)).timeout
	hide()
	book_open.show()
