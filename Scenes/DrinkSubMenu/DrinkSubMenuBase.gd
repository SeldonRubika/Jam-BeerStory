extends Control
class_name DrinkSubMenu

@export var id := ""

func selected():
	Global.active_drink_submenu = self
	show()
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1.0,1.0,1.0,1.0),.5)

func deselect():
	var tween = create_tween()
	tween.tween_property(self,"modulate",Color(1.0,1.0,1.0,0.0),.5)
	tween.tween_callback(hide)
