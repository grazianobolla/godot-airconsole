# godot-airconsole
Airconsole API Interface for the Godot Engine

## Note: the plugin is missing many API calls, you can add them easely editing the airconsole.gd file, if you can't or encounter any problem, open an issue and I'll fix it.

## Instalation

- Download zip and extract inside addons/ folder on your Godot project
- Your path should look like this: `addons/godot-airconsole/`
- Go to the export settings for HTML5 and add `<script type="text/javascript" src="https://www.airconsole.com/api/airconsole-1.7.0.js"></script>` to the Head Include textbox
- Activate the plugin in the project config

## Usage

You can now add a new node called Airconsole to your scene, this node has multiple signals and functions, wich you can connect and call.

## Example Script

```gdscript
extends Node

func _ready():
  Airconsole.connect("onMessage", self, "_onMessage")

func _onMessage(device_id, data):
  #data will contain whatever you put on the controller.html
  if data.button_pressed == "attack":
    print("user pressed attack button")
  
```
