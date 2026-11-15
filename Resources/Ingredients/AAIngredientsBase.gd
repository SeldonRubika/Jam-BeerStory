extends Resource
class_name IngredientResource

@export_category("information")
@export var ingredient_name := "Pomme"
@export var base := ""
@export var icon : Texture2D
@export var desc :="Le type de bière pour lesquelles mathis se fait ban du camel"
var text_color : Color = [Color.YELLOW,Color.RED,Color.SKY_BLUE,Color.GREEN_YELLOW,Color.ORANGE].pick_random()

@export_category("Stats")
@export var type : Global.IngredientsTypes = Global.IngredientsTypes.Fruit
@export_range(0,100) var bitterness := 0
@export_range(0,100) var sweetness := 0
@export var fruity := false
@export var gazeous := false

func GetBroyageResource():
	var new = DrinkResource.new()
	new.degrees = 0
	new.base = ingredient_name
	if new.base[0] in "AEIOUY" :
		new.ingredient_name = "Jus d'" + ingredient_name
		new.desc = "Jus très nutritif fait à partir d'" + ingredient_name + "."
	else :
		new.ingredient_name = "Jus de " + ingredient_name
		new.desc = "Jus très nutritif fait à partir de " + ingredient_name + "."
	new.type = Global.IngredientsTypes.Liquid
	new.types = Global.DrinkTypes.Softs
	new.bitterness = bitterness
	new.sweetness = sweetness
	new.fruity = fruity
	new.gazeous = gazeous
	return new

func GetFermentedResource():
	if ingredient_name[0] == "M":
		var new = DrinkResource.new()
		new.base = base
		if new.base[0] in "AEIOUY" :
			new.ingredient_name = "Bière d'" + new.base
			new.desc = "Bière fait à partir d'" + ingredient_name + "."
		else :
			new.ingredient_name = "Bière de " + new.base
			new.desc = "Bière fait à partir de " + ingredient_name + "."
		new.type = Global.IngredientsTypes.Liquid
		new.types = Global.DrinkTypes.Fermented
		new.bitterness = min(bitterness * 1.1, 100)
		new.degrees = max(min(100, 16 * sqrt(sweetness / 100.0) * (1.0 - bitterness / 500.0)),0)
		new.sweetness = sweetness * 0.75
		new.fruity = fruity
		new.gazeous = true
		return new
	if ingredient_name[0] == "J":
		var new = DrinkResource.new()
		new.base = base
		if new.base[0] in "AEIOUY" :
			new.ingredient_name = "Vin d'" + new.base
			new.desc = "Vin fait à partir d'" + ingredient_name + "."
		else :
			new.ingredient_name = "Vin de " + new.base
			new.desc = "Vin fait à partir de " + ingredient_name + "."
		new.type = Global.IngredientsTypes.Liquid
		new.types = Global.DrinkTypes.Fermented
		new.bitterness = min(bitterness * 1.1, 100)
		new.sweetness = sweetness * 0.75
		new.degrees = max(min(100,20 * sqrt(sweetness / 100.0) * (1.0 - bitterness / 500.0)),0)
		new.fruity = fruity
		new.gazeous = gazeous
		return new
	match (ingredient_name):
		"Eau":return load("uid://m1o0eubqv17j")
	return load("uid://c1wsgln1jh5kw")

func GetBroyageByproduct():
	var new = DrinkResource.new()
	new.degrees = 0
	new.base = ingredient_name
	if new.base[0] in "AEIOUY" :
		new.ingredient_name = "Moût d'" + ingredient_name
		new.desc = "Moût très nutritif fait à partir d'" + ingredient_name + "."
	else :
		new.ingredient_name = "Moût de " + ingredient_name
		new.desc = "Moût très nutritif fait à partir de " + ingredient_name + "."
	new.type = Global.IngredientsTypes.Liquid
	new.types = Global.DrinkTypes.Softs
	new.bitterness = min(100,bitterness * 1.3)
	new.sweetness = sweetness * 0.35
	new.fruity = fruity
	new.gazeous = gazeous
	return new
