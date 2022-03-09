extends Node2D

var _dialogStructure

export(String) var fileName="1"
export(int) var idStart=0
export(int) var idExit=99

var dialogs = null
var rows = null

onready var boxDialog = get_node("boxDialog/Container")

func _ready():
	_dialogStructure = load("res://class/dialog.tres")
	loadDialog()
	
	_dialogStructure.connect("updateDialog",self,"updateDialog")
	
func loadDialog():
	var file = File.new()
	var pathFileName = "res://data/" + str(fileName) + ".json"
	#var foundFile = file.file_exists(pathFileName)
	if file.file_exists(pathFileName) :
		file.open(pathFileName, file.READ)
		var content = file.get_as_text()
		dialogs = JSON.parse(content).result
		_dialogStructure.init(dialogs,idStart,idExit)
		rows = _dialogStructure
		#print(dialogs)
		file.close()
	else:
		print('file not found :' + pathFileName)
		dialogs = null

func updateDialog():
	boxDialog.get_node("title").text = rows.title
	boxDialog.get_node("message").text = rows.message
	pass
