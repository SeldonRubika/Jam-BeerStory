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
	new.base = base
	if fruity :
		if new.base[0] in "AEIOUY" : 
			new.ingredient_name = "Eau-de-vie d'" + new.base
			new.desc = "Eau-de-vie très nutritive fait à partir d'" + new.base + "."
		else : 
			new.ingredient_name = "Eau-de-vie de " + new.base
			new.desc = "Eau-de-vie très nutritive fait à partir de " + new.base + "."
	else :
		if new.base[0] in "AEIOUY" : 
			new.ingredient_name = "Spiritueux d'" + new.base
			new.desc = "Spiritueux très nutritif fait à partir d' " + new.base + "."
		else :
			new.ingredient_name = "Spiritueux de" + new.base
			new.desc = "Spiritueux très nutritif fait à partir de" + new.base + "."
	new.type = Global.IngredientsTypes.Liquid
	new.types = Global.DrinkTypes.Distillied
	new.bitterness = min(100,bitterness * 1.1)
	new.sweetness = min(100,sweetness * 1.5)
	new.degrees = min(100, degrees * 1.5)
	new.fruity = fruity
	new.gazeous = gazeous
	return new
	
func GetCombinedResource(ingredient : IngredientResource):
	# self est forcément une boisson, ingredient par contre peut être liquide ou autre
	var new = DrinkResource.new()
	new.type = Global.IngredientsTypes.Liquid
	
	if ingredient.ingredient_name == "Sucre" and ingredient_name.contains("macéré"):
		new.base = base
		# Si c'est une Liqueur (liquide + ingrédient pas liquide)
		if new.base[0] in "AEIOUY" :
			new.base = base
			new.ingredient_name = "Liqueur d'" + base
			new.desc = "Liqueur faite à partir d'" + base + "."
		else :
			new.base = base
			new.ingredient_name = "Liqueur de " + base
			new.desc = "Liqueur faite à partir de " + base + "."
		
		new.types = Global.DrinkTypes.Liquor
		new.sweetness = min(100,(sweetness * 0.8) + (ingredient.sweetness * 0.2)) 
		new.bitterness = min(100,(bitterness * 0.8) + (ingredient.bitterness * 0.2)) 
		new.degrees = degrees
		new.fruity = (fruity or ingredient.fruity)
		new.gazeous = (gazeous or ingredient.gazeous)
		if new.mix_level >= 4 :
			new.shitty = true
		else :
			new.shitty = shitty
			if ingredient.type == Global.IngredientsTypes.Liquid:
				new.shitty = shitty or ingredient.shitty
		return new
		
	elif ingredient.ingredient_name == "Sucre" and not ingredient_name.contains("macéré"):
		new.degrees = degrees
		new.base = base
		new.ingredient_name = ingredient_name + " sucré"
		new.desc = desc
		new.type = type
		new.types = types
		new.bitterness = bitterness
		new.sweetness = min(100,sweetness + 20)
		new.fruity = fruity
		new.gazeous = gazeous
		if new.mix_level >= 4 :
			new.shitty = true
		else :
			new.shitty = (shitty or ingredient.shitty)
		return new
		
	if ingredient.ingredient_name == "Alcool pur" : 
		new.degrees = min(100,(degrees + 96) * 0.5)
		new.base = base
		new.ingredient_name = ingredient_name + " fort"
		new.desc = desc
		new.type = type
		new.types = types
		new.bitterness = bitterness
		new.sweetness = sweetness
		new.fruity = fruity
		new.gazeous = gazeous
		new.mix_level = mix_level + 1
		if new.mix_level >= 4 :
			new.shitty = true
		else :
			new.shitty = (shitty or ingredient.shitty)
		return new
		
	elif ingredient.ingredient_name == "Eau" : 
		new.degrees = degrees * 0.5
		new.base = base
		new.ingredient_name = ingredient_name + " dilué"
		new.desc = desc
		new.type = type
		new.types = types
		new.bitterness = bitterness
		new.sweetness = sweetness
		new.fruity = fruity
		new.gazeous = gazeous
		new.mix_level = mix_level + 1
		if new.mix_level >= 4 :
			new.shitty = true
		else :
			new.shitty = (shitty or ingredient.shitty)
		return new
		
	elif ingredient.ingredient_name == "Assucrite" : 
		new.degrees = degrees
		new.base = base
		new.ingredient_name = ingredient_name + " sec"
		new.desc = desc
		new.type = type
		new.types = types
		new.bitterness = bitterness
		new.sweetness = max(0,sweetness - 10)
		new.fruity = fruity
		new.gazeous = gazeous
		return new
		
	else :
		
		new.base = base
		
		if ingredient.type != Global.IngredientsTypes.Liquid or ingredient_name == "Alcool pur":
			# Si c'est une Liqueur (liquide + ingrédient pas liquide)
			if new.base[0] in "AEIOUY" :
				new.base = ingredient.ingredient_name
				new.ingredient_name =  ingredient.ingredient_name + " macéré"
				new.desc = "Base de liqueur faite à partir d'" + ingredient.ingredient_name + ". Il manque du sucre."
			else :
				new.base = ingredient.ingredient_name
				new.ingredient_name = ingredient.ingredient_name + " macéré"
				new.desc = "Base de liqueur faite à partir de " + ingredient.ingredient_name + ". Il manque du sucre."
			
			new.types = Global.DrinkTypes.Liquor
			new.sweetness = min(100,(sweetness * 0.8) + (ingredient.sweetness * 0.2)) 
			new.bitterness = min(100,(bitterness * 0.8) + (ingredient.bitterness * 0.2)) 
			new.degrees = degrees
			new.fruity = (fruity or ingredient.fruity)
			new.gazeous = (gazeous or ingredient.gazeous)
			new.shitty = true
			return new
			
		else :
			# Si c'est un Cocktail (liquide + liquide)
			new.ingredient_name = "Cocktail " + new.base + " " + ingredient.base
			new.desc = "Cocktail très nutritif."
			
			new.types = Global.DrinkTypes.Cocktail
			new.sweetness = min(100,(sweetness + ingredient.sweetness) * 0.5)
			new.bitterness = min(100,(bitterness + ingredient.bitterness) * 0.5)
			if new.type == Global.IngredientsTypes.Liquid:
				new.degrees = min(100,(degrees + ingredient.degrees) * 0.5)
			new.fruity = (fruity or ingredient.fruity)
			new.gazeous = (gazeous or ingredient.gazeous)
			new.mix_level = min(4,mix_level + ingredient.mix_level + 1)
			return new
		
	
