extends Control


@export var fermentation: DrinkSubMenu
@export var grid: GridContainer
@export var broyage: DrinkSubMenu
@export var page: TextureRect
@export var combination: DrinkSubMenu
@export var inventory_page: Control
@export var distillation: DrinkSubMenu
@export var clients: DrinkSubMenu

@onready var page_per_index := {
	0:clients,
	1:null,
	2:broyage,
	3:fermentation,
	4:distillation,
	5:combination,
	6:null,
}

var tab_index := 0
var previous_tab_index := 0
var changing_tab := false
var flip_tab_duration := 0.4
func _ready() -> void:
	Global.grid = grid
	clients.selected()

func change_tab():
	changing_tab = true
	var tween = create_tween()
	tween.tween_property(inventory_page,"modulate",Color(1.0,1.0,1.0,0.0),.5)
	await tween.finished
	if (previous_tab_index < tab_index):
		var difference = tab_index - previous_tab_index
		for i in range(difference):
			await page.animate(flip_tab_duration/difference)
	elif (previous_tab_index > tab_index):
		var difference =  previous_tab_index - tab_index
		for i in range(difference):
			await page.inverse_animate(flip_tab_duration/difference)
	previous_tab_index = tab_index
	var new_tween = create_tween()
	new_tween.tween_property(inventory_page,"modulate",Color(1.0,1.0,1.0,1.0),.5)
	if (page_per_index[tab_index]):
		page_per_index[tab_index].selected()
	changing_tab = false

func _on_storage_bookmark_pressed() -> void:
	if changing_tab:
		return
	if Global.active_drink_submenu:
		Global.active_drink_submenu.deselect()
	Global.active_drink_submenu = null
	tab_index = 1
	change_tab()


func _on_fermentation_bookmark_2_pressed() -> void:
	if changing_tab:
		return
	if Global.active_drink_submenu:
		Global.active_drink_submenu.deselect()
	tab_index = 3
	change_tab()

func _on_discussion_book_pressed() -> void:
	if changing_tab:
		return
	if Global.active_drink_submenu:
		Global.active_drink_submenu.deselect()
	tab_index = 0
	change_tab()

func _on_broyage_book_pressed() -> void:
	if changing_tab:
		return
	if Global.active_drink_submenu:
		Global.active_drink_submenu.deselect()
	tab_index = 2
	change_tab()

func _on_distiller_book_pressed() -> void:
	if changing_tab:
		return
	if Global.active_drink_submenu:
		Global.active_drink_submenu.deselect()
	tab_index = 4
	change_tab()

func _on_jardinier_book_pressed() -> void:
	if changing_tab:
		return
	tab_index = 6
	change_tab()


func _on_combination_book_pressed() -> void:
	if changing_tab:
		return
	if Global.active_drink_submenu:
		Global.active_drink_submenu.deselect()
	tab_index = 5
	change_tab()
