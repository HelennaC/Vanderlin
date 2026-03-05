/obj/take_damage(damage_amount, damage_type, damage_flag, sound_effect, attack_dir, armor_penetration)
	. = ..()
	if(!.)
		return

	if(animate_dmg)
		var/oldx = pixel_x
		animate(src, pixel_x = oldx+1, time = 0.5)
		animate(pixel_x = oldx-1, time = 0.5)
		animate(pixel_x = oldx, time = 0.5)

/obj/hitby(atom/movable/AM, skipcatch, hitpush, blocked, datum/thrownthing/throwingdatum, damage_type = "blunt")
	..()
	if(!QDELETED(src) && AM.throwforce > 5)
		take_damage(AM.throwforce*0.1, BRUTE, damage_type, 1, get_dir(src, AM))

/obj/ex_act(severity, target, epicenter, devastation_range, heavy_impact_range, light_impact_range, flame_range)
	if(resistance_flags & INDESTRUCTIBLE)
		return
	..() //contents explosion
	var/ddist = devastation_range
	var/hdist = heavy_impact_range
	var/ldist = light_impact_range
	var/fdist = flame_range
	var/fodist = get_dist(src, epicenter)
	var/brute_loss = 0

	switch (severity)
		if (EXPLODE_DEVASTATE)
			brute_loss = (250 * ddist) - (250 * max((fodist - 1), 0))

		if (EXPLODE_HEAVY)
			brute_loss = (100 * hdist) - (100 * max((fodist - 1), 0))

		if(EXPLODE_LIGHT)
			brute_loss = ((25 * ldist) - (25 * fodist))

	take_damage(brute_loss, BRUTE, "blunt", 0)

	if(fdist && !QDELETED(src))
		var/stacks = ((fdist - fodist) * 2)
		fire_act(stacks)

/obj/bullet_act(obj/projectile/P, def_zone, piercing_hit = FALSE)
	. = ..()
	playsound(src, P.hitsound, 50, TRUE)
	visible_message("<span class='danger'>[src] is hit by \a [P]!</span>", null, null, COMBAT_MESSAGE_RANGE)
	if(!QDELETED(src)) //Bullet on_hit effect might have already destroyed this object
		take_damage(P.damage, P.damage_type, P.flag, 0, turn(P.dir, 180), P.armor_penetration)

<<<<<<< HEAD
///Called to get the damage that hulks will deal to the obj.
/obj/proc/hulk_damage()
	return 150 //the damage hulks do on punches to this object, is affected by melee armor

/obj/attack_hulk(mob/living/carbon/human/user)
	..()
	user.visible_message("<span class='danger'>[user] smashes [src]!</span>", "<span class='danger'>I smash [src]!</span>", null, COMBAT_MESSAGE_RANGE)
	if(density)
		playsound(src.loc, 'sound/blank.ogg', 100, TRUE)
	else
		playsound(src, 'sound/blank.ogg', 50, TRUE)
	take_damage(hulk_damage(), BRUTE, "melee", 0, get_dir(src, user))
	return TRUE

/obj/blob_act(obj/structure/blob/B)
	if(isturf(loc))
		var/turf/T = loc
		if(T.intact && level == 1) //the blob doesn't destroy thing below the floor
			return
	take_damage(400, BRUTE, "melee", 0, get_dir(src, B))

/obj/proc/attack_generic(mob/user, damage_amount = 0, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, armor_penetration = 0) //used by attack_alien, attack_animal, and attack_slime
	user.do_attack_animation(src)
	user.changeNext_move(CLICK_CD_MELEE)
	return take_damage(damage_amount, damage_type, damage_flag, sound_effect, get_dir(src, user), armor_penetration)

=======
>>>>>>> upstream/main
/obj/attack_animal(mob/living/simple_animal/M)
	if(!M.melee_damage_upper && !M.obj_damage)
		M.emote("custom", message = "[M.friendly_verb_continuous] [src].")
		return 0
	else
		var/play_soundeffect = 1
		if(M.environment_smash)
			play_soundeffect = 0
		if(M.obj_damage)
			. = attack_generic(M, M.obj_damage, M.melee_damage_type, M.damage_type, play_soundeffect, M.armor_penetration)
		else
			. = attack_generic(M, rand(M.melee_damage_lower,M.melee_damage_upper), M.melee_damage_type, "blunt", play_soundeffect, M.armor_penetration)
		if(. && !play_soundeffect)
			playsound(src, 'sound/blank.ogg', 100, TRUE)

/obj/force_pushed(atom/movable/pusher, force = MOVE_FORCE_DEFAULT, direction)
	return TRUE

/obj/move_crushed(atom/movable/pusher, force = MOVE_FORCE_DEFAULT, direction)
	collision_damage(pusher, force, direction)
	return TRUE

/obj/proc/collision_damage(atom/movable/pusher, force = MOVE_FORCE_DEFAULT, direction)
	var/amt = max(0, ((force - (move_resist * MOVE_FORCE_CRUSH_RATIO)) / (move_resist * MOVE_FORCE_CRUSH_RATIO)) * 10)
	take_damage(amt, BRUTE)

<<<<<<< HEAD
/obj/attack_slime(mob/living/simple_animal/slime/user)
	if(!user.is_adult)
		return
	attack_generic(user, rand(10, 15), BRUTE, "melee", 1)

/obj/singularity_act()
	ex_act(EXPLODE_DEVASTATE)
	if(src && !QDELETED(src))
		qdel(src)
	return 2


=======
>>>>>>> upstream/main
///// ACID

