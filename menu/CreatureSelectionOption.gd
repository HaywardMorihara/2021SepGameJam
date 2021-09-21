extends HBoxContainer

var scene_name : String

func init(scene_name : String):
	self.scene_name = scene_name
	var creature_info = Global.creatures.get(self.scene_name)
	$CreatureName.text = creature_info.get("name")
	$CreatureDescription.text = creature_info.get("description")
	var t = AtlasTexture.new()
	t.atlas = load("res://assets/sprites/creature_small.png")
	t.region = Rect2(0,0,16,16)
	$CreatureImageTextureRect.texture = t


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var creature_info = Global.creatures.get(self.scene_name)
	$VBoxContainer/Count.text = String(creature_info.get("count"))


func _on_PlusButton_pressed():
	var total_count = 0
	for creature_info in Global.creatures.values():
		total_count += creature_info.get("count")
	if total_count >= Global.MAX_CREATURE_COUNT:
		print("TODO Toast")
	else:
		Global.creatures[self.scene_name]["count"] += 1


func _on_MinusButton_pressed():
	if Global.creatures.get(self.scene_name).get("count") > 0:
		Global.creatures[self.scene_name]["count"] -= 1
