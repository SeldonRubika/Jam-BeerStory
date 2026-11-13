extends Resource

class_name IngredientResource
@export_category("information")
@export var ingredient_name := "Pomme"
@export var icon : Texture2D = preload("res://icon.svg")
@export var desc :="Le type de bière pour lesquelles mathis se fait ban du camel"
var text_color : Color = [Color.YELLOW,Color.RED,Color.SKY_BLUE,Color.GREEN_YELLOW,Color.ORANGE].pick_random()

@export_category("Stats")
@export var type : Global.IngredientsTypes = Global.IngredientsTypes.Fruit
@export_range(0,10) var bitterness := 0
@export_range(0,10) var sweetness := 0
@export var fruity := false
@export var gazeous := false
