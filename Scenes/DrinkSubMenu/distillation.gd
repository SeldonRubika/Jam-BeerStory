extends DrinkSubMenu
@export var alambic_1: TextureButton
@export var alambic_2: TextureButton
@export var result: TextureButton
@export var result_2: TextureButton


@onready var slots := [alambic_1,alambic_2]
var awaiting_slots := []
@export var distillation_time := 9.0

func ingredient_selected():
	awaiting_slots.clear()
	for slot in slots:
		if slot.get_child(0).resource == null:
			awaiting_slots.append(slot)
			slot.disabled = false

func _on_alambic_pressed() -> void:
	distillation(alambic_1)

func _on_alambic_2_pressed() -> void:
	distillation(alambic_2)


func distillation(alambic):
	var child = alambic.get_child(0)
	if (!child.resource):
		if !Global.selected_ingredients:
			return
		if ( Global.selected_ingredients.resource.type != Global.IngredientsTypes.Liquid):
			return
		child.resource = Global.selected_ingredients.resource
		child.set_self_ui()
		Global.selected_ingredients.resource = null
		Global.selected_ingredients.set_self_ui()
		Global.selected_ingredients = null
		alambic.disabled = true
		alambic.get_child(1).animate(distillation_time)
		await get_tree().create_timer(distillation_time).timeout
		alambic.disabled = false
		child.resource = child.resource.GetDistilledResource()
		child.set_self_ui()
	else:
		if (child.resource.type != Global.IngredientsTypes.Liquid):
			print("error, non liquid in distillation case")
			return
		if (child.resource.types != Global.DrinkTypes.Distillied):
			print("error, result of distilliation was not distillied type")
			return
		var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
		cell.resource = child.resource
		cell.set_self_ui()
		child.resource = null
		child.set_self_ui()
		alambic.disabled = true


func _on_result_pressed() -> void:
	var child = result.get_child(0)
	if (child.resource):
		var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
		cell.resource = child.resource
		cell.set_self_ui()
		child.resource = null
		child.set_self_ui()

func _on_result_2_pressed() -> void:
	var child = result_2.get_child(0)
	if (child.resource):
		var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
		cell.resource = child.resource
		cell.set_self_ui()
		child.resource = null
		child.set_self_ui()
