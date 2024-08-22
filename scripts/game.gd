extends Node2D

@onready var inventory_label = $CanvasLayer/BoxContainer/Label


func _on_player_inventory_updated(inventory):
	var inventory_string = "Inventory: "
	for item in inventory:
		inventory_string = str(inventory_string, "%s: %d, " % [item, inventory[item].amount])
	inventory_label.text = inventory_string
