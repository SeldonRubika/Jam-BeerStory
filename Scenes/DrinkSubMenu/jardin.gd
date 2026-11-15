extends DrinkSubMenu

const RESOURCES = [preload("uid://crn2ikri8g47b"),preload("uid://bucps5b1gdx05"), preload("uid://fbgjbmepeafv"), preload("uid://b4ffe5c6cmps5"), preload("uid://dmtpnurq5gcki"), preload("uid://cmlmnp63yypvp"), preload("uid://bcvergkg7bnb0"), preload("uid://ckyglmaykgfgv"), preload("uid://bm6ixfj8oq6u1"), preload("uid://de3bjqqxwd5hs"), preload("uid://i3v88dxy6e5u"), preload("uid://c17estnksnubl"), preload("uid://1jiyqfqeedhq"), preload("uid://djjm2snscj0k2"), preload("uid://chranlp01be07"), preload("uid://bvv2lxnh8rdfc"), preload("uid://b3qoivlaioq8x"), preload("uid://cp7o6yb4ihy3s"), preload("uid://ragmd3xshred"), preload("uid://d4c3qqq548vyh"), preload("uid://b2eme057js684"), preload("uid://bsqyyrdiqvt4f"), preload("uid://ban47ef15cf75"), preload("uid://b8ars7q4rr4bi"), preload("uid://c8gceunbms7t"), preload("uid://nqwr6eponxhx"), preload("uid://btdxjavagu23b"), preload("uid://cvy301xdki4s2"), preload("uid://cmdxmvgpyo5or")]

func get_item(slot):
	var child = slot.get_child(0)
	if (child.resource):
		var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
		cell.resource = child.resource
		cell.set_self_ui()
		child.resource = null
		child.set_self_ui()

@export var result_3: TextureButton
@export var result_2: TextureButton
@export var result: TextureButton
@export var result_4: TextureButton

func _on_timer_timeout() -> void:
	result_3.get_child(0).resource = RESOURCES.pick_random()
	result_3.get_child(0).set_self_ui()


func _on_timer_timeout2() -> void:
	result_2.get_child(0).resource = RESOURCES.pick_random()
	result_2.get_child(0).set_self_ui()


func _on_timer_timeout3() -> void:
	result.get_child(0).resource = RESOURCES.pick_random()
	result.get_child(0).set_self_ui()
func _on_timer_timeout4() -> void:
	result_4.get_child(0).resource = RESOURCES.pick_random()
	result_4.get_child(0).set_self_ui()


func _on_result_3_pressed() -> void:
	get_item(result_3)


func _on_result_2_pressed() -> void:
	get_item(result_2)


func _on_result1_pressed() -> void:
	get_item(result)

func _on_result_4_pressed() -> void:
	get_item(result_4)
