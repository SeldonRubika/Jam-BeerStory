extends IngredientBase

@export var degreesHover: AutoSizeRichTextLabel

@export var degreesFocus: AutoSizeRichTextLabel




func set_focus_ui():
	super()
	degreesFocus.text =": "+str(resource.degrees)
	focus_icon.texture = Global.GetDrinkTypeTexture(resource.types)


func set_hover_ui():
	super()
	degreesHover.text =": "+str(resource.degrees)
	hover_icon.texture = Global.GetDrinkTypeTexture(resource.types)
