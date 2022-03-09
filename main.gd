extends Node2D


onready var dialog = $dialog


func _ready():
	dialog.updateDialog()
	
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_pressed():
	#print(dialog.dialogs["0"])
	#print(dialog.rows.title)
	#print(dialog.rows.message)
	dialog.loadDialog()
	dialog.updateDialog()


func _on_Button2_pressed():
	dialog.rows.Next()
	dialog.updateDialog()


func _on_Button3_pressed():
	dialog.rows.Back()
	dialog.updateDialog()

