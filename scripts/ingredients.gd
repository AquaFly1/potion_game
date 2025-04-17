# Element.gd
extends Resource
class_name Ingredient  # this makes it show up in the Create Resource menu

@export var name: String
@export var card_sprite: Texture2D
@export var description: String
@export var reaction_rules: Dictionary = {}
