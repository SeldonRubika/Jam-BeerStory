extends IngredientBase
class_name DrinkBase

@export var degreesHover: AutoSizeRichTextLabel

@export var degreesFocus: AutoSizeRichTextLabel

func set_focus_ui():
	super()
	if resource.type == Global.IngredientsTypes.Liquid:
		degreesFocus.text =": "+str(resource.degrees)
		focus_icon.texture = Global.GetDrinkTypeTexture(resource.types)


func set_hover_ui():
	super()
	if resource.type == Global.IngredientsTypes.Liquid:
		degreesHover.text =": "+str(resource.degrees)
		hover_icon.texture = Global.GetDrinkTypeTexture(resource.types)

func _on_pressed() -> void:
	super()
	if(Global.active_drink_submenu):
		match Global.active_drink_submenu.id:
			"Fermentation": 
				if resource.type != Global.IngredientsTypes.Liquid:
					return
				if (resource.types==Global.DrinkTypes.Softs):
					Global.selected_ingredients = self
					Global.active_drink_submenu.ingredient_selected()
