extends Node2D

enum DrinkTypes {Fermented,Distillied,Liquor,Cocktail,Softs}
enum IngredientsTypes {Fruit,Plant,Liquid,Vegetables,Misc}

const DRINK_BASE = preload("uid://dkggdakosi2hr")

var grid: GridContainer

var active_drink_submenu : DrinkSubMenu = null

var selected_ingredients:IngredientBase

func GetDrinkTypeTexture(type:DrinkTypes):
	match type:
		DrinkTypes.Fermented: return preload("uid://bsw820vxibise")
		DrinkTypes.Distillied: return preload("uid://clu0dbsxr7plw")
		DrinkTypes.Liquor: return preload("uid://b4cektdkkhrxi")
		DrinkTypes.Cocktail: return preload("uid://cgu62rknsqtan")
		DrinkTypes.Softs: return preload("uid://bflc0eofbxgtn")

func GetIngredientTypeTexture(type:IngredientsTypes):
	match type:
		IngredientsTypes.Fruit: return preload("uid://i2y6iqcj54u8")
		IngredientsTypes.Plant: return preload("uid://bfc16djkiph3h")
		IngredientsTypes.Liquid: return preload("uid://bwickkrqp6r6i")
		IngredientsTypes.Vegetables: return preload("uid://dfdmbim5yrqix")
		IngredientsTypes.Misc: return preload("uid://u81q2gm63eb0")

func GetFirstInventoryEmptyCell():
	for child in grid.get_children():
		if child.resource == null:
			return child
	var new_cell = DRINK_BASE.instantiate()
	grid.add_child(new_cell)
	return new_cell
