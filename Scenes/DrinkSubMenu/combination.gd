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
	if !Global.selected_ingredients.resource:
		return
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
	else:
		var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
		cell.resource = child.resource
		cell.set_self_ui()
		child.resource = null
		child.set_self_ui()

func _on_slot_2_pressed() -> void:
	var child = slot_2.get_child(0)
	if (!child.resource):
		get_item(child)
	else:
		var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
		cell.resource = child.resource
		cell.set_self_ui()
		child.resource = null
		child.set_self_ui()


func _on_mixage_pressed() -> void:
	var child1 = slot_1.get_child(0)
	var child2 = slot_2.get_child(0)
	var result_child = result.get_child(0)
	if(!child1.resource or !child2.resource):
		return
	else:
		result_child.resource = child1.resource.GetCombinedResource(child2.resource)
		result_child.set_self_ui()
		child1.resource = null
		child1.set_self_ui()
		child2.resource = null
		child2.set_self_ui()

func _on_result_pressed() -> void:
	var child = result.get_child(0)
	if (child.resource):
		var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
		cell.resource = child.resource
		cell.set_self_ui()
		child.resource = null
		child.set_self_ui()
