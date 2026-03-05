//Mimic mob but updated.
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/mimic.dm
/mob/living/simple_animal/hostile/retaliate/rogue/mimic
=======
/mob/living/simple_animal/hostile/retaliate/mimic
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/mimic.dm
	name = "chest"
	icon = 'icons/roguetown/mob/monster/mimic.dmi'
	icon_state = "mimicopen"
	icon_living = "mimicopen"
	icon_dead = "mimicdead"

	speed = 0
	maxHealth = 450
	health = 450
	gender = NEUTER
	mob_biotypes = NONE
	base_intents = list(/datum/intent/simple/bite)
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/mimic.dm
	butcher_results = list(/obj/item/reagent_containers/food/snacks/rogue/meat/steak = 2)
=======
	butcher_results = list(/obj/item/reagent_containers/food/snacks/meat/steak = 2)
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/mimic.dm
	retreat_distance = 0
	minimum_distance = 0
	aggro_vision_range = 2
	see_in_dark = 6

	damage_coeff = list(BRUTE = 1, BURN = 0, TOX = 0, CLONE = 0, STAMINA = 0, OXY = 0)
	harm_intent_damage = 5
	melee_damage_lower = 24
	melee_damage_upper = 32
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	attack_sound = list('sound/vo/mobs/mimic/mimic_attack1.ogg',
						'sound/vo/mobs/mimic/mimic_attack2.ogg',
						'sound/vo/mobs/mimic/mimic_attack3.ogg')
	emote_taunt = list("howls")
	speak_emote = list("clatters")

	faction = list("mimic", "hostile")
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/mimic.dm
	stop_automated_movement = 1
	wander = 0
	stat_attack = UNCONSCIOUS

	food_type = list(/obj/item/reagent_containers/food/snacks/rogue/meat, /obj/item/bodypart, /obj/item/organ)
	food = 0
	pooptype = null

	STACON = 15
	STASTR = 15
	STASPD = 5

	ai_controller = /datum/ai_controller/mimic
	AIStatus = AI_OFF
	can_have_ai = FALSE

/mob/living/simple_animal/hostile/retaliate/rogue/mimic/Initialize(mapload)
=======
	wander = 0
	stat_attack = UNCONSCIOUS

	food_type = list(/obj/item/reagent_containers/food/snacks/meat, /obj/item/bodypart, /obj/item/organ)

	pooptype = null

	base_constitution = 6
	base_strength = 6
	base_speed = 5

	ai_controller = /datum/ai_controller/mimic
	dendor_taming_chance = DENDOR_TAME_PROB_NONE


/mob/living/simple_animal/hostile/retaliate/mimic/Initialize(mapload)
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/mimic.dm
	. = ..()
	if(mapload)//load objects into chest.
		for(var/obj/item/I in loc)
			I.forceMove(src)
	icon_state = "mimic"
	AddComponent(/datum/component/anti_magic, TRUE, TRUE, TRUE, null, null, FALSE)

<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/mimic.dm
/mob/living/simple_animal/hostile/retaliate/rogue/mimic/find_food()
	. = ..()
	if(!.)
		return eat_bodies()

/mob/living/simple_animal/hostile/retaliate/rogue/mimic/Life()
	..()
	if(pulledby)
		Retaliate()
		GiveTarget(pulledby)

/mob/living/simple_animal/hostile/retaliate/rogue/mimic/attack_hand(mob/user)
	..()
	Retaliate(user)
	GiveTarget(user)

/mob/living/simple_animal/hostile/retaliate/rogue/mimic/Aggro()
	..()
	name = "MIMIC"
	icon_state = "[initial(icon_state)]"
	aggressive = 1

/mob/living/simple_animal/hostile/retaliate/rogue/mimic/death()
=======
/mob/living/simple_animal/hostile/retaliate/mimic/death()
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/mimic.dm
	icon_state = "[initial(icon_state)]dead"
	// Drop loot onto tile.
	for(var/obj/O in src)
		O.forceMove(loc)
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/mimic.dm
	QDEL_NULL(proximity_monitor)
	..()

/mob/living/simple_animal/hostile/retaliate/rogue/mimic/get_sound(input)
=======
	..()

/mob/living/simple_animal/hostile/retaliate/mimic/get_sound(input)
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/mimic.dm
	switch(input)
		if("death")
			return pick('sound/vo/mobs/mimic/mimic_death.ogg')

<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/mimic.dm
/mob/living/simple_animal/hostile/retaliate/rogue/mimic/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "head"
		if(BODY_ZONE_PRECISE_NOSE)
			return "nose"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "mouth"
		if(BODY_ZONE_PRECISE_SKULL)
			return "head"
		if(BODY_ZONE_PRECISE_EARS)
			return "head"
		if(BODY_ZONE_PRECISE_NECK)
			return "neck"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "foreleg"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "leg"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "stomach"
		if(BODY_ZONE_PRECISE_GROIN)
			return "tail"
		if(BODY_ZONE_HEAD)
			return "head"
		if(BODY_ZONE_R_LEG)
			return "leg"
		if(BODY_ZONE_L_LEG)
			return "leg"
		if(BODY_ZONE_R_ARM)
			return "foreleg"
		if(BODY_ZONE_L_ARM)
			return "foreleg"
=======
/mob/living/simple_animal/hostile/retaliate/mimic/simple_limb_hit(zone)
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/mimic.dm
	return ..()

//////
// Landmark
//////

/obj/effect/landmark/chest_or_mimic/Initialize()
	..()
	var/C = pick(/obj/structure/closet/crate/chest,
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/mimic.dm
				/mob/living/simple_animal/hostile/retaliate/rogue/mimic)
=======
				/mob/living/simple_animal/hostile/retaliate/mimic)
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/mimic.dm
	new C(loc)
	return INITIALIZE_HINT_QDEL
