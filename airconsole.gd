extends Node
class_name AirConsole

signal onMessage(device_id, data)
signal onConnect(device_id)
signal onDisconnect(device_id)
signal onActivePlayersChange(player_number)

var _airconsole: JavaScriptObject
var _callbacks: Array = []
var ready: bool = false

func _create_cb(f: String):
	var cb = JavaScript.create_callback(self, f)
	_callbacks.append(cb)
	return cb
	
func _init():
	if OS.get_name() != "HTML5":
		print("can't load airconsole, not on a HTML environment")
		return

	JavaScript.eval("airconsole = new AirConsole({device_motion: 50})")
	_airconsole = JavaScript.get_interface("airconsole")

	_connect_callbacks()
	print_debug("AirConsole initialized")
	ready = true

#functions
func set_active_players(max_players: int):
	_airconsole.setActivePlayers(max_players)

func convert_device_id_to_player_number(device_id: int):
	return int(_airconsole.convertDeviceIdToPlayerNumber(device_id))

func convert_player_number_to_device_id(player_id: int):
	return int(_airconsole.convertPlayerNumberToDeviceId(player_id))

func message(device_id: int, data):
	_airconsole.message(device_id, data)

#callbacks
func _connect_callbacks():
	_airconsole.onMessage = _create_cb("_onMessage")
	_airconsole.onConnect = _create_cb("_onConnect")
	_airconsole.onDisconnect = _create_cb("_onDisconnect")
	_airconsole.onActivePlayersChange = _create_cb("_onActivePlayersChange")
	_airconsole.onDeviceMotion = _create_cb("_onDeviceMotion")

func _onMessage(args):
	emit_signal("onMessage", args[0], args[1])

func _onConnect(device_id):
	emit_signal("onConnect", device_id)

func _onDisconnect(device_id):
	emit_signal("onDisconnect", device_id)

func _onActivePlayersChange(player_number):
	emit_signal("onActivePlayersChange", player_number)

func _onDeviceMotion(data):
	print(data)
