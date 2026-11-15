extends Resource
class_name DiscussionBase

@export var discussion_name := "Tutoriel"
@export var characters : Array[String]= ["Frédérique"]
##Array of Array of Strings
@export var dialogs :Array[Array]= [["Frédérique","Bonjour"],["Frédérique","Je suis le GOAT"]]

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
@export var required_type : Global.DrinkTypes
## 1 asks for only one thing 2 for two and so on
@export_range(1,6) var difficulty : int = 1
