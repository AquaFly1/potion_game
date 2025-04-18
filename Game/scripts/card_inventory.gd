extends Node

@export var ingredients: Array[Ingredient]
@export var full_deck: Array[Ingredient]

func get_ingredient_from_name(ingredient_name: String) -> Ingredient:
	for ingredient in ingredients:
		if ingredient.name == ingredient_name:
			return ingredient
	return null
