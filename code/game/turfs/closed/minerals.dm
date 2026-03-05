/**********************Mineral deposits**************************/

/turf/closed/mineral //wall piece
	name = "rock"
	desc = "Seems barren."
	icon = 'icons/turf/smooth/walls/mineral.dmi'
	icon_state = MAP_SWITCH("mineral", "mineral-0")
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_CLOSED + SMOOTH_GROUP_MINERAL_WALLS
	smoothing_list = SMOOTH_GROUP_MINERAL_WALLS
	wallclimb = TRUE
	baseturfs = /turf/open/floor/naturalstone
	above_floor = /turf/open/floor/naturalstone
	opacity = 1
	density = TRUE
	var/turf/open/floor/turf_type = /turf/open/floor/naturalstone
	var/obj/item/mineralType = null
	var/obj/item/natural/rock/rockType = null
	var/mob/living/lastminer //for xp gain and luck shenanigans
	var/mineralAmt = 1
	var/spread = 0 //will the seam spread?
	var/spreadChance = 0 //the percentual chance of an ore spreading to the neighbouring tiles
	var/last_act = 0
	var/defer_change = 0
	blade_dulling = DULLING_PICK
	max_integrity = 500
	explosion_block = 20
	damage_deflection = 10
	break_sound = 'sound/combat/hits/onstone/stonedeath.ogg'
	attacked_sound = list('sound/combat/hits/onrock/onrock (1).ogg', 'sound/combat/hits/onrock/onrock (2).ogg', 'sound/combat/hits/onrock/onrock (3).ogg', 'sound/combat/hits/onrock/onrock (4).ogg')
	neighborlay = "dirtedge"

/turf/closed/mineral/Destroy()
	. = ..()
	lastminer = null

// Inlined version of the bump click element. way faster this way, the element's nice but it's too much overhead
/turf/closed/mineral/Bumped(atom/movable/bumped_atom)
	. = ..()
	if(!isliving(bumped_atom))
		return

	var/mob/living/bumping = bumped_atom

	var/obj/item/held_item = bumping.get_active_held_item()
	// !held_item exists to be nice to snow. the other bit is for pickaxes obviously
	if(!held_item && !bumping.throwing)
		INVOKE_ASYNC(bumping, TYPE_PROC_REF(/mob, ClickOn), src)
	else if(held_item.tool_behaviour == TOOL_MINING)
		attackby(held_item, bumping)

/turf/closed/mineral/LateInitialize()
	. = ..()
	if(mineralType && mineralAmt && spread && spreadChance)
		for(var/dir in GLOB.cardinals)
			if(prob(spreadChance))
				var/turf/T = get_step(src, dir)
				if(istype(T, /turf/closed/mineral/random))
					Spread(T)
	var/turf/open/openspace/target = GET_TURF_ABOVE(src)
	if(istype(target))
		target.ChangeTurf(/turf/open/floor/naturalstone)

/turf/closed/mineral/get_smooth_underlay_icon(mutable_appearance/underlay_appearance, turf/asking_turf, adjacency_dir)
	if(turf_type)
		underlay_appearance.icon = initial(turf_type.icon)
		underlay_appearance.icon_state = initial(turf_type.icon_state)
		return TRUE
	return ..()


/turf/closed/mineral/attackby(obj/item/I, mob/user, list/modifiers)
	if (!user.IsAdvancedToolUser())
		to_chat(user, span_warning("I don't have the dexterity to do this!"))
		return
	lastminer = user
	var/olddam = atom_integrity
	. = ..()
	if(uses_integrity && atom_integrity > 10)
		if(atom_integrity < olddam)
			if(prob(50))
				if(user.Adjacent(src))
					var/obj/item/natural/stone/S = new(src)
					S.forceMove(get_turf(user))

/turf/closed/mineral/atom_destruction(damage_flag)
	if(damage_flag == "blunt")
		var/obj/item/explo_mineral = mineralType
		var/explo_mineral_amount = mineralAmt
		var/obj/item/natural/rock/explo_rock = rockType
		var/turf/new_turf = ScrapeAway()
		GLOB.mined_resource_loc |= new_turf
		QUEUE_SMOOTH_NEIGHBORS(new_turf)
		new /obj/item/natural/stone(new_turf)
		if(prob(30))
			new /obj/item/natural/stone(new_turf)
		if (explo_mineral && (explo_mineral_amount > 0))
			if(prob(33)) //chance to spawn ore directly
				new explo_mineral(new_turf)
			if(explo_rock)
				if(prob(23))
					new explo_rock(new_turf)
			SSblackbox.record_feedback("tally", "ore_mined", explo_mineral_amount, explo_mineral)
		else
			return
	else
		if(lastminer?.stat_roll(STATKEY_LCK,2,10) && mineralType)
	//		to_chat(lastminer, span_notice("Bonus ducks!"))
			new mineralType(src)
		gets_drilled(lastminer, give_exp = FALSE)
		QUEUE_SMOOTH_NEIGHBORS(src)
	..()

/turf/closed/mineral/proc/gets_drilled(mob/living/user, triggered_by_explosion = FALSE, give_exp = TRUE)
	new /obj/item/natural/stone(src)
	if(prob(30))
		new /obj/item/natural/stone(src)
	if (mineralType && (mineralAmt > 0))
		if(prob(33)) //chance to spawn ore directly
			var/obj/item/ore/new_ore = new mineralType(src)
			// Apply quality based on mining skill and luck
			apply_mining_quality(new_ore, user)
		if(rockType) //always spawn at least 1 rock
			var/obj/item/natural/rock/new_rock = new rockType(src)
			// Rocks can also have quality
			apply_mining_quality(new_rock, user)
			if(prob(23))
				var/obj/item/natural/rock/bonus_rock = new rockType(src)
				apply_mining_quality(bonus_rock, user)
		SSblackbox.record_feedback("tally", "ore_mined", mineralAmt, mineralType)
<<<<<<< HEAD
//	if(ishuman(user))
//		var/mob/living/carbon/human/H = user
//		if(give_exp)
//			if (mineralType && (mineralAmt > 0))
//				H.mind.adjust_experience(/datum/skill/mining, initial(mineralType.mine_experience) * mineralAmt)
//			else
//				H.mind.adjust_experience(/datum/skill/mining, 4)

=======
	else if(user?.stat_roll(STATKEY_LCK,2,10))
		var/newthing = pickweight(list(/obj/item/natural/rock/salt = 2, /obj/item/natural/rock/iron = 1, /obj/item/natural/rock/coal = 2))
		var/obj/item/bonus_item = new newthing(src)
		apply_mining_quality(bonus_item, user)
>>>>>>> upstream/main
	var/flags = NONE
	if(defer_change)
		flags = CHANGETURF_DEFER_CHANGE
	var/turf/new_turf = ScrapeAway(null, flags)
	GLOB.mined_resource_loc |= new_turf
	addtimer(CALLBACK(src, PROC_REF(AfterChange)), 1, TIMER_UNIQUE)

/turf/closed/mineral/proc/apply_mining_quality(obj/item/item, mob/living/user)
	if(!user || !istype(item, /obj/item/ore))
		return

	var/mining_skill = user.get_skill_level(/datum/skill/labor/mining, TRUE) + user.get_inspirational_bonus()

	// Base quality calculation - mainly chance-based with skill influence
	var/base_chance = 5 // 5% chance for quality 2
	var/skill_bonus = mining_skill * 2 // +2% per skill level
	var/luck_bonus = 0

	// Check for luck bonus
	if(user.stat_roll(STATKEY_LCK, 3, 15))
		luck_bonus = 10

	var/total_chance = base_chance + skill_bonus + luck_bonus
	var/quality = 1 // Default quality

	// Determine quality tier
	if(prob(total_chance))
		quality = 2
		if(prob(total_chance / 3)) // Much rarer
			quality = 3
			if(prob(total_chance / 6)) // Very rare
				quality = 4
	item.set_quality(quality)

/turf/closed/mineral/attack_animal(mob/living/simple_animal/user)
	if((user.environment_smash & ENVIRONMENT_SMASH_WALLS) || (user.environment_smash & ENVIRONMENT_SMASH_RWALLS))
		gets_drilled(user)
	..()
<<<<<<< HEAD

/*
/turf/closed/mineral/Bumped(atom/movable/AM)
	..()
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		var/obj/item/I = H.get_active_held_item()
		if(I && H.a_intent.blade_class == BCLASS_PICK)
			attackby(I, H)
		return
	else if(iscyborg(AM))
		var/mob/living/silicon/robot/R = AM
		if(R.module_active && R.module_active.tool_behaviour == TOOL_MINING)
			attackby(R.module_active, R)
			return
	else
		return
*/
=======
>>>>>>> upstream/main
/turf/closed/mineral/acid_melt()
	ScrapeAway()

