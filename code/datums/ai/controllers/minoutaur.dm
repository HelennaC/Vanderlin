/datum/ai_controller/minotaur
<<<<<<< HEAD
	movement_delay = 0.5 SECONDS

	ai_movement = /datum/ai_movement/basic_avoidance

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items()

	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/simple_find_target/spider,
		/datum/ai_planning_subtree/find_food/spider,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk
=======
	movement_delay = 0.7 SECONDS
	ai_movement = /datum/ai_movement/hybrid_pathing
	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items(),
		BB_MINOTAUR_RAGE_METER = 0,
		BB_MINOTAUR_PHASE = 1,
		BB_MINOTAUR_CHARGE_COOLDOWN = 0,
		BB_MINOTAUR_SUMMON_COOLDOWN = 0,
		BB_MINOTAUR_SLAM_COOLDOWN = 0,
		BB_MINOTAUR_LAST_SPECIAL_ATTACK = null
	)
	planning_subtrees = list(
		/datum/ai_planning_subtree/minotaur_targeting,
		/datum/ai_planning_subtree/minotaur_special_attacks,
		/datum/ai_planning_subtree/minotaur_melee_attack,
		/datum/ai_planning_subtree/minotaur_enrage // Special behavior at low health
	)
	idle_behavior = /datum/idle_behavior/minotaur_patrol

/datum/idle_behavior/minotaur_patrol

/datum/idle_behavior/minotaur_patrol/perform_idle_behavior(delta_time, datum/ai_controller/controller)
	var/mob/living/simple_animal/hostile/retaliate/minotaur/boss = controller.pawn

	if(prob(65))
		step_rand(boss)

	if(!istype(boss) || prob(50))
		return

	// Occasional roar or stomp when patrolling
	if(prob(3))
		boss.visible_message("<span class='warning'>[boss] lets out a deep bellow!</span>")
		playsound(boss, 'sound/misc/explode/explosion.ogg', 30, TRUE)

	if(prob(5))
		boss.visible_message("<span class='warning'>[boss] stomps the ground!</span>")
		playsound(boss, 'sound/combat/hits/kick/stomp.ogg', 30, TRUE)
>>>>>>> upstream/main
