extends Control

@export var book_open: Control
@export var textures : Array[Texture2D] = []
@export var couverture: TextureRect
@export var inventory_page: Control



func animate(duration:float):
	for i in range(1,textures.size()):
		couverture.texture=textures[i]
		await get_tree().create_timer(duration/(textures.size()-1)).timeout
	book_open.show()
	hide()
	var tween = create_tween()
	tween.tween_property(inventory_page,"modulate",Color(1.0,1.0,1.0,1.0),.5)