/turf/closed/mineral/ex_act(severity, target, epicenter, devastation_range, heavy_impact_range, light_impact_range, flame_range)
	if(target == src)
		ScrapeAway()
		return
	var/ddist = devastation_range
	var/hdist = heavy_impact_range
	var/ldist = light_impact_range
	var/fdist = flame_range
	var/fodist = get_dist(src, epicenter)
	var/brute_loss = 0
	var/dmgmod = round(rand(0.1, 2), 0.1)

	switch (severity)
		if (EXPLODE_DEVASTATE)
			brute_loss = ((250 * ddist) - (250 * fodist) * dmgmod)

		if (EXPLODE_HEAVY)
			brute_loss = ((100 * hdist) - (100 * fodist) * dmgmod)

		if(EXPLODE_LIGHT)
			brute_loss = ((25 * ldist) - (25 * fodist) * dmgmod)

	if(fodist == 0)
		brute_loss *= 2
	take_damage(brute_loss, BRUTE, "blunt", 0)

	if(fdist && !QDELETED(src))
		var/stacks = ((fdist - fodist) * 2)
		fire_act(stacks)

	if(!density)
		..()

/turf/closed/mineral/Spread(turf/T)
	T.ChangeTurf(type)

/turf/closed/mineral/cold
	icon = 'icons/turf/smooth/walls/mineral_blue.dmi'

/turf/closed/mineral/random
	name = "rock"
	desc = "Seems barren."
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "rand_low")
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = SMOOTH_GROUP_CLOSED + SMOOTH_GROUP_MINERAL_WALLS
	smoothing_list = SMOOTH_GROUP_MINERAL_WALLS
	turf_type = /turf/open/floor/naturalstone
	above_floor = /turf/open/floor/naturalstone
	baseturfs = /turf/open/floor/naturalstone
	wallclimb = TRUE
	max_integrity = 400
	///if this isn't empty, swaps to one of them via pickweight
	var/list/mineralSpawnChanceList = list(/turf/closed/mineral/salt = 20, /turf/closed/mineral/copper = 15, ,/turf/closed/mineral/tin = 12, /turf/closed/mineral/iron = 5, /turf/closed/mineral/coal = 5)
	///the chance to swap to something useful
	var/mineralChance = 30

/turf/closed/mineral/random/Initialize()
	. = ..()
	if (prob(mineralChance))
		var/path = pickweight(mineralSpawnChanceList)
		var/turf/T = ChangeTurf(path,null,CHANGETURF_IGNORE_AIR)

		if(ismineralturf(T))
			var/turf/closed/mineral/M = T
			M.mineralAmt = rand(1, 5)
			M.turf_type = src.turf_type
			M.baseturfs = src.baseturfs
			src = M
			M.levelupdate()

/turf/closed/mineral/random/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "rand_low_ice")
	mineralSpawnChanceList = list(
<<<<<<< HEAD
		/turf/closed/mineral/uranium = 35, /turf/closed/mineral/diamond = 30, /turf/closed/mineral/gold = 45, /turf/closed/mineral/titanium = 45,
		/turf/closed/mineral/silver = 50, /turf/closed/mineral/plasma = 50, /turf/closed/mineral/bscrystal = 20)

/turf/closed/mineral/random/high_chance/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium/volcanic = 35, /turf/closed/mineral/diamond/volcanic = 30, /turf/closed/mineral/gold/volcanic = 45, /turf/closed/mineral/titanium/volcanic = 45,
		/turf/closed/mineral/silver/volcanic = 50, /turf/closed/mineral/plasma/volcanic = 50, /turf/closed/mineral/bscrystal/volcanic = 20)



/turf/closed/mineral/random/low_chance
	icon_state = "rock_lowchance"
	mineralChance = 6
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium = 2, /turf/closed/mineral/diamond = 1, /turf/closed/mineral/gold = 4, /turf/closed/mineral/titanium = 4,
		/turf/closed/mineral/silver = 6, /turf/closed/mineral/plasma = 15, /turf/closed/mineral/iron = 40,
		/turf/closed/mineral/gibtonite = 2, /turf/closed/mineral/bscrystal = 1)


