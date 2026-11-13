extends Control

@export var resource : DrinkResource = preload("uid://bdmceqrdpnw21")
@export var name_label: AutoSizeRichTextLabel
@export var drink_icon: TextureRect
#hover
@export var hover: Panel
@export var degreesHover: AutoSizeRichTextLabel
@export var bitternessHover: AutoSizeRichTextLabel
@export var sweetnessHover: AutoSizeRichTextLabel
@export var hover_name_label: AutoSizeRichTextLabel
@export var booleansHover: AutoSizeRichTextLabel

#focus
@export var focus: Panel
@export var focus_name_label: AutoSizeRichTextLabel
@export var degreesFocus: AutoSizeRichTextLabel
@export var bitternessFocus: AutoSizeRichTextLabel
@export var sweetnessFocus: AutoSizeRichTextLabel
@export var booleansFocus: AutoSizeRichTextLabel
@export var description: AutoSizeRichTextLabel

func set_self_ui():
	name_label.text = resource.drink_name
	name_label.add_theme_color_override("default_color",resource.text_color)
	drink_icon.texture = resource.icon
	name_label.do_resize_text()

	if (focus.visible):
		set_focus_ui()
	if hover.visible:
		set_hover_ui()


func set_focus_ui():
	degreesFocus.text =": "+str(resource.degrees)
	focus_name_label.add_theme_color_override("default_color",resource.text_color)
	focus_name_label.text = resource.drink_name
	sweetnessFocus.text =": "+str(resource.sweetness)
	bitternessFocus.text =": "+str(resource.bitterness)
	focus_name_label.do_resize_text()
	description.text = resource.desc
	if (resource.fruity and resource.gazeous):
		booleansFocus.text = "fruité | pétillant"
	else:
		if (resource.fruity):
			booleansFocus.text = "fruité"
		if (resource.gazeous):
			booleansFocus.text = "pétillant"

func set_hover_ui():
	hover_name_label.text = resource.drink_name
	hover_name_label.add_theme_color_override("default_color",resource.text_color)
	hover_name_label.do_resize_text()
	degreesHover.text =": "+str(resource.degrees)
	bitternessHover.text =": "+str(resource.bitterness)
	sweetnessHover.text =": "+str(resource.sweetness)
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
	hover.show()
	set_hover_ui()

func _on_mouse_exited() -> void:
	hover.hide()


func _on_focus_entered() -> void:
	focus.show()
	set_focus_ui()


func _on_focus_exited() -> void:
	focus.hide()
