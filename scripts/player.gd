extends CharacterBody2D

signal inventory_updated(inventory)

@export var SPEED = 100.0

@onready var animated_sprite = $AnimatedSprite2D

var last_direction = Vector2(0, 0)
var interactable_objects = []
var inventory = {}

func add_item_to_inventory(item):
	if (!inventory.has(item)):
		inventory[item] = { "amount": 1 }
	else: inventory[item].amount += 1
	print("You recieved a %s (%d)" % [item, inventory[item].amount])
	inventory_updated.emit(inventory)

func _physics_process(_delta):
	var directionX = Input.get_axis("move_left", "move_right")
	var directionY = Input.get_axis("move_up", "move_down")
	
	if directionX > 0:
		animated_sprite.flip_h = false
	elif directionX < 0:
		animated_sprite.flip_h = true
		
	if (directionX > 0 or directionX < 0) and directionY == 0:
		animated_sprite.play("run_right")
	
	if directionY > 0 and directionX == 0:
		animated_sprite.play("run_down")
	elif directionY < 0 and directionX == 0:
		animated_sprite.play("run_up")
	
	if directionX == 0 and directionY == 0:
		if (last_direction.x != 0):
			animated_sprite.play("idle_right")
		elif (last_direction.y == -1):
			animated_sprite.play("idle_up")
		elif (last_direction.y == 1):
			animated_sprite.play("idle_down")
	else:
		last_direction = Vector2(directionX, directionY)
	
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	velocity = velocity.normalized() * SPEED

	move_and_slide()

func _input(_ev):
	if Input.is_action_just_pressed("interact"):
		var closestObject
		var closestDistance = 1000
		for object in interactable_objects:
			var distance = global_position.distance_to(object.global_position)
			if (distance < closestDistance): 
				closestDistance = distance
				closestObject = object
		if (closestObject):
			var resource = closestObject.get_parent().resource_name
			add_item_to_inventory(resource)

func _on_interact_entered(area):
	interactable_objects.append(area)


func _on_interact_exited(area):
	interactable_objects.erase(area)
