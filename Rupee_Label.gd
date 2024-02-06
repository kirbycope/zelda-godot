extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	update_rupees()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_rupees()

func update_rupees():
	text="Rupees: " + str(Global.rupees)