/turf/closed/mineral/random/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1

	mineralChance = 10
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium/volcanic = 5, /turf/closed/mineral/diamond/volcanic = 1, /turf/closed/mineral/gold/volcanic = 10, /turf/closed/mineral/titanium/volcanic = 11,
		/turf/closed/mineral/silver/volcanic = 12, /turf/closed/mineral/plasma/volcanic = 20, /turf/closed/mineral/iron/volcanic = 40,
		/turf/closed/mineral/gibtonite/volcanic = 4, /turf/open/floor/plating/asteroid/airless/cave/volcanic = 1, /turf/closed/mineral/bscrystal/volcanic = 1)


/turf/closed/mineral/random/labormineral
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium = 3, /turf/closed/mineral/diamond = 1, /turf/closed/mineral/gold = 8, /turf/closed/mineral/titanium = 8,
		/turf/closed/mineral/silver = 20, /turf/closed/mineral/plasma = 30, /turf/closed/mineral/iron = 95,
		/turf/closed/mineral/gibtonite = 2)
	icon_state = "rock_labor"


/turf/closed/mineral/random/labormineral/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1
	mineralSpawnChanceList = list(
		/turf/closed/mineral/uranium/volcanic = 3, /turf/closed/mineral/diamond/volcanic = 1, /turf/closed/mineral/gold/volcanic = 8, /turf/closed/mineral/titanium/volcanic = 8,
		/turf/closed/mineral/silver/volcanic = 20, /turf/closed/mineral/plasma/volcanic = 30, /turf/closed/mineral/bscrystal/volcanic = 1, /turf/closed/mineral/gibtonite/volcanic = 2,
		/turf/closed/mineral/iron/volcanic = 95)



/turf/closed/mineral/iron
	mineralType = /obj/item/stack/ore/iron
	spreadChance = 20
	spread = 1
	scan_state = "rock_Iron"

/turf/closed/mineral/iron/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1

/turf/closed/mineral/iron/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_iron"
	smooth_icon = 'icons/turf/walls/icerock_wall.dmi'
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE


/turf/closed/mineral/uranium
	mineralType = /obj/item/stack/ore/uranium
	spreadChance = 5
	spread = 1
	scan_state = "rock_Uranium"

/turf/closed/mineral/uranium/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1


/turf/closed/mineral/diamond
	mineralType = /obj/item/stack/ore/diamond
	spreadChance = 0
	spread = 1
	scan_state = "rock_Diamond"

/turf/closed/mineral/diamond/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1

/turf/closed/mineral/diamond/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_diamond"
	smooth_icon = 'icons/turf/walls/icerock_wall.dmi'
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE


/turf/closed/mineral/gold
	mineralType = /obj/item/stack/ore/gold
	spreadChance = 5
	spread = 1
	scan_state = "rock_Gold"

/turf/closed/mineral/gold/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1


/turf/closed/mineral/silver
	mineralType = /obj/item/stack/ore/silver
	spreadChance = 5
	spread = 1
	scan_state = "rock_Silver"

/turf/closed/mineral/silver/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1


/turf/closed/mineral/titanium
	mineralType = /obj/item/stack/ore/titanium
	spreadChance = 5
	spread = 1
	scan_state = "rock_Titanium"

/turf/closed/mineral/titanium/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1


/turf/closed/mineral/plasma
	mineralType = /obj/item/stack/ore/plasma
	spreadChance = 8
	spread = 1
	scan_state = "rock_Plasma"

/turf/closed/mineral/plasma/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1

/turf/closed/mineral/plasma/ice
	environment_type = "snow_cavern"
	icon_state = "icerock_plasma"
	smooth_icon = 'icons/turf/walls/icerock_wall.dmi'
	turf_type = /turf/open/floor/plating/asteroid/snow/ice
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	initial_gas_mix = FROZEN_ATMOS
	defer_change = TRUE



/turf/closed/mineral/bananium
	mineralType = /obj/item/stack/ore/bananium
	mineralAmt = 3
	spreadChance = 0
	spread = 0
	scan_state = "rock_Bananium"


/turf/closed/mineral/bscrystal
	mineralType = /obj/item/stack/ore/bluespace_crystal
	mineralAmt = 1
	spreadChance = 0
	spread = 0
	scan_state = "rock_BScrystal"

/turf/closed/mineral/bscrystal/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1


/turf/closed/mineral/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt
	baseturfs = /turf/open/floor/plating/asteroid/basalt
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS

/turf/closed/mineral/volcanic/lava_land_surface
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	defer_change = 1

