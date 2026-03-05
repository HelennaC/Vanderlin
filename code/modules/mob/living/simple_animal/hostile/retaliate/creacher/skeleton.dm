<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
/mob/living/simple_animal/hostile/rogue/skeleton
=======
/mob/living/simple_animal/hostile/skeleton
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	name = "Skeleton"
	desc = ""
	icon = 'icons/roguetown/mob/monster/skeletons.dmi'
	icon_state = "skeleton"
	icon_living = "skeleton"
	icon_dead = "skeleton_dead"
	gender = MALE
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID
	robust_searching = 1
	turns_per_move = 1
	move_to_delay = 3
	STACON = 9
	STASTR = 9
	STASPD = 8
=======
	mob_biotypes = MOB_ORGANIC|MOB_HUMANOID|MOB_UNDEAD
	robust_searching = 1
	move_to_delay = 3
	base_constitution = 9
	base_strength = 9
	base_speed = 8
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	maxHealth = 100
	health = 100
	harm_intent_damage = 10
	melee_damage_lower = 10
	melee_damage_upper = 25
	vision_range = 7
	aggro_vision_range = 9
	retreat_distance = 0
	minimum_distance = 0
	limb_destroyer = 1
	base_intents = list(/datum/intent/simple/claw/skeleton_unarmed)
	attack_verb_continuous = "hacks"
	attack_verb_simple = "hack"
	attack_sound = 'sound/blank.ogg'
	canparry = TRUE
	d_intent = INTENT_PARRY
	defprob = 50
	defdrain = 20
	speak_emote = list("grunts")
	loot = list(/obj/item/alch/bone,	/obj/item/alch/bone, /obj/item/alch/bone,	/obj/item/skull)
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
	faction = list("undead")
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	del_on_death = TRUE

/mob/living/simple_animal/hostile/rogue/skeleton/axe
=======
	faction = list(FACTION_UNDEAD)
	footstep_type = FOOTSTEP_MOB_BAREFOOT
	del_on_death = TRUE

	ai_controller = /datum/ai_controller/orc

/mob/living/simple_animal/hostile/skeleton/Initialize(mapload, mob/user, cabal_affine)
	. = ..()
	AddComponent(/datum/component/ai_aggro_system)

/mob/living/simple_animal/hostile/skeleton/axe
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	name = "Skeleton"
	desc = ""
	icon = 'icons/roguetown/mob/monster/skeletons.dmi'
	base_intents = list(/datum/intent/simple/axe)
	icon_state = "skeleton_axe"
	icon_living = "skeleton_axe"
	icon_dead = ""
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
	loot = list(/obj/item/alch/bone,	/obj/item/alch/bone, /obj/item/alch/bone,	/obj/item/rogueweapon/polearm/halberd/bardiche/woodcutter, /obj/item/skull)



/mob/living/simple_animal/hostile/rogue/skeleton/spear
=======
	loot = list(/obj/item/alch/bone,	/obj/item/alch/bone, /obj/item/alch/bone,	/obj/item/weapon/polearm/halberd/bardiche/woodcutter, /obj/item/skull)

/mob/living/simple_animal/hostile/skeleton/spear
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	name = "Skeleton"
	desc = ""
	icon = 'icons/roguetown/mob/monster/skeletons.dmi'
	base_intents = list(/datum/intent/simple/spear)
	icon_state = "skeleton_spear"
	icon_living = "skeleton_spear"
	icon_dead = ""
	attack_sound = 'sound/foley/pierce.ogg'
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
	loot = list(/obj/item/alch/bone,	/obj/item/alch/bone, /obj/item/alch/bone,	/obj/item/rogueweapon/polearm/spear, /obj/item/skull)

/mob/living/simple_animal/hostile/rogue/skeleton/guard
=======
	loot = list(/obj/item/alch/bone,	/obj/item/alch/bone, /obj/item/alch/bone,	/obj/item/weapon/polearm/spear, /obj/item/skull)

/mob/living/simple_animal/hostile/skeleton/guard
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	name = "Skeleton"
	desc = ""
	icon = 'icons/roguetown/mob/monster/skeletons.dmi'
	base_intents = list(/datum/intent/simple/axe)
	icon_state = "skeleton_guard"
	icon_living = "skeleton_guard"
	icon_dead = ""
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
	loot = list(/obj/item/alch/bone,	/obj/item/alch/bone, /obj/item/alch/bone,	/obj/item/rogueweapon/sword/iron, /obj/item/skull)
	maxHealth = 200
	health = 200

/mob/living/simple_animal/hostile/rogue/skeleton/bow
=======
	loot = list(/obj/item/alch/bone,	/obj/item/alch/bone, /obj/item/alch/bone,	/obj/item/weapon/sword/iron, /obj/item/skull)
	maxHealth = 200
	health = 200

/mob/living/simple_animal/hostile/skeleton/bow
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	name = "Skeleton"
	desc = ""
	icon = 'icons/roguetown/mob/monster/skeletons.dmi'
	icon_state = "skeleton_bow"
	icon_living = "skeleton_bow"
	icon_dead = ""
	projectiletype = /obj/projectile/bullet/reusable/arrow/ancient
	projectilesound = 'sound/combat/Ranged/flatbow-shot-01.ogg'
	ranged = 1
	retreat_distance = 2
	minimum_distance = 5
	ranged_cooldown_time = 60
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
	check_friendly_fire = 1
=======
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	loot = list(
		/obj/item/alch/bone,
		/obj/item/alch/bone,
		/obj/item/alch/bone,
		/obj/item/skull,
		/obj/item/gun/ballistic/revolver/grenadelauncher/bow,
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
		/obj/item/ammo_casing/caseless/rogue/arrow,
		/obj/item/ammo_casing/caseless/rogue/arrow,
		/obj/item/ammo_casing/caseless/rogue/arrow
	)

