extends Resource
class_name gameDialog


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

func Back():
	getDialog(str(back))

func Exit():
	getDialog(str(exit))

func hasDialog(name,default=""):
	if _dialog.has(name):
		return _dialog[name]
	return default
