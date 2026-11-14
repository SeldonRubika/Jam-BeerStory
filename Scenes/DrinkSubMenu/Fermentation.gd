extends DrinkSubMenu


@export var tonneau_1: TextureButton
@export var tonneau_2: TextureButton
@export var tonneau_3: TextureButton
@onready var slots := [tonneau_1,tonneau_2,tonneau_3]
var awaiting_slots := []
@export var fermentation_time :=10.0

func ingredient_selected():
	awaiting_slots.clear()
	for slot in slots:
		if slot.get_child(0).resource == null:
			awaiting_slots.append(slot)
			slot.disabled = false


func _on_tonneau_pressed() -> void:
	object_in_tonneau(tonneau_1)


func _on_tonneau_2_pressed() -> void:
	object_in_tonneau(tonneau_2)

func _on_tonneau_3_pressed() -> void:
	object_in_tonneau(tonneau_3)

func object_in_tonneau(tonneau:TextureButton):
	var child := tonneau.get_child(0)
	if (!child.resource):
		print("hey")
		if !Global.selected_ingredients:
			return
		if ( Global.selected_ingredients.resource.type != Global.IngredientsTypes.Liquid):
			return
		if Global.selected_ingredients.resource.types != Global.DrinkTypes.Softs:
			return
		print("ho")
		child.resource = Global.selected_ingredients.resource
		child.set_self_ui()
		Global.selected_ingredients.resource = null
		Global.selected_ingredients.set_self_ui()
		Global.selected_ingredients = null
		tonneau.disabled = true
		tonneau.get_child(1).animate(fermentation_time)
		await get_tree().create_timer(fermentation_time).timeout
		tonneau.disabled = false
		child.resource = child.resource.GetFermentedResource()
		child.set_self_ui()
	else:
		if (child.resource.type != Global.IngredientsTypes.Liquid):
			print("error, non liquid in fermentation case")
			return
		if (child.resource.types != Global.DrinkTypes.Fermented):
			print("error, result of fermentation was not fermented type")
			return
		var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
		cell.resource = child.resource
		cell.set_self_ui()
		child.resource = null
		child.set_self_ui()
		tonneau.disabled = true
