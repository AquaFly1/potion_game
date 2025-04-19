class_name HandManager
extends Control

@onready var arc: Path2D = $Path2D

var hand = []
var hovered_card: PathFollow2D

const HOVER_OFFSET: float = 100.0

func add_card_to_hand(card: CardBase) -> void:
	var path_follow: PathFollow2D = PathFollow2D.new()
	path_follow.loop = false
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
	update_arc()
	var is_before: bool = true
	var before: Array[PathFollow2D]
	var after: Array[PathFollow2D]
	
	for child: PathFollow2D in arc.get_children():
		if child.get_child(0) == card:
			is_before = false
			hovered_card = child
		else:
			if is_before:
				before.append(child)
			else:
				after.append(child)
	
	for path: PathFollow2D in before:
		path.progress -= HOVER_OFFSET
	for path: PathFollow2D in after:
		path.progress += HOVER_OFFSET
