extends IngredientResource
class_name DrinkResource

@export_group("Stats")
@export var types : Global.DrinkTypes = Global.DrinkTypes.Fermented
##0-3, mixing a tier 3 makes it shitty
@export var shitty := false
@export_range(0,4) var mix_level := 0
@export_range(0,100) var degrees := 0

func GetDistilledResource():
	var new = DrinkResource.new()
	new.base = ingredient_name
	if fruity :
		new.ingredient_name = "Eau-de-vie de " + ingredient_name
		new.desc = "Eau-de-vie très nutritif fait à partir de " + ingredient_name + "."
	else :
		new.ingredient_name = "Spiritueux de " + ingredient_name
		new.desc = "Spiritueux très nutritif fait à partir de " + ingredient_name + "."
	new.type = Global.IngredientsTypes.Liquid
	new.types = Global.DrinkTypes.Distillied
	new.bitterness = bitterness * 1.1
	new.sweetness = sweetness * 1.5
	new.degrees = degrees * 1.5
	new.fruity = fruity
	new.gazeous = gazeous
	return new
	
func GetCombinedResource(ingredient : DrinkResource):
	# self est forcément une boisson, ingredient par contre peut être liquide ou autre
	var new = DrinkResource.new()
	new.base = ingredient_name
	
	if fruity :
		new.ingredient_name = "Eau-de-vie de " + ingredient_name
		new.desc = "Eau-de-vie très nutritif fait à partir de " + ingredient_name + "."
	elif fruity:
		new.ingredient_name = "Spiritueux de " + ingredient_name
		new.desc = "Spiritueux très nutritif fait à partir de " + ingredient_name + "."
		
	new.type = Global.IngredientsTypes.Liquid
	
	if ingredient.type != Global.IngredientsTypes.Liquid :
		# Si c'est une Liqueur (liquide + ingrédient pas liquide)
		new.types = Global.DrinkTypes.Liquor
		new.sweetness = (sweetness * 0.8) + (ingredient.sweetness * 0.2) 
		new.bitterness = (bitterness * 0.8) + (ingredient.bitterness * 0.2) 
		new.degrees = degrees
		new.fruity = (fruity or ingredient.fruity)
		new.gazeous = (gazeous or ingredient.gazeous)
		return new
	else :
		# Si c'est un Cocktail (liquide + liquide)
		new.types = Global.DrinkTypes.Cocktail
		new.sweetness = (sweetness + ingredient.sweetness) * 0.5
		new.bitterness = (bitterness + ingredient.bitterness) * 0.5
		new.degrees = (degrees + ingredient.begrees) * 0.5
		new.fruity = (fruity or ingredient.fruity)
		new.gazeous = (gazeous or ingredient.gazeous)
		new.mix_level = min(4,mix_level + ingredient.mix_level + 1)
		if new.mix_level >= 4 :
			new.shitty = true
		else :
			new.shitty = (shitty or ingredient.shitty)
		return new
		
	
