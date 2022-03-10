extends Node2D

var title:String = ""
var actor:Image= null
var message:String=""
var back:String=""
var next:String=""
var exit:String=""


#var _dialogStructure

var _dialogs={}
var _dialog={}
var _choice={}
var _choice_list=[]

export(String) var fileName="1"
export(String) var idStart="0"
export(String) var idExit="99"


var score:int = 0

#var dialogs = null
#var rows = null

onready var boxDialog = get_node("boxDialog/CenterContainer/Container")

func _ready():
	#_dialogStructure = load("res://class/dialog.tres")
	loadDialog()
	
	#_dialogStructure.connect("updateDialog",self,"updateDialog")
	
func loadDialog():
	score=0
	get_node("score").text = str(score)
	
	var file = File.new()
	var pathFileName = "res://data/" + str(fileName) + ".json"
	#var foundFile = file.file_exists(pathFileName)
	if file.file_exists(pathFileName) :
		file.open(pathFileName, file.READ)
		var content = file.get_as_text()
		_dialogs = JSON.parse(content).result
		getProfile()
		getDialog(str(idStart))
		updateDialog()
		#_dialogStructure.init(dialogs,idStart,idExit)
		#print(dialogs)
		file.close()
	else:
		print('file not found :' + pathFileName)
		_dialogs = {}

func getProfile():
	if _dialogs.has("profile"):
		_dialog = _dialogs["profile"]
		title = hasDialog("title")
		#actor = hasDialog("actor")
	else:
		title="ไม่ระบุ?"
		
func getDialog(id:String):
	if _dialogs.has(str(id)):
		_dialog = _dialogs[str(id)]
		message = hasDialog("message")
		var _next = hasDialog("next")
		if _next != "self":
			next = _next
		
		print(next)
		
		back = hasDialog("back")
		exit = hasDialog("exit")
		_choice = hasDialog("choice",{})
		clearChoice()
		if _choice.size()>0:
			#print(_choice)
			for key in _choice:
				if _choice[key].has("label"):
					var label = _choice[key]["label"]
					addChoice(key,label)
		
		#func
		if _dialog.has("func"): 
			var _func = _dialog["func"]
			call(_func)
		
	#else:
	#	_dialog={}
	#	title = hasDialog("title")
	#	message = hasDialog("message")
	#	next = hasDialog("next")
	#	back = hasDialog("back")
	#	exit = hasDialog("exit")
func clearChoice():
	for node in _choice_list:
		node.queue_free()
	_choice_list=[]

func addChoice(key,label):
	var btn = Button.new()
	var font = load("res://fonts/f16t.tres")
	btn.set("custom_fonts/font",font)
	btn.text = str(label) 
	btn.connect("pressed",self,"onChoicePressed",[key])
	_choice_list.append(btn)
	boxDialog.get_node("boxChoice/container").add_child(btn)

func onChoicePressed(key):
	#print(key)
	next = str(key)
	Next()
	

func correct():
	score+=1
	get_node("score").text = str(score)
	pass

func Next():
	getDialog(str(next))
	updateDialog()
	
func Back():
	getDialog(str(back))
	updateDialog()

func Exit():
	getDialog(str(exit))
	updateDialog()

func hasDialog(name,default=""):
	if _dialog.has(name):
		return _dialog[name]
	return default

func updateDialog():
	boxDialog.get_node("title").text = title
	boxDialog.get_node("message").text = message
	pass
