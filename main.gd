extends Control


var player1_time = 300  # 5 minutes in seconds
var player2_time = 300
var current_player = 0
var timer_running = false

func _on_space_pressed():
	
	if current_player == 2:
		current_player = 1
	elif current_player == 1:
		current_player = 2
	else:
		current_player = 1
	timer_running = true



func _on_reset_button_pressed():
	player1_time = 300
	player2_time = 300
	current_player = 0
	timer_running = false
	update_display()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	get_node("Reset_Button").connect("pressed", _on_reset_button_pressed)
	update_display()

func _input(event):
	if event.is_action_pressed("Cambio"):
		print("hola")
		_on_space_pressed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if timer_running:
		if current_player == 1:
			player1_time -= delta
			if player1_time <= 0:
				timer_running = false
		else:
			player2_time -= delta
			if player2_time <= 0:
				timer_running = false
		update_display()

func format_time(time):
	var minutes = int(time / 60)
	var seconds = int(time) % 60
	return str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)
	

func update_display():
	if current_player==1:
		$Player1_time.add_theme_color_override("font_color", Color(1, 0, 0)) # Color rojo
		$Player2_time.add_theme_color_override("font_color", Color(1, 1, 1))
	elif current_player==2:
		$Player2_time.add_theme_color_override("font_color", Color(1, 0, 0)) # Color rojo
		$Player1_time.add_theme_color_override("font_color", Color(1, 1, 1))
	else:
		$Player1_time.add_theme_color_override("font_color", Color(1, 1, 1))
		$Player2_time.add_theme_color_override("font_color", Color(1, 1, 1))
	$Player1_time.text = format_time(player1_time)
	$Player2_time.text = format_time(player2_time)


	
