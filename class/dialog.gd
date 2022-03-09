extends Resource
class_name gameDialog

signal updateDialog

var title:String = ""
var actor:Image= null
var message:String=""
var back:String=""
var next:String=""
var exit:String=""

var _dialogs={}
var _dialog={}

func _init():
	print('init')

func init(data,idStart,idExit):
	#print(data)
	_dialogs = data
	getProfile()
	getDialog(str(idStart))
	emit_signal("updateDialog")
	
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
		next = hasDialog("next")
		back = hasDialog("back")
		exit = hasDialog("exit")
	#else:
	#	_dialog={}
	#	title = hasDialog("title")
	#	message = hasDialog("message")
	#	next = hasDialog("next")
	#	back = hasDialog("back")
	#	exit = hasDialog("exit")

func Next():
	getDialog(str(next))
	emit_signal("updateDialog")
	
func Back():
	getDialog(str(back))
	emit_signal("updateDialog")

func Exit():
	getDialog(str(exit))
	emit_signal("updateDialog")

func hasDialog(name,default=""):
	if _dialog.has(name):
		return _dialog[name]
	return default
