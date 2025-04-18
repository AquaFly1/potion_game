extends Button

class_name CardBase

@onready var card_spr: TextureRect = $button/card
@onready var card: CardBase = $"."
@onready var animations: AnimationPlayer = $Animations

@export var ingredient_data: Ingredient

signal card_selected(card)

var is_face_down: bool

func _ready() -> void:
	card_selected.emit(self)
	card_spr.texture = ingredient_data.card_sprite
	is_face_down = true
	set_to_face_down()

func play_card():
	pass

func _on_pressed() -> void:
	card_selected.emit(self)

func set_to_face_down() -> void:
	pass

func set_to_face_up() -> void:
	if is_face_down:
		animations.play("flip_face_up")
	is_face_down = false
