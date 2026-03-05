/mob/living/simple_animal/hostile/retaliate/bogbug
	icon = 'icons/roguetown/mob/monster/bogbug.dmi'
	name = "bog bug"
	desc = "A vile insect, skittering forward on spindly, hairy legs. Enjoys the flesh of sapients as much as it enjoys its fellow swamp-dwellers."
	icon_state = "bogbug"
	icon_living = "bogbug"
	icon_dead = "bogbugdead"

	faction = list("bugs")
	emote_hear = null
	emote_see = null
	see_in_dark = 9
	move_to_delay = 1
	vision_range = 9
	aggro_vision_range = 9

<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/bogbug.dm
	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/spider= 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/spider= 1,
=======
	botched_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/strange = 1)
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/strange = 1,
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/bogbug.dm
						/obj/item/natural/hide = 1)
	perfect_butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/strange = 2,
						/obj/item/natural/hide = 2)
	head_butcher = /obj/item/natural/head/bug

	health = BOGBUG_HEALTH
	maxHealth = BOGBUG_HEALTH
	food_type = list(/obj/item/reagent_containers/food/snacks/meat,
					/obj/item/bodypart,
					/obj/item/organ)

	base_intents = list(/datum/intent/simple/claw, /datum/intent/simple/stab)
	attack_sound = list('sound/vo/mobs/bogbug/bogbugattack1.ogg','sound/vo/mobs/bogbug/bogbugattack2.ogg','sound/vo/mobs/bogbug/bogbugattack3.ogg')
	melee_damage_lower = 25
	melee_damage_upper = 35

	base_constitution = 13
	base_strength = 10
	base_speed = 15
	base_endurance = 15

	retreat_distance = 2
	minimum_distance = 1
	deaggroprob = 0
	defprob = 30
	defdrain = 8
	del_on_deaggro = 999 SECONDS
	retreat_health = 0


	dodgetime = 20
	aggressive = 1
//	stat_attack = UNCONSCIOUS
	remains_type = /obj/effect/decal/remains/bogbug
	body_eater = TRUE
	dendor_taming_chance = DENDOR_TAME_PROB_HIGH
	ai_controller = /datum/ai_controller/bog_bug



	ai_controller = /datum/ai_controller/bog_bug
	AIStatus = AI_OFF
	can_have_ai = FALSE

/obj/effect/decal/remains/bogbug
	name = "remains"
	gender = PLURAL
	icon_state = "bones"
	icon = 'icons/roguetown/mob/monster/vol.dmi'

/mob/living/simple_animal/hostile/retaliate/bogbug/Initialize()
	. = ..()
	AddComponent(/datum/component/ai_aggro_system)
	gender = MALE
	ai_controller.set_blackboard_key(BB_BASIC_FOODS, food_type)

/mob/living/simple_animal/hostile/retaliate/bogbug/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/bogbug/bogbug1.ogg','sound/vo/mobs/bogbug/bogbug2.ogg','sound/vo/mobs/bogbug/bogbug3.ogg')
		if("pain")
			return pick('sound/vo/mobs/bogbug/bogbughurt2.ogg')
		if("death")
			return pick('sound/vo/mobs/bogbug/bogbughurt1.ogg')
		if("idle")
			return pick('sound/vo/mobs/bogbug/bogbugidle.ogg')
		if("cidle")
			return pick('sound/vo/mobs/bogbug/bogbug3.ogg','sound/vo/mobs/bogbug/bogbugidle.ogg')

/mob/living/simple_animal/hostile/retaliate/bogbug/taunted(mob/user)
	emote("aggro")
	return

/mob/living/simple_animal/hostile/retaliate/bogbug/simple_limb_hit(zone)
	return ..()

