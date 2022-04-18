extends Node

signal onMessage(device_id, data)
signal onConnect(device_id)
signal onDisconnect(device_id)

var _airconsole: JavaScriptObject
var _cb_onMessage = JavaScript.create_callback(self, "_onMessage")
var _cb_onConnect = JavaScript.create_callback(self, "_onConnect")
var _cb_onDisconnect = JavaScript.create_callback(self, "_onDisconnect")

func _init():
	if OS.get_name() != "HTML5":
		print("can't load airconsole, not on a HTML environment")
		return

	_airconsole = JavaScript.create_object("AirConsole")
	_connect_callbacks()
	print_debug("Airconsole initialized")

func _connect_callbacks():
	_airconsole.onMessage = _cb_onMessage
	_airconsole.onConnect = _cb_onConnect
	_airconsole.onDisconnect = _cb_onDisconnect

func _onMessage(args):
	emit_signal("onMessage", args[0], args[1])

func _onConnect(device_id):
	emit_signal("onConnect", device_id)

func _onDisconnect(device_id):
	emit_signal("onDisconnect", device_id)