/mob/living/simple_animal/hostile/rogue/skeleton/get_sound(input)
=======
		/obj/item/ammo_casing/caseless/arrow,
		/obj/item/ammo_casing/caseless/arrow,
		/obj/item/ammo_casing/caseless/arrow
	)

	ai_controller = /datum/ai_controller/orc_ranged

/mob/living/simple_animal/hostile/skeleton/get_sound(input)
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/skel/skeleton_rage (1).ogg','sound/vo/mobs/skel/skeleton_rage (2).ogg','sound/vo/mobs/skel/skeleton_rage (3).ogg')
		if("pain")
			return pick('sound/vo/mobs/skel/skeleton_pain (1).ogg','sound/vo/mobs/skel/skeleton_pain (2).ogg','sound/vo/mobs/skel/skeleton_pain (3).ogg', 'sound/vo/mobs/skel/skeleton_pain (4).ogg', 'sound/vo/mobs/skel/skeleton_pain (5).ogg')
		if("death")
			return pick('sound/vo/mobs/skel/skeleton_death (1).ogg','sound/vo/mobs/skel/skeleton_death (2).ogg','sound/vo/mobs/skel/skeleton_death (3).ogg','sound/vo/mobs/skel/skeleton_death (4).ogg','sound/vo/mobs/skel/skeleton_death (5).ogg')
		if("idle")
			return pick('sound/vo/mobs/skel/skeleton_idle (1).ogg','sound/vo/mobs/skel/skeleton_idle (2).ogg','sound/vo/mobs/skel/skeleton_idle (3).ogg')


<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
/mob/living/simple_animal/hostile/rogue/skeleton/Initialize(mapload, mob/user, cabal_affine = FALSE)
=======
/mob/living/simple_animal/hostile/skeleton/Initialize(mapload, mob/user, cabal_affine = FALSE)
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	. = ..()
	if(user)
		friends += user.name
		if (cabal_affine)
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
			faction |= "cabal"

/mob/living/simple_animal/hostile/rogue/skeleton/Life()
=======
			faction |= FACTION_CABAL

/mob/living/simple_animal/hostile/skeleton/Life()
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	. = ..()
	if(!target)
		if(prob(60))
			emote(pick("idle"), TRUE)

<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
/mob/living/simple_animal/hostile/rogue/skeleton/taunted(mob/user)
	emote("aggro")
	GiveTarget(user)
	return

/mob/living/simple_animal/hostile/rogue/skeleton/proc/can_control(mob/user)
//	if(!(user.mind?.has_antag_datum(/datum/antagonist/lich)))	commented out since lich not yet in TO DO
//		return FALSE
=======
/mob/living/simple_animal/hostile/skeleton/taunted(mob/user)
	emote("aggro")
	return

/mob/living/simple_animal/hostile/skeleton/proc/can_control(mob/user)
	if(!(user.mind?.has_antag_datum(/datum/antagonist/lich)))
		return FALSE
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	if (!(user.name in friends))
		return FALSE

	return TRUE

<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
/mob/living/simple_animal/hostile/rogue/skeleton/beckoned(mob/user)
	if (can_control(user))
		for(var/mob/living/simple_animal/hostile/rogue/skeleton/target in viewers(user))
			target.LoseTarget()
			target.search_objects = 2
			target.add_overlay("peace_overlay")
		return

/mob/living/simple_animal/hostile/rogue/skeleton/shood(mob/user)
	if (can_control(user))
		for(var/mob/living/simple_animal/hostile/rogue/skeleton/target in viewers(user))
			target.RegainSearchObjects()
		return

/mob/living/simple_animal/hostile/rogue/skeleton/RegainSearchObjects(value)
	cut_overlay("peace_overlay")
	. = ..()

=======

/mob/living/simple_animal/hostile/skeleton/get_blood_dna_list() //We do not want skeletons bleeding.
//Could be a more global bitflag or something, but it's only relevant for this subtype.
	return null
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm

/datum/intent/simple/claw/skeleton_unarmed
	attack_verb = list("claws", "strikes", "punches")
	blade_class = BCLASS_CHOP
	animname = "cut"
	hitsound = list('sound/combat/hits/bladed/genchop (1).ogg', 'sound/combat/hits/bladed/genchop (2).ogg', 'sound/combat/hits/bladed/genchop (3).ogg')
	chargetime = 2
	penfactor = 5
	swingdelay = 8

/obj/item/skull
	name = "skull"
	desc = "A skull"
	icon = 'icons/roguetown/mob/monster/skeletons.dmi'
	icon_state = "skull"
	w_class = WEIGHT_CLASS_SMALL

/obj/projectile/bullet/reusable/arrow/ancient
	damage = 10
	damage_type = BRUTE
	armor_penetration = 25
	icon = 'icons/roguetown/weapons/ammo.dmi'
	icon_state = "arrow_proj"
<<<<<<< HEAD:code/modules/mob/living/simple_animal/rogue/creacher/skeleton.dm
	ammo_type = /obj/item/ammo_casing/caseless/rogue/arrow
=======
	ammo_type = /obj/item/ammo_casing/caseless/arrow
>>>>>>> upstream/main:code/modules/mob/living/simple_animal/hostile/retaliate/creacher/skeleton.dm
	range = 15
	hitsound = 'sound/combat/hits/hi_arrow2.ogg'
	embedchance = 100
	woundclass = BCLASS_STAB
	flag =  "piercing"
	speed = 2
