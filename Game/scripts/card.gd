extends Control

class_name CardBase

@onready var card_spr: TextureRect = $button/card
@onready var card: CardBase = $"."

@export var ingredient_data: Ingredient

signal card_selected(card)

func _ready() -> void:
	emit_signal("card_selected", self)
	card_spr.texture = ingredient_data.card_sprite

func play_card():
	pass



func _on_button_pressed() -> void:
	emit_signal("card_selected", self)
