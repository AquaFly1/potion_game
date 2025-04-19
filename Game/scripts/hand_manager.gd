class_name HandManager
extends Control

@onready var arc: Path2D = $Path2D

var hand = []
var hovered_card: PathFollow2D

func add_card_to_hand(card: CardBase) -> void:
	var path_follow: PathFollow2D = PathFollow2D.new()
	arc.add_child(path_follow)
	path_follow.add_child(card)
	hand.append(card)
	path_follow.v_offset = -100
	update_arc()

func update_arc() -> void:
	var card_count: int = arc.get_child_count()
	var gap_ratio: float = 1.0 / float(card_count)
	for i in range(card_count):
		arc.get_child(i).progress_ratio = gap_ratio * i

func hover_card(card: CardBase) -> void:
	for child: PathFollow2D in get_child(0).get_children():
		if child.get_child(0) == card:
			hovered_card = child
			hover_animation()

func hover_animation() -> void:
	pass
