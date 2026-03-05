/datum/ai_controller/spider
	movement_delay = 0.4 SECONDS

<<<<<<< HEAD
	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items()
=======
	ai_movement = /datum/ai_movement/hybrid_pathing

	blackboard = list(
		BB_HOME_PATH = /obj/structure/spider/nest,
		BB_TARGET_HELD_ITEM = /obj/item/reagent_containers/food/snacks/meat,

		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items/not_holding_item(),
		BB_PET_TARGETING_DATUM = new /datum/targetting_datum/basic/not_friends(),
>>>>>>> upstream/main

	)

	planning_subtrees = list(
<<<<<<< HEAD
		/datum/ai_planning_subtree/flee_target,

=======
		/datum/ai_planning_subtree/pet_planning,
		/datum/ai_planning_subtree/flee_target,

		/datum/ai_planning_subtree/find_valid_home,
		/datum/ai_planning_subtree/enter_exit_home,

>>>>>>> upstream/main
		/datum/ai_planning_subtree/simple_find_target/spider,
		/datum/ai_planning_subtree/find_food/spider,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,

		/datum/ai_planning_subtree/find_dead_bodies,
		/datum/ai_planning_subtree/eat_dead_body,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk
