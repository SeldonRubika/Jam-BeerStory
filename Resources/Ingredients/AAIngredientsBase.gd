extends Resource
class_name IngredientResource

@export_category("information")
@export var ingredient_name := "Pomme"
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
	match (ingredient_name):
		"Cactus":return load("uid://bokirk1ohqn0h")
	return load("uid://ch5hbfceu2m0h")

func GetFermentedResource():
	match (ingredient_name):
		"Eau":return load("uid://m1o0eubqv17j")
	return load("uid://c1wsgln1jh5kw")

func GetBroyageByproduct():
	match (ingredient_name):
		"":return
	return load("uid://ch5hbfceu2m0h")
