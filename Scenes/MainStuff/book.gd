extends Control


@export var fermentation: DrinkSubMenu
@export var grid: GridContainer
@export var broyage: DrinkSubMenu

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


func _on_discussion_book_pressed() -> void:
	pass # Replace with function body.


func _on_broyage_book_pressed() -> void:
	if Global.active_drink_submenu:
		Global.active_drink_submenu.deselect()
	broyage.selected()

func _on_distiller_book_pressed() -> void:
	pass # Replace with function body.


func _on_jardinier_book_pressed() -> void:
	pass # Replace with function body.
