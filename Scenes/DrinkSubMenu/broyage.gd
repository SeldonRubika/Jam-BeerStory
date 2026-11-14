extends DrinkSubMenu

@export var pilon: TextureButton
var pilon_awaiting := false
var required_pilonnage = 20
var pilonnage_state := 0
@export var broyage_progress: ProgressBar
@export var byproduct: IngredientBase

func _on_pilon_pressed() -> void:
	var child := pilon.get_child(0)
	#tu peux broyer, n'importe quel ingrédients pas liquide
	if (!child.resource):
		if !Global.selected_ingredients:
			return
		if ( Global.selected_ingredients.resource.type == Global.IngredientsTypes.Liquid):
			return
		child.resource = Global.selected_ingredients.resource
		child.set_self_ui()
		Global.selected_ingredients.resource = null
		Global.selected_ingredients.set_self_ui()
		Global.selected_ingredients = null
		required_pilonnage = 20 + randi_range(-2,2)
		broyage_progress.max_value = required_pilonnage
	else:
		var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
		cell.resource = child.resource
		cell.set_self_ui()
		child.resource = null
		child.set_self_ui()
		pilon.disabled = true

func ingredient_selected():
	if pilon.get_child(0).resource == null:
		pilon_awaiting = false
		pilon.disabled = pilon_awaiting


func _on_broyage_pressed() -> void:
	var child := pilon.get_child(0)
	if !child.resource:
		return
	if child.resource.type == Global.IngredientsTypes.Liquid:
		return
	pilonnage_state += 1
	if pilonnage_state >= required_pilonnage:
		pilonnage_state = 0
		byproduct.resource = child.resource.GetBroyageByproduct()
		byproduct.set_self_ui()
		child.resource = child.resource.GetBroyageResource()
		child.set_self_ui()
	broyage_progress.value = pilonnage_state


func _on_byproducts_pressed() -> void:
	if byproduct.resource ==null:
		return
	var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
	cell.resource = byproduct.resource
	cell.set_self_ui()
	byproduct.resource = null
	byproduct.set_self_ui()
