extends DrinkSubMenu

@export var slot_1: TextureButton
@export var slot_2: TextureButton
@export var result: TextureButton

@onready var slots := [slot_1,slot_2]
var awaiting_slots := []

func ingredient_selected():
	awaiting_slots.clear()
	for slot in slots:
		if slot.get_child(0).resource == null:
			awaiting_slots.append(slot)
			slot.disabled = false

func get_item(child):
	child.resource = Global.selected_ingredients.resource
	child.set_self_ui()
	Global.selected_ingredients.resource = null
	Global.selected_ingredients.set_self_ui()
	Global.selected_ingredients = null

func _on_slot_1_pressed() -> void:
	var child = slot_1.get_child(0)
	if (!child.resource):
		if Global.selected_ingredients.resource.type != Global.IngredientsTypes.Liquid:
			return
		get_item(child)

func _on_slot_2_pressed() -> void:
	var child = slot_2.get_child(0)
	if (!child.resource):
		get_item(child)
