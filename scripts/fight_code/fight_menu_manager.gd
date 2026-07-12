extends Node2D

var player_attacking : bool = false
var pressed_answer_button_id : int

func _ready() -> void:
	EventManager.CONTINUE_TIMELINE.connect(disable)

func _process(delta: float) -> void:
	if player_attacking:
		$AttackUiContainer/Cursor.position.x = clamp($AttackUiContainer/Cursor.position.x+200*delta, 0, 300)
		if Input.is_action_just_pressed("click"):
			EventManager.ON_CHARACTER_TAKE_DAMAGE.emit()
			disable()

func enable_action_buttons() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	$ButtonsContainer.visible = true

func enable_answer_buttons(answers_options : Array) -> void:
	var ans_container = $AnswersButtonsContainer
	var i : int = 0
	for answer_option in answers_options:
		var button : ButtonWihID = ButtonWihID.new()
		button.id = i
		button.text = answer_option
		button.on_pressed.connect(_on_answer_button_pressed)
		ans_container.add_child(button)
		i += 1
	ans_container.visible = true
	
func _on_answer_button_pressed(id:int) -> void:
	pressed_answer_button_id = id
	EventManager.CONTINUE_TIMELINE.emit()
	
func disable() -> void:
	player_attacking = false
	$ButtonsContainer.visible = false
	$AttackUiContainer.visible = false
	$AnswersButtonsContainer.visible = false

func _on_attack_button_pressed() -> void:
	player_attacking = true
	$AttackUiContainer.visible = true
	$ButtonsContainer.visible = false
