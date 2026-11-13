extends Resource
class_name DrinkResource

@export_group("Information")
@export var drink_name := "Bière classique"
@export var icon : Texture2D
@export var desc :="Le type de bière pour lesquelles mathis se fait ban du camel"
var text_color : Color = [Color.YELLOW,Color.RED,Color.SKY_BLUE,Color.GREEN_YELLOW,Color.ORANGE].pick_random()

@export_group("Stats")
@export var types : Global.DrinkTypes = Global.DrinkTypes.Fermented
##0-3, mixing a tier 3 makes it shitty
@export var shitty := false
@export_range(0,3) var mix_level := 0
@export_range(0,100) var degrees := 0
@export_range(0,10) var bitterness := 0
@export_range(0,10) var sweetness := 0
@export var fruity := false
@export var gazeous := false