/turf/closed/mineral/ash_rock //wall piece
	name = "rock"
	icon = 'icons/turf/mining.dmi'
	smooth_icon = 'icons/turf/walls/rock_wall.dmi'
	icon_state = "rock2"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = list (/turf/closed)
	baseturfs = /turf/open/floor/plating/ashplanet/wateryrock
	initial_gas_mix = OPENTURF_LOW_PRESSURE
	environment_type = "waste"
	turf_type = /turf/open/floor/plating/ashplanet/rocky
	defer_change = 1

/turf/closed/mineral/snowmountain
	name = "snowy mountainside"
	icon = 'icons/turf/mining.dmi'
	smooth_icon = 'icons/turf/walls/mountain_wall.dmi'
	icon_state = "mountainrock"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = list (/turf/closed)
	baseturfs = /turf/open/floor/plating/asteroid/snow
	initial_gas_mix = FROZEN_ATMOS
	environment_type = "snow"
	turf_type = /turf/open/floor/plating/asteroid/snow
	defer_change = TRUE

/turf/closed/mineral/snowmountain/cavern
	name = "ice cavern rock"
	icon = 'icons/turf/mining.dmi'
	smooth_icon = 'icons/turf/walls/icerock_wall.dmi'
	icon_state = "icerock"
	smooth = SMOOTH_MORE|SMOOTH_BORDER
	canSmoothWith = list (/turf/closed)
	baseturfs = /turf/open/floor/plating/asteroid/snow/ice
	environment_type = "snow_cavern"
	turf_type = /turf/open/floor/plating/asteroid/snow/ice

//GIBTONITE

/turf/closed/mineral/gibtonite
	mineralAmt = 1
	spreadChance = 0
	spread = 0
	scan_state = "rock_Gibtonite"
	var/det_time = 8 //Countdown till explosion, but also rewards the player for how close you were to detonation when you defuse it
	var/stage = GIBTONITE_UNSTRUCK //How far into the lifecycle of gibtonite we are
	var/activated_ckey = null //These are to track who triggered the gibtonite deposit for logging purposes
	var/activated_name = null
	var/mutable_appearance/activated_overlay

/turf/closed/mineral/gibtonite/Initialize()
	det_time = rand(8,10) //So you don't know exactly when the hot potato will explode
	. = ..()

/turf/closed/mineral/gibtonite/proc/explosive_reaction(mob/user = null, triggered_by_explosion = 0)
	if(stage == GIBTONITE_UNSTRUCK)
		activated_overlay = mutable_appearance('icons/turf/smoothrocks.dmi', "rock_Gibtonite_active", ON_EDGED_TURF_LAYER)
		add_overlay(activated_overlay)
		name = "gibtonite deposit"
		desc = ""
		stage = GIBTONITE_ACTIVE
		visible_message("<span class='danger'>There was gibtonite inside! It's going to explode!</span>")

		var/notify_admins = 0
		if(z != 5)
			notify_admins = TRUE

		if(!triggered_by_explosion)
			log_bomber(user, "has trigged a gibtonite deposit reaction via", src, null, notify_admins)
		else
			log_bomber(null, "An explosion has triggered a gibtonite deposit reaction via", src, null, notify_admins)

		countdown(notify_admins)

/turf/closed/mineral/gibtonite/proc/countdown(notify_admins = 0)
	set waitfor = 0
	while(istype(src, /turf/closed/mineral/gibtonite) && stage == GIBTONITE_ACTIVE && det_time > 0 && mineralAmt >= 1)
		det_time--
		sleep(5)
	if(istype(src, /turf/closed/mineral/gibtonite))
		if(stage == GIBTONITE_ACTIVE && det_time <= 0 && mineralAmt >= 1)
			var/turf/bombturf = get_turf(src)
			mineralAmt = 0
			stage = GIBTONITE_DETONATE
			explosion(bombturf,1,3,5, adminlog = notify_admins)

/turf/closed/mineral/gibtonite/proc/defuse()
	if(stage == GIBTONITE_ACTIVE)
		cut_overlay(activated_overlay)
		activated_overlay.icon_state = "rock_Gibtonite_inactive"
		add_overlay(activated_overlay)
		desc = ""
		stage = GIBTONITE_STABLE
		if(det_time < 0)
			det_time = 0
		visible_message("<span class='notice'>The chain reaction was stopped! The gibtonite had [det_time] reactions left till the explosion!</span>")

