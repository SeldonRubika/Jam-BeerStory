extends Resource
class_name DiscussionBase

@export var discussion_name := ""
@export var characters : Array[String]
##Array of Array of Strings
@export var dialogs :Array[Array]

##first one is for the first character in characters
@export var character_icons : Array[Texture2D]= []

@export_category("Requirements")
##-1 if it doesn't matter
@export var degrees_required := -1
@export var bitterness_required := -1
@export var sweetness_required := -1
## -1 if they want the drinks to NOT be of the thing
@export var fruity_required := 0
@export var gazeous_required := 0
@export var required_type : Global.DrinkTypes = Global.DrinkTypes.Softs
## 1 asks for only one thing 2 for two and so on
@export_range(1,6) var difficulty : int = 1

func GetRange(drink:DrinkResource):
	var reward = GetReward(drink)
	return [reward-(randi_range(0,int(reward*0.1))),reward+(randi_range(0,int(reward*0.1)))]

func GetReward(drink:DrinkResource):
	var success_rate = GetSuccess(drink)
	var base_reward := 0.0
	match difficulty:
		1: base_reward = 20
		2: base_reward = 50
		3: base_reward = 100
		4: base_reward = 180
		5: base_reward = 320
		6: base_reward = 500
	if success_rate <10:
		base_reward *= 0
	elif success_rate <20:
		base_reward *= .1
	elif success_rate <30:
		base_reward *= .15
	elif success_rate <40:
		base_reward *= .25
	elif success_rate <50:
		base_reward *= .35
	elif success_rate <60:
		base_reward *= .5
	elif success_rate <70:
		base_reward *= .6
	elif success_rate <80:
		base_reward *= .75
	else:
		base_reward *= 1.1
	return base_reward

func GetSuccess(drink:DrinkResource):
	var success = 0
	for param in [degrees_required,bitterness_required,sweetness_required]:
		if param == -1:
			success += 100
		else:
			var difference := 0
			match param:
				degrees_required: difference = abs(degrees_required-drink.degrees)
				bitterness_required: difference = abs(bitterness_required-drink.bitterness)
				sweetness_required: difference = abs(sweetness_required-drink.sweetness)
			if difference <5:
				success += 100
			elif difference <15:
				success += 50
	if (fruity_required ==0) or ( fruity_required == 1 and drink.fruity) or (fruity_required ==-1 and !drink.fruity):
		success+=100
	if (gazeous_required ==0) or ( gazeous_required == 1 and drink.gazeous)or (gazeous_required ==-1 and !drink.gazeous):
		success+=100
	if drink.types == required_type or required_type == Global.DrinkTypes.Softs:
		success += 100
	print(success)
	return success * 0.166 #division par 6 (y à 6 critères)
