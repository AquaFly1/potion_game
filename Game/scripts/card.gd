extends Button

class_name CardBase

@onready var card_spr: TextureRect = $card
@onready var card: CardBase = $"."
@onready var flip_animations: AnimationPlayer = $flip_animations

@export var ingredient_data: Ingredient

signal card_selected(card)

var is_face_down: bool

func load_card(card: Ingredient) -> void:
	ingredient_data = card
	card_selected.emit(self)
	card_spr.texture = ingredient_data.card_sprite
	is_face_down = true
	set_to_face_down()
	
	draw_card()

func draw_card():
	print("Drawing ", ingredient_data.name, "...")
	set_to_face_up()

func play_card():
	pass

func _on_pressed() -> void:
	card_selected.emit(self)

func set_to_face_down() -> void:
	if not is_face_down:
		flip_animations.play("flip_face_down")
	is_face_down = true
	await flip_animations.animation_finished
	return

func set_to_face_up() -> void:
	if is_face_down:
		flip_animations.play("flip_face_up")
	is_face_down = false
	await flip_animations.animation_finished
	return