GLOBAL_DATUM_INIT(acid_overlay, /mutable_appearance, mutable_appearance('icons/effects/effects.dmi', "acid"))

///the obj's reaction when touched by acid
/obj/acid_act(acidpwr, acid_volume)
	if(!(resistance_flags & UNACIDABLE) && acid_volume)

		if(!acid_level)
			SSacid.processing[src] = src
			add_overlay(GLOB.acid_overlay, TRUE)
		var/acid_cap = acidpwr * 300 //so we cannot use huge amounts of weak acids to do as well as strong acids.
		if(acid_level < acid_cap)
			acid_level = min(acid_level + acidpwr * acid_volume, acid_cap)
		return 1

///the proc called by the acid subsystem to process the acid that's on the obj
/obj/proc/acid_processing()
	. = TRUE
	if(!(resistance_flags & ACID_PROOF))
		if(prob(33))
			playsound(src, 'sound/blank.ogg', 150, TRUE)
		take_damage(min(1 + round(sqrt(acid_level)*0.3), 300), BURN, "acid", 0)

	acid_level = max(acid_level - (5 + 3*round(sqrt(acid_level))), 0)
	if(!acid_level)
		return FALSE

///called when the obj is destroyed by acid.
/obj/proc/acid_melt()
	SSacid.processing -= src
	deconstruct(FALSE)

//// FIRE

///Called when the obj is exposed to fire.
/obj/fire_act(added, maxstacks)
	if(QDELETED(src))
		return
	if(isturf(loc))
		var/turf/T = loc
		if(T.intact && level == 1) //fire can't damage things hidden below the floor.
			return

	var/is_wet = FALSE

	if(istype(src, /obj/item/clothing))
		var/obj/item/clothing/cloth = src
		if(cloth.wet)
			var/dry_amount = round(added / 5)
			cloth.wet.use_water(dry_amount)

			if(cloth.wet.water_stacks < 0)
				is_wet = TRUE   // supress the damage while it still wet
	if(!is_wet && added && !(resistance_flags & FIRE_PROOF))
		take_damage(CLAMP(0.02 * added, 0, 20), BURN, "fire", 0)

	if(!(resistance_flags & ON_FIRE) && (resistance_flags & FLAMMABLE) && !(resistance_flags & FIRE_PROOF))
		resistance_flags |= ON_FIRE
		SSfire_burning.processing[src] = src
		add_overlay(GLOB.fire_overlay, TRUE)
		playsound(src, 'sound/misc/enflame.ogg', 100, TRUE)
		return 1

///called when the obj is destroyed by fire
/obj/proc/burn()
	if(resistance_flags & ON_FIRE)
		SSfire_burning.processing -= src
	for(var/mob/living/carbon/human/H in view(2, src))
		if(H.has_quirk(/datum/quirk/vice/pyromaniac))
			H.sate_addiction(/datum/quirk/vice/pyromaniac)
	deconstruct(FALSE)

///Called when the obj is no longer on fire.
/obj/proc/extinguish()
	if(resistance_flags & ON_FIRE)
		resistance_flags &= ~ON_FIRE
		cut_overlay(GLOB.fire_overlay, TRUE)
		SSfire_burning.processing -= src
		if(fire_burn_start)
			fire_burn_start = null

<<<<<<< HEAD
///Called when the obj is hit by a tesla bolt.
/obj/proc/tesla_act(power, tesla_flags, shocked_targets)
	return

=======
>>>>>>> upstream/main
//The surgeon general warns that being buckled to certain objects receiving powerful shocks is greatly hazardous to your health
///Only tesla coils and grounding rods currently call this because mobs are already targeted over all other objects, but this might be useful for more things later.
/obj/proc/tesla_buckle_check(strength)
	if(has_buckled_mobs())
		for(var/mob/living/buckled_mob as anything in buckled_mobs)
			buckled_mob.electrocute_act((CLAMP(round(strength/400), 10, 90) + rand(-5, 5)), src, flags = SHOCK_TESLA)

/obj/proc/reset_shocked()
	obj_flags &= ~BEING_SHOCKED

///the obj is deconstructed into pieces, whether through careful disassembly or when destroyed.
/obj/proc/deconstruct(disassembled = TRUE)
	SEND_SIGNAL(src, COMSIG_OBJ_DECONSTRUCT, disassembled)
	if(islist(debris))
		for(var/I in debris)
			var/count = debris[I] + rand(-1,1)
			if(count > 0)
				for(var/i in 1 to count)
					new I (get_turf(src))
	if(islist(static_debris))
		for(var/I in static_debris)
			for(var/i in 1 to static_debris[I])
				new I (get_turf(src))
	qdel(src)

/obj/atom_break(damage_flag, silent)
	. = ..()
	obj_broken = TRUE

/obj/atom_fix()
	. = ..()
	obj_broken = FALSE

///what happens when the obj's integrity reaches zero.
/obj/atom_destruction(damage_flag)
	. = ..()
	if(damage_flag == "acid")
		acid_melt()
	else if(damage_flag == "fire")
		burn()
	else
		if(destroy_sound)
			playsound(src, destroy_sound, 100, TRUE)
		if(destroy_message)
			visible_message(destroy_message)
		deconstruct(FALSE)

///returns how much the object blocks an explosion. Used by subtypes.
/obj/proc/GetExplosionBlock()
	CRASH("Unimplemented GetExplosionBlock()")

/obj/proc/on_fall_impact(mob/living/impactee, fall_speed)
	SHOULD_CALL_PARENT(TRUE)
	return
