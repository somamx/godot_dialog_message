extends Node2D

var title:String = ""
var actor:Image= null
var messageArray:Array=[]
var message:String=""
var msgIndex:int=0
var back:String=""
var next:String=""

var _start = ""


var _dialogs={}
var _dialog={}
var _choice={}
var _choice_list=[]

export(String) var fileName="1"

var score:int = 0

onready var boxDialog = get_node("boxDialog/CenterContainer/Container")

func _ready():
	#_dialogStructure = load("res://class/dialog.tres")
	loadDialog()
	
	#_dialogStructure.connect("updateDialog",self,"updateDialog")
	
func loadDialog():
	var file = File.new()
	var pathFileName = "res://data/" + str(fileName) + ".json"
	#var foundFile = file.file_exists(pathFileName)
	if file.file_exists(pathFileName) :
		file.open(pathFileName, file.READ)
		var content = file.get_as_text()
		_dialogs = JSON.parse(content).result
		getProfile()
		#getDialog(str(idStart))
		updateDialog()
		#_dialogStructure.init(dialogs,idStart,idExit)
		#print(dialogs)
		file.close()
	else:
		print('file not found :' + pathFileName)
		_dialogs = {}

func getProfile():
	
	score=0
	get_node("score").text = str(score)
	
	if _dialogs.has("profile"):
		_dialog = _dialogs["profile"]
		title = hasDialog("title")
		_start=hasDialog("start")
		getDialog(_start)
		#actor = hasDialog("actor")
	else:
		title="ไม่ระบุ?"
		
func getDialog(id:String):
	if _dialogs.has(str(id)):
		messageArray=[]
		msgIndex=0
		_dialog = _dialogs[str(id)]
		var _message = hasDialog("message")
		if typeof(_message) == TYPE_ARRAY:
			#print(_message)
			messageArray = _message
			message = messageArray[msgIndex]
		else:
			message = _message
		next = hasDialog("next")
		back = hasDialog("back")
		
		_choice = hasDialog("choice",{})
		clearChoice()
		if _choice.size()>0:
			#print(_choice)
			for key in _choice:
				print(key)
				var label=""
				var _func=""
				if _choice[key].has("label"):
					label = _choice[key]["label"]
				if _choice[key].has("func"): 
					_func = _choice[key]["func"]
				print(label , _func )	
				addChoice(label,_func)
		#func 
		var _func = hasDialog('func',[])
		if _func.size() > 0:
			#print(_func)
			call(_func[0])

func clearChoice():
	for node in _choice_list:
		node.queue_free()
	_choice_list=[]

func addChoice(label,cb):
	var btn = Button.new()
	var font = load("res://fonts/f16t.tres")
	btn.set("custom_fonts/font",font)
	#btn.set("custom_fonts/normal_font",font)
	btn.text = str(label) 
	btn.rect_min_size.y = 36
	btn.connect("pressed",self,cb[0],[cb[1]])
	_choice_list.append(btn)
	boxDialog.get_node("boxChoice/container").add_child(btn)
	
func Next(_arg=""):
	
	if(_arg!=""):
		next=_arg
		getDialog(str(next))
		updateDialog()
		return false
	
	if(_choice_list.size()>0):
		return false
	if messageArray.size() > 0:
		msgIndex+=1
		if msgIndex < messageArray.size():
			message=messageArray[msgIndex]
		else:
			getDialog(str(next))
	else:
		getDialog(str(next))
	updateDialog()
	
func Back(_arg=""):
	getDialog(str(back))
	updateDialog()

func hasDialog(name,default=""):
	if _dialog.has(name):
		return _dialog[name]
	return default

func updateDialog():
	boxDialog.get_node("title").text = title
	boxDialog.get_node("message").text = message
	pass


func incorrect(_arg):
	message = str(_arg)
	clearChoice()
	updateDialog()

func correct(_arg):
	score+=1
	get_node("score").text = str(score)
	message = str(_arg)
	clearChoice()
	updateDialog()

func correctNext(_arg):
	score+=1
	clearChoice()
	getDialog(str(next))
	updateDialog()

func incorrectNext(_arg):
	clearChoice()
	getDialog(str(next))
	updateDialog()
	
func clearScore():
	score=0
	
func totalScore():
	message = message + " \n " +  str(score)
	updateDialog()
