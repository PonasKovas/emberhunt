# Copyright 2019 Emberhunt Team
# https://github.com/emberhunt
# Licensed under the GNU General Public License v3.0 or later
# SPDX-License-Identifier: GPL-3.0-or-later

extends Control


func _on_Nickname_text_changed(new_text):
	# First of all, make sure that the entered nickname is alphanumeric
	var old_caret_pos = get_node("Nickname").get_cursor_position()
	var regex = RegEx.new()
	regex.compile("[^a-zA-Z0-9_]")
	var amount_of_non_alphanumerical_chars = regex.search_all(new_text).size()
	new_text = regex.sub(new_text, "", true)
	get_node("Nickname").text = new_text
	get_node("Nickname").set_cursor_position(old_caret_pos-amount_of_non_alphanumerical_chars)
	
	get_node("NicknameError").visible = false
	if new_text != "":
		get_node("UUID").set_editable(false)
		get_node("TextureButton").set_disabled(false)
		get_node("TextureButton/Label").set("custom_colors/font_color",Color(1,1,1))
	else:
		get_node("UUID").set_editable(true)
		get_node("TextureButton").set_disabled(true)
		get_node("TextureButton/Label").set("custom_colors/font_color",Color(0.6431372549,0.6431372549,0.6431372549))


func _on_UUID_text_changed(new_text):
	if new_text != "":
		get_node("Nickname").set_editable(false)
		if new_text.length() == 24:
			get_node("TextureButton").set_disabled(false)
			get_node("TextureButton/Label").set("custom_colors/font_color",Color(1,1,1))
		else:
			get_node("TextureButton").set_disabled(true)
			get_node("TextureButton/Label").set("custom_colors/font_color",Color(0.6431372549,0.6431372549,0.6431372549))
	else:
		get_node("Nickname").set_editable(true)
		get_node("TextureButton").set_disabled(true)
		get_node("TextureButton/Label").set("custom_colors/font_color",Color(0.6431372549,0.6431372549,0.6431372549))


func _on_TextureButton_pressed():
	# Disable both text fields until the answer from server arrives
	get_node("Nickname").set_editable(false)
	get_node("TextureButton").set_disabled(true)
	# Check which value was entered
	if get_node("Nickname").get_text() != "":
		# Nickname was entered
		# Ask server if this nickname is taken
		Networking.askServerIfThisNicknameIsFree(get_node("Nickname").get_text())
	else:
		# UUID was entered
		# Send this UUID to the server
		Networking.askServerIfThisUUIDIsValid(get_node("UUID").get_text())

func receivedAnswerIfNicknameIsFree(answer):
	if not answer:
		get_node("Nickname").set_editable(true)
		get_node("NicknameError").visible = true
	else:
		Networking.registerAccount(get_node("Nickname").get_text())
		queue_free()

func receivedAnswerIfUUIDIsValid(answer):
	if not answer:
		get_node("UUID").set_editable(true)
		get_node("UUIDError").visible = true
	else:
		Global.UUID = get_node("UUID").get_text()
		Global.saveGame()
		queue_free()