extends Node2D

enum DrinkTypes {Fermented,Distillied,Liquor,Cocktail,Softs}
enum IngredientsTypes {Fruit,Plant,Liquid,Vegetables,Misc}

func GetDrinkTypeTexture(type:DrinkTypes):
	return preload("res://icon.svg")

func GetIngredientTypeTexture(type:IngredientsTypes):
	return preload("res://icon.svg")
