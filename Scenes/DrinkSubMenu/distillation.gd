extends DrinkSubMenu
@export var alambic_1: TextureButton
@export var alambic_2: TextureButton
@export var result: TextureButton
@export var result_2: TextureButton


@onready var slots := [alambic_1,alambic_2]
var awaiting_slots := []
@export var distillation_time :=10.0

func ingredient_selected():
	awaiting_slots.clear()
	for slot in slots:
		if slot.get_child(0).resource == null:
			awaiting_slots.append(slot)
			slot.disabled = false

func _on_alambic_pressed() -> void:
	pass # Replace with function body.


func _on_alambic_2_pressed() -> void:
	pass # Replace with function body.


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
