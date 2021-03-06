extends VBoxContainer

export var timeout = 10;

var is_game_over = false

func _ready():
	refresh();
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")

func _input(event):
	if is_game_over:
		if event.is_action_pressed("ui_accept"):
			if $"HBoxContainer/HighscoreName".text != "":
				_on_HighscoreBtn_pressed()
			else:
				go_to_title()

	if event.is_action_pressed("ui_cancel"):
		go_to_title()

	if event.is_pressed():
		$HBoxContainer/HighscoreName.grab_focus()

func show():
	visible = true;
	$"Timer".start();
	if get_parent().turtleMurder:
		get_node("TurtleMurder").set_visible(true)

func _on_Timer_timeout():
	is_game_over = true
	timeout = timeout - 1;
	refresh();

	if timeout <= 0:
		is_game_over = false
		go_to_title()

func refresh():
	$"GameOver".text = "Game over (%s)" % timeout

func go_to_title():
	var tree = get_tree()
	tree.change_scene("res://Scenes/TitleScreen/TitleScreen.tscn")
	tree.paused = false


func _on_HighscoreBtn_pressed():
	var secretkey = 'OURSECRETKEYHERE'
	var url = "https://www.dreamlo.com/lb/" + secretkey + "/add/" + $"HBoxContainer/HighscoreName".text.to_lower() + "/" + str($"../HUD".score)
	var error = $HTTPRequest.request(url)
	if error != OK:
		push_error("An error occurred in the HTTP request, result was " + str(error))


func _on_request_completed(result, response_code, headers, body):
	get_tree().change_scene("res://Scenes/Highscore/Highscore.tscn")
	get_tree().paused = false

func _on_HighscoreName_focus_entered():
	$"Timer".stop();
