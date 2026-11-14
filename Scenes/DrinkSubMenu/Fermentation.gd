extends Control
class_name DrinkSubMenu

var id := "Fermentation"
@export var tonneau: TextureButton
@export var tonneau_2: TextureButton
@export var tonneau_3: TextureButton
@onready var slots := [tonneau,tonneau_2,tonneau_3]
var awaiting_slots := []
func selected():
	Global.active_drink_submenu = self
	show()

func deselect():
	hide()

func ingredient_selected():
	awaiting_slots.clear()
	for slot in slots:
		if slot.get_child(0).resource == null:
			awaiting_slots.append(slot)
			slot.disabled = false
		else:
			slot.disabled = true


func _on_tonneau_pressed() -> void:
	tonneau.get_child(0).resource = Global.selected_ingredients.resource
	tonneau.get_child(0).set_self_ui()
	Global.selected_ingredients.resource = null
	Global.selected_ingredients.set_self_ui()


func _on_tonneau_2_pressed() -> void:
	tonneau_2.get_child(0).resource = Global.selected_ingredients.resource
	tonneau_2.get_child(0).set_self_ui()
	Global.selected_ingredients.resource = null
	Global.selected_ingredients.set_self_ui()

func _on_tonneau_3_pressed() -> void:
	tonneau_3.get_child(0).resource = Global.selected_ingredients.resource
	tonneau_3.get_child(0).set_self_ui()
	Global.selected_ingredients.resource = null
	Global.selected_ingredients.set_self_ui()
