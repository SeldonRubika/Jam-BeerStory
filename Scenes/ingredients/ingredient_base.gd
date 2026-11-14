extends Button
class_name IngredientBase

@export var resource : IngredientResource = preload("uid://b8ars7q4rr4bi")
@export var name_label: AutoSizeRichTextLabel
@export var ingredient_icon: TextureRect
#hover
@export var hover: Panel
@export var bitternessHover: AutoSizeRichTextLabel
@export var sweetnessHover: AutoSizeRichTextLabel
@export var hover_name_label: AutoSizeRichTextLabel
@export var booleansHover: AutoSizeRichTextLabel
@export var hover_icon: TextureRect

#focus
@export var focus: Panel
@export var focus_name_label: AutoSizeRichTextLabel
@export var bitternessFocus: AutoSizeRichTextLabel
@export var sweetnessFocus: AutoSizeRichTextLabel
@export var booleansFocus: AutoSizeRichTextLabel
@export var description: AutoSizeRichTextLabel
@export var focus_icon: TextureRect

func set_self_ui():
	if (!resource):
		disabled = true
		name_label.get_parent().hide()
		ingredient_icon.hide()
		return
	disabled = false
	ingredient_icon.show()
	name_label.get_parent().show()
	name_label.text = resource.ingredient_name
	name_label.add_theme_color_override("default_color",resource.text_color)
	ingredient_icon.texture = resource.icon
	name_label.do_resize_text()

	if (focus.visible):
		set_focus_ui()
	if hover.visible:
		set_hover_ui()


func set_focus_ui():
	if (!resource):
		return
	focus_name_label.add_theme_color_override("default_color",resource.text_color)
	focus_name_label.text = resource.ingredient_name
	sweetnessFocus.text =": "+str(resource.sweetness)
	bitternessFocus.text =": "+str(resource.bitterness)
	focus_name_label.do_resize_text()
	description.text = resource.desc
	focus_icon.texture = Global.GetIngredientTypeTexture(resource.type)
	if (resource.fruity and resource.gazeous):
		booleansFocus.text = "fruité | pétillant"
	else:
		if (resource.fruity):
			booleansFocus.text = "fruité"
		if (resource.gazeous):
			booleansFocus.text = "pétillant"

func set_hover_ui():
	if (!resource):
		return
	hover_name_label.text = resource.ingredient_name
	hover_name_label.add_theme_color_override("default_color",resource.text_color)
	hover_name_label.do_resize_text()
	bitternessHover.text =": "+str(resource.bitterness)
	sweetnessHover.text =": "+str(resource.sweetness)
	hover_icon.texture = Global.GetIngredientTypeTexture(resource.type)
	if (resource.fruity and resource.gazeous):
		booleansHover.text = "fruité | pétillant"
	else:
		if (resource.fruity):
			booleansHover.text = "fruité"
		if (resource.gazeous):
			booleansHover.text = "pétillant"

func _ready() -> void:
	set_self_ui()

func _on_mouse_entered() -> void:
	if (!resource):
		return
	hover.show()
	set_hover_ui()

func _on_mouse_exited() -> void:
	hover.hide()


func _on_focus_entered() -> void:
	if (!resource):
		return
	focus.show()
	set_focus_ui()


func _on_focus_exited() -> void:
	focus.hide()

func _process(_delta: float) -> void:
	if Global.active_drink_submenu != null:
		focus.hide()

func _on_pressed() -> void:
	if !Global.active_drink_submenu:
		return
	match(Global.active_drink_submenu.id):
		"Fermentation": 
			Global.selected_ingredients = self
			Global.active_drink_submenu.ingredient_selected()
			
