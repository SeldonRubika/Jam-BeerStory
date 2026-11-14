extends Resource
class_name IngredientResource

@export_category("information")
@export var ingredient_name := "Pomme"
@export var base := ""
@export var icon : Texture2D = preload("res://icon.svg")
@export var desc :="Le type de bière pour lesquelles mathis se fait ban du camel"
var text_color : Color = [Color.YELLOW,Color.RED,Color.SKY_BLUE,Color.GREEN_YELLOW,Color.ORANGE].pick_random()

@export_category("Stats")
@export var type : Global.IngredientsTypes = Global.IngredientsTypes.Fruit
@export var bitterness := 0
@export var sweetness := 0
@export var fruity := false
@export var gazeous := false

func GetBroyageResource():
	var new = DrinkResource.new()
	new.degrees = 0
	new.ingredient_name = "Jus de " + ingredient_name
	new.base = ingredient_name
	new.desc = "Jus très nutritif fait à partir de " + ingredient_name + "."
	new.type = Global.IngredientsTypes.Liquid
	new.types = Global.DrinkTypes.Softs
	new.bitterness = bitterness
	new.sweetness = sweetness
	new.fruity = fruity
	new.gazeous = gazeous
	return new
	match (ingredient_name):
		"Cactus":return load("uid://bokirk1ohqn0h")
	return load("uid://ch5hbfceu2m0h")

func GetFermentedResource():
	if ingredient_name[0] == "M":
		var new = DrinkResource.new()
		new.ingredient_name = "Bière de " + ingredient_name
		new.base = ingredient_name
		new.desc = "Bière fait à partir de " + ingredient_name + "."
		new.type = Global.IngredientsTypes.Liquid
		new.types = Global.DrinkTypes.Softs
		new.bitterness = bitterness * 1.1
		new.sweetness = sweetness * 0.9
		new.degrees = new.sweetness * 0.3
		new.fruity = fruity
		new.gazeous = true
		return new
	if ingredient_name[0] == "J":
		var new = DrinkResource.new()
		new.ingredient_name = "Vin de " + ingredient_name
		new.base = ingredient_name
		new.desc = "Vin fait à partir de " + ingredient_name + "."
		new.type = Global.IngredientsTypes.Liquid
		new.types = Global.DrinkTypes.Softs
		new.bitterness = bitterness * 1.1
		new.sweetness = sweetness * 0.9
		new.degrees = new.sweetness * 0.5
		new.fruity = fruity
		new.gazeous = gazeous
		return new
	match (ingredient_name):
		"Eau":return load("uid://m1o0eubqv17j")
	return load("uid://c1wsgln1jh5kw")

func GetBroyageByproduct():
	var new = DrinkResource.new()
	new.degrees = 0
	new.ingredient_name = "Moût de " + ingredient_name
	new.base = ingredient_name
	new.desc = "Moût très nutritif fait à partir de " + ingredient_name + "."
	new.type = Global.IngredientsTypes.Liquid
	new.types = Global.DrinkTypes.Softs
	new.bitterness = bitterness * 1.3
	new.sweetness = sweetness * 0.2
	new.fruity = fruity
	new.gazeous = gazeous
	return new
	match (ingredient_name):
		"":return
	return load("uid://ch5hbfceu2m0h")
