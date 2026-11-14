extends Control


@export var fermentation: DrinkSubMenu
@export var grid: GridContainer

func _ready() -> void:
	Global.grid = grid

func _on_storage_bookmark_pressed() -> void:
	if Global.active_drink_submenu:
		Global.active_drink_submenu.deselect()
	Global.active_drink_submenu = null


func _on_fermentation_bookmark_2_pressed() -> void:
	if Global.active_drink_submenu:
		Global.active_drink_submenu.deselect()
	fermentation.selected()
