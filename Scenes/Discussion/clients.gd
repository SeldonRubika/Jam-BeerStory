extends DrinkSubMenu

@export var proposition: TextureButton
var proposition_awaiting := false
@export var drink_name: AutoSizeLabel
@export var drink_price_range: AutoSizeRichTextLabel
@export var request : DiscussionBase
const INIT_TEXT := ["Je reviens d'un donjon et je suis assoifé.\n","Je sais ce que je veux.\n","Je meurs de soif !\n","JE VEUX À BOIRE !\n","Hé ! Tavernier ! Par ici !\n","Voyons voir ce que tu sais faire.\n","C'est sympa par ici !\n"]
@export var dialog_text: AutoSizeRichTextLabel
@export var dialog: Button

func make_new_request():
	var request_text = INIT_TEXT.pick_random()
	request_text += "Servez-moi une boisson "
	var bonus_text = ""
	request = DiscussionBase.new()
	request.difficulty = RandomNumberGenerator.new().rand_weighted([1.5,2.5,1.3,1,.5])+1
	var available_param = ["bitterness","type","sweetness","degrees","fruity","gazeous"]
	for i in range(request.difficulty):
		var param = available_param.pick_random()
		available_param.erase(param)
		var value = round_to_five(randi_range(0,100))
		match param:
			"bitterness": 
				request.bitterness_required = value
				match value:
					5: request_text += "pas amère "
					15: request_text += "très légérement amère "
					25: request_text += "légèrement amère "
					35: request_text += "un peu amère "
					45: request_text += "assez amère "
					55: request_text += "bien amère "
					65: request_text += "très amère "
					75: request_text += "super amère "
					85: bonus_text += "je veux avoir l'impression de bouffer un citron "
					95: request_text += "la plus amère possible "
			"sweetness": 
				request.sweetness_required = value
				match value:
					5: request_text += "pas sucrée "
					15: request_text += "très légérement sucrée "
					25: request_text += "légèrement sucrée "
					35: request_text += "un peu sucrée "
					45: request_text += "assez sucrée "
					55: request_text += "bien sucrée "
					65: request_text += "très sucrée "
					75: request_text += "super sucrée "
					85: bonus_text += "avec du sucre solide "
					95: request_text += "la plus sucrée possible "
			"degrees": 
				request.degrees_required = value
				match value:
					5: request_text += "très peu alcoolisée "
					15: request_text += "légèrement alcoolisée "
					25: request_text += "pas mal alcoolisée "
					35: request_text += "bien alcoolisée "
					45: request_text += "très alcoolisée "
					55: request_text += "super alcoolisée "
					65: request_text += "extrêmement alcolisée "
					75: request_text += "incroyablement alcoolisée "
					85: bonus_text += "et je veux me mettre une race du diable "
					95: request_text += "avec le plus d'alcool possible "
			"fruity": 
				if randi_range(0,1) == 1:
					request.fruity_required = 1
					request_text += "fruitée "
				else:
					request.fruity_required = -1
					request_text += "pas fruitée "
			"gazeous": 
				if randi_range(0,1) == 1:
					request.gazeous_required = 1
					request_text += "pétillante "
				else:
					request.gazeous_required = -1
					request_text += "pas pétillante "
			"type":
				value = randi_range(0,Global.DrinkTypes.size()-1) as Global.DrinkTypes
				request.required_type = value
				match value:
					1:bonus_text+="fermentée "
					2:bonus_text+="distillié "
					3:bonus_text+="une liqueur serait bien "
					4:bonus_text+="un cocktail serait bien "
	request_text += bonus_text
	dialog_text.text = request_text
	dialog_text.do_resize_text()

func round_to_five(x:float):
	var value = int(ceil(x/5.0)*5)
	if value %10:
		value = max(5,value-5)
	return value

func _on_proposition_pressed() -> void:
	var child := proposition.get_child(0)
	if (!child.resource):
		if !Global.selected_ingredients:
			return
		if ( Global.selected_ingredients.resource.type != Global.IngredientsTypes.Liquid):
			return
		child.resource = Global.selected_ingredients.resource
		child.set_self_ui()
		drink_name.text = child.resource.ingredient_name
		drink_price_range.text = "%s-%s"%[int(request.GetRange(child.resource)[0]),int(request.GetRange(child.resource)[1])]+" [img=32]uid://sgw4lkj675vg[/img]"
		Global.selected_ingredients.resource = null
		Global.selected_ingredients.set_self_ui()
		Global.selected_ingredients = null
	else:
		var cell : IngredientBase = Global.GetFirstInventoryEmptyCell()
		cell.resource = child.resource
		cell.set_self_ui()
		child.resource = null
		child.set_self_ui()
		proposition.disabled = true
		drink_name.text = "No Drinks"
		drink_price_range.text = "0-0 [img=32]uid://sgw4lkj675vg[/img]"
	drink_name.do_resize_text()
	drink_price_range.do_resize_text()

func _ready() -> void:
	make_new_request()

func complete_request(drink:DrinkResource):
	var reward = request.GetReward(drink)
	var success_rate = request.GetSuccess(drink)
	if success_rate < 10:
		dialog_text.text = "*Vomit sur le comptoir*"
	elif success_rate < 25:
		dialog_text.text = "Mais ?! C'est de la merde"
	elif success_rate < 35:
		dialog_text.text = "Y a un goût étrange non?"
	elif success_rate < 55:
		dialog_text.text = "Mouais ça passe"
	elif success_rate < 80:
		dialog_text.text = "Ouais pas mal"
	elif success_rate < 99:
		dialog_text.text = "Je t'aime, embrasse moi"
	else:
		dialog_text.text = "*Gémit de bonheur et pleure sur le poulet*"
	dialog_text.text +=" tient, %s d'or"%int(reward)
	dialog_text.do_resize_text()
	await dialog.pressed
	make_new_request()

func ingredient_selected():
	if proposition.get_child(0).resource == null:
		proposition_awaiting = false
		proposition.disabled = proposition_awaiting


func _on_sell_pressed() -> void:
	var child := proposition.get_child(0)
	complete_request(child.resource)
	child.resource = null
	child.set_self_ui()
	proposition.disabled = true
	drink_name.text = "No Drinks"
	drink_name.do_resize_text()
