extends Control

# Define questions and answers
var questions = [
	 {
		"question": "Who wrote 'A Christmas Carol'?",
		"answers": ["Charles Dickens", "Mark Twain", "Jane Austen", "Victor Hugo"],
		"correct": 0
	},
	{
		"question": "What is the name of the red-nosed reindeer?",
		"answers": ["Dasher", "Comet", "Rudolph", "Blitzen"],
		"correct": 2
	},
	{
		"question": "What snack is traditionally left out for Santa?",
		"answers": ["Cookies and milk", "Fruit and tea", "Cheese and crackers", "Candy canes"],
		"correct": 0
	},
	{
		"question": "Which plant is traditionally used to make people kiss at Christmas?",
		"answers": ["Holly", "Ivy", "Mistletoe", "Pine"],
		"correct": 2
	},
	{
		"question": "In which country did the tradition of the Christmas tree originate?",
		"answers": ["Germany", "France", "United Kingdom", "Sweden"],
		"correct": 0
	},
	{
		"question": "What is the name of the ballet associated with Christmas?",
		"answers": ["The Nutcracker", "Swan Lake", "Giselle", "Romeo and Juliet"],
		"correct": 0
	},
	{
		"question": "What color are the berries of the mistletoe plant?",
		"answers": ["Red", "White", "Blue", "Green"],
		"correct": 1
	},
	{
		"question": "What is Santa Claus called in Germany?",
		"answers": ["Saint Nicholas", "Weihnachtsmann", "Father Christmas", "Kris Kringle"],
		"correct": 1
	},
	{
		"question": "What traditional Christmas dessert is set on fire before serving?",
		"answers": ["Christmas pudding", "Fruitcake", "Yule log", "Panettone"],
		"correct": 0
	},
	{
		"question": "What type of calendar is used to count down the days to Christmas?",
		"answers": ["Countdown calendar", "Advent calendar", "Holiday planner", "Event tracker"],
		"correct": 1
	}
]

var current_question_index = 0
var success_count = 0;
var error_count = 0;
# References to UI elements
var question_label = null
@onready var vbox_container = $VBoxContainer
var buttons = [];
func _ready():
	for child in vbox_container.get_children():
		if child is Button:
			buttons.append(child);
		if child is Label:
			question_label = child;

	load_question(current_question_index)

# Load the current question
func load_question(index):
	var question_data = questions[index]
	question_label.text = question_data["question"]

	# Set button texts and signals
	for i in range(buttons.size()):
		buttons[i].text = question_data["answers"][i]
		buttons[i].connect("pressed", _on_answer_selected)
		#if buttons[i].is_connected("pressed", _on_answer_selected):
		#	buttons[i].connect("pressed", _on_answer_selected)

# Handle answer selection
func _on_answer_selected(answer_index):
	var correct_index = questions[current_question_index]["correct"]

	if answer_index == correct_index:
		success_count +=1;
	else:
		error_count += 1;

	# Load the next question or end the game
	current_question_index += 1
	if current_question_index < questions.size():
		load_question(current_question_index)
	else:
		var message = "";
		if(success_count > error_count):
			message = 'WIN!';
		else:
			message = 'LOSE!';
		question_label.text = message + ' Thanks for playing!';
		for button in buttons:
			button.disabled = true


func _on_button_pressed() -> void:
	_on_answer_selected(0) # Replace with function body.
