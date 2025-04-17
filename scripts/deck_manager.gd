extends Control

@onready var hand_ui: HBoxContainer = $hand_ui
@onready var deck_count: TextEdit = $deck_count

@export var hand_size: int = 3
@export var full_deck: Array[PackedScene] = []
@onready var cards_in_hand: Label = $cards_in_hand

var hand: Array[CardBase] = []
var current_card: CardBase = null
var SparkRock = preload("res://scenes/SparkRock.tscn")
var heartstone = preload("res://scenes/heartstone.tscn")
var deck: Array[PackedScene] = []


func _ready():
	if hand_ui != null:
		full_deck = [
			SparkRock, SparkRock, SparkRock, SparkRock,
			heartstone, heartstone, heartstone
		]
		deck = full_deck.duplicate()
		shuffle_deck()
		draw_cards(3)

func draw_cards(count: int):
	for i in range(count):
		if deck.size() > 0:
			if hand.size() < hand_size:
				var card_scene = deck.pop_back()
				var card_instance = card_scene.instantiate()
				card_instance.connect("card_selected", Callable(self, "_on_card_selected"))
				hand.append(card_instance)
				hand_ui.add_child(card_instance)
				current_card = null
		else:
			deck = full_deck.duplicate()
			shuffle_deck()
			var card_scene = deck.pop_back()
			var card_instance = card_scene.instantiate()
			card_instance.connect("card_selected", Callable(self, "_on_card_selected"))
			hand.append(card_instance)
			hand_ui.add_child(card_instance)
			current_card = null
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
