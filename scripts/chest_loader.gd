extends Node2D

#const InventoryPrefab = preload("res://scenes/Inventory.tscn")
const InventorySystem = preload("res://scripts/inventory/InventorySystem.gd")

export(NodePath) var mainInventorySystem = null

var _mainInv : InventorySystem = null
var openedInv

func _ready():
	if mainInventorySystem == null and get_tree().get_current_scene().get_name() != "MainServer":
		printerr("no inventory selected!")

	for i in range(get_child_count()):
		get_child(i).connect("on_area_entered", self, "add_to_main_inventory")
		get_child(i).connect("on_area_exited", self, "remove_inventories")


func init(inventorySystemPath):
	if get_tree().get_current_scene().get_name() != "MainServer":
		_mainInv = get_node(inventorySystemPath + "inventorySystem")
		if _mainInv == null:
			get_node("/root/Console/console").error("couldn't find inventory!")

		_mainInv.connect("on_item_inventory_swapped", self, "save_items")


func save_items(inv1, inv2):
	get_node("/root/Console/console").write_line("saving items...")
#	if inv1.get_id() == openedInv.get_id():
#		for i in range(inv1._slots.size()):
#			openedInv._slots[i] = inv1._slots[i] 
#			if inv1._slots[i]._item != null:
#				get_node("/root/Console").write_line(inv1._slots[i]._item.get_name())
#	elif inv2.get_id() == openedInv.get_id():
#		for i in range(inv2._slots.size()):
#			openedInv._slots[i] = inv2._slots[i] 
#			if inv2._slots[i]._item != null:
#				get_node("/root/Console").write_line(inv2._slots[i]._item.get_name())

#	for i in range(openedInvs.size()):
#		if inv == openedInvs[i].get_id() or targetInv == openedInvs[i].get_id():
#			get_node(openedInvs[i].name)._slots = openedInvs[i]._slots
#			get_node("/root/Console").write_line("found and saved")
#			break

func add_to_main_inventory(invName, inventory):
	openedInv = inventory
	openedInv.show()
	get_node("/root/Console/console").write_line("test adding inventory")
	inventory._set_id(_mainInv.add_inventory(inventory))

func remove_inventories(invName):
	openedInv.hide()
	_mainInv.remove_all_except_main_inventory()
	get_node("/root/Console/console").write_line("remove inventories")









