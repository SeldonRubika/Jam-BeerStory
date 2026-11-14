extends Control
class_name DrinkSubMenu

@export var id := ""

func selected():
	Global.active_drink_submenu = self
	show()

func deselect():
	hide()
