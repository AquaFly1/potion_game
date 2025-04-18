extends Control

@onready var hand_ui: HandManager = $hand_ui
@onready var deck_count: TextEdit = $deck_count

@export var hand_size: int = 5
@onready var cards_in_hand: Label = $cards_in_hand

var card_scene = preload("res://scenes/Card.tscn")

var hand: Array[CardBase]
var current_card: CardBase = null
var deck: Array[Ingredient]


func _ready():
	if hand_ui != null:
		deck = Ingredients.full_deck.duplicate(true)
		shuffle_deck()
		draw_cards(hand_size)

func draw_cards(count: int):
	for i in range(count):
		if deck.size() > 0:
			if hand.size() < hand_size:
				await draw_card()
		else:
			deck = Ingredients.full_deck.duplicate(true)
			shuffle_deck()
			await draw_card()

func draw_card() -> void:
	var ingredient: Ingredient = deck.pop_back()
	var card_instance: CardBase = card_scene.instantiate()
	
	card_instance.card_selected.connect(_on_card_selected)
	hand.append(card_instance)
	hand_ui.add_card_to_hand(card_instance)
	current_card = null
	card_instance.load_card(ingredient)
	
	await card_instance.draw_card()
	return

func shuffle_deck():
	deck.shuffle()

func _on_button_pressed():
	draw_cards(1)

func _process(delta: float) -> void:
	if hand_ui != null:
		cards_in_hand.text = (str(hand.size())+ "/"+ str(hand_size))
		deck_count.text = str(deck.size())
	if Input.is_action_just_pressed("debug"):
		print(current_card)

func _on_discard_pressed() -> void:
	if hand.size() > 0:
		for i in range(hand.size()-1, -1, -1):
			if hand[i] == current_card:
				var card = hand.pop_at(i)
				hand_ui.remove_child(card)
				draw_cards(1)

func _on_card_selected(card):
	current_card = card

func _on_play_card_pressed() -> void:
	pass # Replace with function body.