/turf/closed/mineral/gibtonite/gets_drilled(mob/user, triggered_by_explosion = FALSE, give_exp = TRUE)
	if(stage == GIBTONITE_UNSTRUCK && mineralAmt >= 1) //Gibtonite deposit is activated
		playsound(src,'sound/blank.ogg',50,TRUE)
		explosive_reaction(user, triggered_by_explosion)
		return
	if(stage == GIBTONITE_ACTIVE && mineralAmt >= 1) //Gibtonite deposit goes kaboom
		var/turf/bombturf = get_turf(src)
		mineralAmt = 0
		stage = GIBTONITE_DETONATE
		explosion(bombturf,1,2,5, adminlog = 0)
	if(stage == GIBTONITE_STABLE) //Gibtonite deposit is now benign and extractable. Depending on how close you were to it blowing up before defusing, you get better quality ore.
		var/obj/item/twohanded/required/gibtonite/G = new (src)
		if(det_time <= 0)
			G.quality = 3
			G.icon_state = "Gibtonite ore 3"
		if(det_time >= 1 && det_time <= 2)
			G.quality = 2
			G.icon_state = "Gibtonite ore 2"

	var/flags = NONE
	if(defer_change)
		flags = CHANGETURF_DEFER_CHANGE
	ScrapeAway(null, flags)
	addtimer(CALLBACK(src, PROC_REF(AfterChange)), 1, TIMER_UNIQUE)


/turf/closed/mineral/gibtonite/volcanic
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1

/turf/closed/mineral/strong
	name = "Very strong rock"
	desc = ""
	environment_type = "basalt"
	turf_type = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	baseturfs = /turf/open/floor/plating/asteroid/basalt/lava_land_surface
	initial_gas_mix = LAVALAND_DEFAULT_ATMOS
	defer_change = 1
	smooth_icon = 'icons/turf/walls/rock_wall.dmi'

/turf/closed/mineral/strong/attackby(obj/item/I, mob/user, params)
	if(!ishuman(user))
		to_chat(usr, "<span class='warning'>Only a more advanced species could break a rock such as this one!</span>")
		return FALSE
	var/mob/living/carbon/human/H = user
	if(H.mind.get_skill_level(/datum/skill/mining) >= SKILL_LEVEL_LEGENDARY)
		. = ..()
	else
		to_chat(usr, "<span class='warning'>The rock seems to be too strong to destroy. Maybe I can break it once I become a master miner.</span>")


/turf/closed/mineral/strong/gets_drilled(user, triggered_by_explosion = FALSE, give_exp = TRUE)
	drop_ores()
	var/flags = NONE
	if(defer_change) // TODO: make the defer change var a var for any changeturf flag
		flags = CHANGETURF_DEFER_CHANGE
	ScrapeAway(flags=flags)
	addtimer(CALLBACK(src, PROC_REF(AfterChange)), 1, TIMER_UNIQUE)
	playsound(src, 'sound/blank.ogg', 50, TRUE) //beautiful destruction

/turf/closed/mineral/strong/proc/drop_ores()
	if(prob(10))
		new /obj/item/stack/sheet/mineral/mythril(src, 5)
	else
		new /obj/item/stack/sheet/mineral/adamantine(src, 5)

/turf/closed/mineral/strong/acid_melt()
	return

/turf/closed/mineral/strong/ex_act(severity, target)
	return



/turf/closed/mineral/random/rogue
//	layer = ABOVE_MOB_LAYER
	name = "rock"
	desc = "seems barren"
	icon = 'icons/turf/roguewall.dmi'
	icon_state = "minrandbad"
	smooth = SMOOTH_TRUE | SMOOTH_MORE
	smooth_icon = 'icons/turf/walls/cwall.dmi'
	wallclimb = TRUE
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	canSmoothWith = list(/turf/closed/mineral/random/rogue, /turf/closed/mineral/rogue)
	turf_type = /turf/open/floor/rogue/naturalstone
	above_floor = /turf/open/floor/rogue/naturalstone
	baseturfs = list(/turf/open/floor/rogue/naturalstone)
	mineralSpawnChanceList = list(/turf/closed/mineral/rogue/salt = 20, /turf/closed/mineral/rogue/copper = 15, /turf/closed/mineral/rogue/iron = 5, /turf/closed/mineral/rogue/coal = 5)
	mineralChance = 30
	max_integrity = 400

/turf/closed/mineral/random/rogue/med
	icon_state = "minrandmed"
=======
	/turf/closed/mineral/salt/cold = 20,
	/turf/closed/mineral/copper/cold = 15,
	/turf/closed/mineral/tin/cold = 12,
	/turf/closed/mineral/iron/cold = 5,
	/turf/closed/mineral/coal/cold = 5
	)

