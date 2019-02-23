class_name Item


enum ItemTypes {
	WEAPON_MELEE,
	WEAPON_RANGED,
	CONSUMEABLE,
	TOME
}

static func get_type_from_name(itemTypeName : String):
	match (itemTypeName):
		"WEAPON_MELEE":
			return ItemTypes.WEAPON_MELEE
		"WEAPON_RANGED":
			return ItemTypes.WEAPON_RANGED
		"CONSUMEABLE":
			return ItemTypes.CONSUMEABLE
		"TOME":
			return ItemTypes.TOME
		_:
			print("unkown item type!")
			return "UNKOWN_ITEM_TYPE"
	


	
	
var _id : int = -1
var _name : String
var _description : String
var _value : int
var _weight : float

var _textureRegion : Rect2
var _texturePath : String

# enums
var _type

# Dicts
var _effects
var _requirements

var _stackSize : int = 1
var _stackable : bool = false
var _usable : bool = false
var _discardable : bool = true
var _sellable : bool = true


func _init(id, name, type, weight, value, effects, requirements, description, texturePath, textureRegion, \
			stackSize, stackable = false,usable = false, discardable = true, sellable = true):
	_id = id
	_name = name
	_type = type
	_value = value
	_weight = weight
	_effects = effects
	_requirements = requirements
	_description = description
	_texturePath = texturePath
	_usable = usable
	_discardable = discardable
	_sellable = sellable
	_stackable = stackable
	_stackSize = stackSize
	_textureRegion = Rect2(textureRegion["x"], textureRegion["y"], textureRegion["w"], textureRegion["h"])
	
	
func get_id() -> int:
	return _id

func get_name() -> String:
	return _name
	
func get_type() -> int:
	return _type

func get_weight() -> float:
	return _weight
	
func get_value() -> int:
	return _value
	
func get_effects() -> Dictionary:
	return _effects

func get_requirements() -> Dictionary:
	return _requirements
	
func get_description() -> String:
	return _description
	
func get_texture_path() -> String:
	return _texturePath

func get_texture_region() -> Rect2:
	return _textureRegion
	
func get_stack_size() -> int:
	return _stackSize
	
func is_stackable() -> bool:
	return _stackable
	
func is_usable() -> bool:
	return _usable
	
func is_discardable() -> bool:
	return _discardable
	
func is_sellable() -> bool:
	return _sellable

