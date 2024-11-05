extends Control

var player1_time = 300  # 5 minutes in seconds
var player2_time = 300
var current_player = 0
var timer_running = false

func _on_player1_button_pressed():
	if current_player != 2:
		current_player = 2
		timer_running = true

func _on_player2_button_pressed():
	if current_player != 1:
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
	get_node("Player1_button").connect("pressed", _on_player1_button_pressed)
	get_node("Player2_button").connect("pressed", _on_player2_button_pressed)
	get_node("Reset_Button").connect("pressed", _on_reset_button_pressed)
	update_display()


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
	$Player1_time.text = format_time(player1_time)
	$Player2_time.text = format_time(player2_time)