/turf/closed/mineral/random/med
	icon_state = MAP_SWITCH("mineral", "rand_med")
>>>>>>> upstream/main
	mineralChance = 50
	mineralSpawnChanceList = list(
	/turf/closed/mineral/salt = 20,
	/turf/closed/mineral/iron = 25,
	/turf/closed/mineral/coal = 20,
	/turf/closed/mineral/copper = 10,
	/turf/closed/mineral/tin = 10,
	/turf/closed/mineral/silver = 1
	)

/turf/closed/mineral/random/cold/med
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "rand_med_ice")
	mineralSpawnChanceList = list(
	/turf/closed/mineral/salt/cold = 20,
	/turf/closed/mineral/iron/cold = 25,
	/turf/closed/mineral/coal/cold = 20,
	/turf/closed/mineral/copper/cold = 10,
	/turf/closed/mineral/tin/cold = 10,
	/turf/closed/mineral/silver/cold = 1
	)

/turf/closed/mineral/random/high
	icon_state = MAP_SWITCH("mineral", "rand_high")
	mineralChance = 70
	mineralSpawnChanceList = list(
	/turf/closed/mineral/mana_crystal = 15,
	/turf/closed/mineral/cinnabar = 5,
	/turf/closed/mineral/gold = 15,
	/turf/closed/mineral/iron = 25,
	/turf/closed/mineral/silver = 15
	)

/turf/closed/mineral/random/cold/high
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "rand_high_ice")
	mineralSpawnChanceList = list(
	/turf/closed/mineral/mana_crystal/cold = 15,
	/turf/closed/mineral/cinnabar/cold = 5,
	/turf/closed/mineral/gold/cold = 15,
	/turf/closed/mineral/iron/cold = 25,
	/turf/closed/mineral/silver/cold = 15
	)

/turf/closed/mineral/random/low_nonval
	icon_state = MAP_SWITCH("mineral", "ctic_low")
	mineralChance = 30
	mineralSpawnChanceList = list(
	/turf/closed/mineral/copper = 15,
	/turf/closed/mineral/tin = 15,
	/turf/closed/mineral/iron = 25,
	/turf/closed/mineral/coal = 20
	)

/turf/closed/mineral/random/med_nonval
	icon_state = MAP_SWITCH("mineral", "ctic_med")
	mineralChance = 50
	mineralSpawnChanceList = list(/turf/closed/mineral/copper = 15,
	/turf/closed/mineral/tin = 15,
	/turf/closed/mineral/iron = 25,
	/turf/closed/mineral/coal = 20
	)

/turf/closed/mineral/random/high_nonval
	icon_state = MAP_SWITCH("mineral", "ctic_high")
	mineralChance = 70
	mineralSpawnChanceList = list(/turf/closed/mineral/mana_crystal = 10,
	/turf/closed/mineral/copper = 15,
	/turf/closed/mineral/tin = 15,
	/turf/closed/mineral/iron = 25,
	/turf/closed/mineral/coal = 20
	)

/turf/closed/mineral/random/low_valuable
	icon_state = MAP_SWITCH("mineral", "gsg_low")
	mineralChance = 30
	mineralSpawnChanceList = list(/turf/closed/mineral/mana_crystal = 10,
	/turf/closed/mineral/gold = 40 ,
	/turf/closed/mineral/gemeralds = 20,
	/turf/closed/mineral/silver = 40
	)

/turf/closed/mineral/random/med_valuable
	icon_state = MAP_SWITCH("mineral", "gsg_med")
	mineralChance = 50
	mineralSpawnChanceList = list(/turf/closed/mineral/mana_crystal = 10,
	/turf/closed/mineral/gold = 40,
	/turf/closed/mineral/gemeralds = 20,
	/turf/closed/mineral/silver = 40
	)

/turf/closed/mineral/random/high_valuable
	icon_state = MAP_SWITCH("mineral", "gsg_high")
	mineralChance = 70
	mineralSpawnChanceList = list(/turf/closed/mineral/mana_crystal = 10,
	/turf/closed/mineral/gold = 40 ,
	/turf/closed/mineral/gemeralds = 20,
	/turf/closed/mineral/silver = 40
	)

/turf/closed/mineral/copper
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "copper")
	mineralType = /obj/item/ore/copper
	rockType = /obj/item/natural/rock/copper
	spreadChance = 4
	spread = 3
	//maptext = "copper"

