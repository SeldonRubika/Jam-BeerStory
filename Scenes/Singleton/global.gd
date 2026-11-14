extends Node2D

enum DrinkTypes {Fermented,Distillied,Liquor,Cocktail,Softs}
enum IngredientsTypes {Fruit,Plant,Liquid,Vegetables,Misc}

var grid: GridContainer

var active_drink_submenu : DrinkSubMenu = null

var selected_ingredients:IngredientBase

func GetDrinkTypeTexture(type:DrinkTypes):
	return preload("res://icon.svg")

func GetIngredientTypeTexture(type:IngredientsTypes):
	return preload("res://icon.svg")

func GetFirstInventoryEmptyCell():
	for child in grid.get_children():
		if child.resource == null:
			return child
	var new_cell = IngredientBase.new()
	grid.append(new_cell)
	return new_cell
