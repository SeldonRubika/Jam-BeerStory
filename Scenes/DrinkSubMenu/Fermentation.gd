extends Control
class_name DrinkSubMenu

var id := "Fermentation"

func selected():
	Global.active_drink_submenu = self
	show()

func deselect():
	hide()