/turf/closed/mineral/copper/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "copper_ice")

/turf/closed/mineral/tin
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "tin")
	mineralType = /obj/item/ore/tin
	rockType = /obj/item/natural/rock/tin
	spreadChance = 15
	spread = 5
	//maptext = "tin"

/turf/closed/mineral/tin/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "tin_ice")

/turf/closed/mineral/silver
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "silver")
	mineralType = /obj/item/ore/silver
	rockType = /obj/item/natural/rock/silver
	spreadChance = 2
	spread = 2
	//maptext = "Silver"

/turf/closed/mineral/silver/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "silver_ice")

/turf/closed/mineral/gold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "gold")
	mineralType = /obj/item/ore/gold
	rockType = /obj/item/natural/rock/gold
	spreadChance = 2
	spread = 2
	//maptext = "gold"

/turf/closed/mineral/gold/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "gold_ice")

/turf/closed/mineral/salt
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "salt")
	mineralType = /obj/item/reagent_containers/powder/salt
	rockType = /obj/item/natural/rock/salt
	spreadChance = 12
	spread = 3
	//maptext = "salt"

/turf/closed/mineral/salt/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "salt_ice")

/turf/closed/mineral/cinnabar
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "gold")
	mineralType = /obj/item/ore/cinnabar
	rockType = /obj/item/natural/rock/cinnabar
	spreadChance = 23
	spread = 5
	//maptext = "cinnabar"

/turf/closed/mineral/cinnabar/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "gold_ice")

/turf/closed/mineral/mana_crystal
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "gold")
	mineralType = /obj/item/mana_battery/mana_crystal/standard
	rockType = /obj/item/natural/rock/mana_crystal
	spreadChance = 23
	spread = 5

/turf/closed/mineral/mana_crystal/cold

	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "gold_ice")

/obj/item/natural/rock/mana_crystal
	mineralType = /obj/item/mana_battery/mana_crystal/standard

/obj/item/natural/rock/cinnabar
	mineralType = /obj/item/ore/cinnabar

/turf/closed/mineral/iron
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "iron")
	mineralType = /obj/item/ore/iron
	rockType = /obj/item/natural/rock/iron
	spreadChance = 5
	spread = 3
	//maptext = "iron"

/turf/closed/mineral/iron/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "iron_ice")

/turf/closed/mineral/coal
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "coal")
	mineralType = /obj/item/ore/coal
	rockType = /obj/item/natural/rock/coal
	spreadChance = 3
	spread = 4

/turf/closed/mineral/coal/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "coal_ice")

/turf/closed/mineral/gemeralds
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "gem")
	mineralType = /obj/item/gem
	rockType = /obj/item/natural/rock/gemerald
	spreadChance = 3
	spread = 2

<<<<<<< HEAD
/turf/closed/mineral/rogue/bedrock
	name = "rock"
	desc = "seems too hard"
	icon_state = "rockyashbed"
	smooth_icon = 'icons/turf/walls/hardrock.dmi'
	max_integrity = 900
	above_floor = /turf/closed/mineral/rogue/bedrock

/turf/closed/mineral/rogue/bedrock/attackby(obj/item/I, mob/user, params)
	..()
	to_chat(user, "<span class='warning'>TOO HARD!</span>")
	turf_integrity = max_integrity

/turf/closed/mineral/rogue/bedrock/Initialize()
	. = ..()
	color = "#c6d9c6"

=======
/turf/closed/mineral/gemeralds/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "gem_ice")

/turf/closed/mineral/bedrock
	name = "rock"
	desc = "Seems barren, and nigh-indestructible."
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "bedrock")
	max_integrity = 10000000
	damage_deflection = 99999999
	above_floor = /turf/closed/mineral/bedrock

/turf/closed/mineral/bedrock/cold
	icon = MAP_SWITCH('icons/turf/smooth/walls/mineral_blue.dmi', 'icons/turf/mining.dmi')
	icon_state = MAP_SWITCH("mineral", "bedrock_ice")

/turf/closed/mineral/bedrock/attackby(obj/item/I, mob/user, list/modifiers)
	to_chat(user, span_warning("This is far too sturdy to be destroyed!"))
	return FALSE

/turf/closed/mineral/bedrock/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/closed/mineral/bedrock/acid_act(acidpwr, acid_volume, acid_id)
	return 0

/turf/closed/mineral/bedrock/Melt()
	to_be_destroyed = FALSE
	return src
>>>>>>> upstream/main
