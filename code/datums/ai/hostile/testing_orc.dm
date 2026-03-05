/datum/ai_controller/orc
	movement_delay = 0.6 SECONDS

<<<<<<< HEAD
	ai_movement = /datum/ai_movement/basic_avoidance
=======
	ai_movement = /datum/ai_movement/hybrid_pathing
>>>>>>> upstream/main

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	planning_subtrees = list(
<<<<<<< HEAD
		/datum/ai_planning_subtree/simple_find_target,
=======
		/datum/ai_planning_subtree/aggro_find_target,
>>>>>>> upstream/main
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk

/datum/ai_controller/orc_ranged
	movement_delay = 0.7 SECONDS

<<<<<<< HEAD
	ai_movement = /datum/ai_movement/basic_avoidance
=======
	ai_movement = /datum/ai_movement/hybrid_pathing
>>>>>>> upstream/main

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic()
	)

	planning_subtrees = list(
<<<<<<< HEAD
		/datum/ai_planning_subtree/simple_find_target,
=======
		/datum/ai_planning_subtree/aggro_find_target,
		/datum/ai_planning_subtree/spacing/ranged,
		/datum/ai_planning_subtree/basic_melee_attack_subtree/opportunistic,
>>>>>>> upstream/main
		/datum/ai_planning_subtree/basic_ranged_attack_subtree,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk
