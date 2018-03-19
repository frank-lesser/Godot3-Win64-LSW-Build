extends Node

# Steam library
var Steam_module = preload("res://bin/Steam.gdns");
onready var stream = Steam.new();								# create a SQLite instance

func _ready():

# add code ass described at https://gramps.github.io/GodotSteam