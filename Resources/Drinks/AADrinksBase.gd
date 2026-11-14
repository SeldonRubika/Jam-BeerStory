extends IngredientResource
class_name DrinkResource

@export_group("Stats")
@export var types : Global.DrinkTypes = Global.DrinkTypes.Fermented
##0-3, mixing a tier 3 makes it shitty
@export var shitty := false
@export_range(0,4) var mix_level := 0
@export_range(0,100) var degrees := 0
