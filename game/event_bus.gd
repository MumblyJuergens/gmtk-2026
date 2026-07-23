extends Node

signal card_used(card_data: CardData)
signal card_discarded(card_data: CardData)
signal card_needed

signal timer_done_round
signal timer_done_card_use

signal stats_changed

func disconnect_all() -> void:
	_disconnect_all_on(card_used)
	_disconnect_all_on(card_discarded)
	_disconnect_all_on(card_needed)
	
	_disconnect_all_on(timer_done_round)
	_disconnect_all_on(timer_done_card_use)
	
	_disconnect_all_on(stats_changed)
	
func _disconnect_all_on(sig: Signal) -> void:
	for connection: Dictionary in sig.get_connections():
		var con: Callable = connection["callable"]
		sig.disconnect(con)
