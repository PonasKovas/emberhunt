"""

"""
extends Control

onready var debugLabel = $CanvasLayer/debugLabel 
onready var fpsLabel = $CanvasLayer/FPS

export(NodePath) var playerNode = "../YSort/player"

onready var inventorySystem = $CanvasLayer/inventorySystem
var playerBody : KinematicBody2D = null

func _ready():
	set_process_input(true)
	inventorySystem.hide()
	playerBody = get_node("../YSort/player")
	
	$CanvasLayer/moveButton.init(playerBody)
	$CanvasLayer/shootButton.init(playerBody.get_node("weapon"))


func _input(event):
	if event is InputEventKey and event.scancode == KEY_I and event.is_pressed() and not event.echo:
		_on_toggleInventory_pressed()
		
		
func _process(delta):
	debugLabel.set_text(str(playerBody.get_position()))
	if delta != 0:
		fpsLabel.set_text("FPS: "+str(round(1/delta)))
	

func _on_TouchScreenButton_pressed():
	if not Global.paused:
		Global.paused = true
		SoundPlayer.play(preload("res://assets/sounds/click.wav"))
		var scene = preload("res://scenes/PauseMenu.tscn")
		var scene_instance = scene.instance()
		scene_instance.set_name("PauseMenu")
		$CanvasLayer.add_child(scene_instance)
		# disable touchads
		setTouchpadsState(false)


func _on_toggleInventory_pressed():
	if not Global.paused:
		inventorySystem.visible = ! inventorySystem.visible
		# Disable/Enable touchpads and stuff
		setTouchpadsState(!inventorySystem.visible)


func setTouchpadsState(state):
	get_node("CanvasLayer/moveButton").disabled = !state
	get_node("CanvasLayer/moveButton").isPressed = false
	get_node("CanvasLayer/moveButton")._playerBody.direction = 0
	get_node("CanvasLayer/moveButton")._playerBody.speed = 0
	get_node("CanvasLayer/moveButton/buttonSprite").hide()
	get_node("CanvasLayer/moveButton/background").hide()
	get_node("CanvasLayer/shootButton").disabled = !state
	get_node("CanvasLayer/shootButton").isPressed = false
	get_node("CanvasLayer/shootButton")._weaponNode.rotation = 0
	get_node("CanvasLayer/shootButton")._weaponNode.attacking = false
	get_node("CanvasLayer/shootButton/buttonSprite").hide()
	get_node("CanvasLayer/shootButton/background").hide()