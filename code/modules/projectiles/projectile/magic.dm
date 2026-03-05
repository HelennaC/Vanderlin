/obj/projectile/magic
	name = "bolt of nothing"
	icon_state = "energy"
	damage = 0
	damage_type = OXY
	nodamage = TRUE
	armor_penetration = 100
	pass_flags = PASSTABLE | PASSGRILLE
	flag = "magic"
	/// determines what type of antimagic can block the spell projectile
	var/antimagic_flags = MAGIC_RESISTANCE
	/// determines the drain cost on the antimagic item
	var/antimagic_charge_cost = 1

/obj/projectile/magic/prehit_pierce(mob/living/target)
	. = ..()
	if(istype(target) && target.can_block_magic(antimagic_flags, antimagic_charge_cost))
		visible_message(span_warning("[src] fizzles on contact with [target]!"))
		return PROJECTILE_DELETE_WITHOUT_HITTING

/obj/projectile/magic/death
	name = "bolt of death"
	icon_state = "pulse1_bl"

/obj/projectile/magic/death/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		if(isliving(M))
			var/mob/living/L = M
			if(L.mob_biotypes & MOB_UNDEAD) //negative energy heals the undead
				if(L.hellbound && L.stat == DEAD)
					return BULLET_ACT_BLOCK
				if(L.revive(ADMIN_HEAL_ALL))
					L.grab_ghost(force = TRUE) // even suicides
					to_chat(L, "<span class='notice'>I rise with a start, I'm undead!!!</span>")
				else if(L.stat != DEAD)
					to_chat(L, "<span class='notice'>I feel great!</span>")
			else
				L.death(0)
		else
			M.death(0)

/obj/projectile/magic/resurrection
	name = "bolt of resurrection"
	icon_state = "ion"
	damage = 0
	damage_type = OXY
	nodamage = TRUE

/obj/projectile/magic/resurrection/on_hit(mob/living/carbon/target)
	. = ..()
	if(isliving(target))
		if(target.mob_biotypes & MOB_UNDEAD) //positive energy harms the undead
			target.death(0)
		else
			if(target.hellbound && target.stat == DEAD)
				return BULLET_ACT_BLOCK
			if(target.revive(ADMIN_HEAL_ALL))
				target.grab_ghost(force = TRUE) // even suicides
				to_chat(target, "<span class='notice'>I rise with a start, you're alive!!!</span>")
			else if(target.stat != DEAD)
				to_chat(target, "<span class='notice'>I feel great!</span>")

/obj/projectile/magic/teleport
	name = "bolt of teleportation"
	icon_state = "bluespace"
	damage = 0
	damage_type = OXY
	nodamage = TRUE
	var/inner_tele_radius = 0
	var/outer_tele_radius = 6

/obj/projectile/magic/teleport/on_hit(mob/target)
	. = ..()
	var/teleammount = 0
	var/teleloc = target
	if(!isturf(target))
		teleloc = target.loc
	for(var/atom/movable/stuff in teleloc)
		if(!stuff.anchored && stuff.loc && !isobserver(stuff))
			if(do_teleport(stuff, stuff, 10, channel = TELEPORT_CHANNEL_MAGIC))
				teleammount++
				var/datum/effect_system/smoke_spread/smoke = new
				smoke.set_up(max(round(4 - teleammount),0), stuff.loc) //Smoke drops off if a lot of stuff is moved for the sake of sanity
				smoke.start()

/obj/projectile/magic/safety
	name = "bolt of safety"
	icon_state = "bluespace"
	damage = 0
	damage_type = OXY
	nodamage = TRUE

/obj/projectile/magic/safety/on_hit(atom/target)
	. = ..()
	if(isturf(target))
		return BULLET_ACT_HIT

	var/turf/origin_turf = get_turf(target)
	var/turf/destination_turf = find_safe_turf()

	if(do_teleport(target, destination_turf, channel=TELEPORT_CHANNEL_MAGIC))
		for(var/t in list(origin_turf, destination_turf))
			var/datum/effect_system/smoke_spread/smoke = new
			smoke.set_up(0, t)
			smoke.start()

<<<<<<< HEAD
/obj/projectile/magic/change
	name = "bolt of change"
	icon_state = "ice_1"
	damage = 0
	damage_type = BURN
	nodamage = TRUE

/obj/projectile/magic/change/on_hit(atom/change)
	. = ..()
	if(ismob(change))
		var/mob/M = change
		if(M.anti_magic_check())
			M.visible_message("<span class='warning'>[src] fizzles on contact with [M]!</span>")
			qdel(src)
			return BULLET_ACT_BLOCK
	wabbajack(change)
	qdel(src)

/proc/wabbajack(mob/living/M)
	if(!istype(M) || M.stat == DEAD || M.notransform || (GODMODE & M.status_flags))
		return

	M.notransform = TRUE
	M.mobility_flags = NONE
	M.icon = null
	M.cut_overlays()
	M.invisibility = INVISIBILITY_ABSTRACT

	var/list/contents = M.contents.Copy()

	for(var/obj/item/W in contents)
		if(!M.dropItemToGround(W))
			qdel(W)

	var/mob/living/new_mob

	var/randomize = pick("monkey","slime","humanoid","animal")
	switch(randomize)
		if("monkey")
			new_mob = new /mob/living/carbon/monkey(M.loc)

		if("slime")
			new_mob = new /mob/living/simple_animal/slime/random(M.loc)

		if("animal")
			var/path = pick(/mob/living/simple_animal/hostile/carp,
							/mob/living/simple_animal/hostile/bear,
							/mob/living/simple_animal/hostile/mushroom,
							/mob/living/simple_animal/hostile/statue,
							/mob/living/simple_animal/hostile/retaliate/bat,
							/mob/living/simple_animal/hostile/retaliate/goat,
							/mob/living/simple_animal/hostile/killertomato,
							/mob/living/simple_animal/hostile/poison/giant_spider,
							/mob/living/simple_animal/hostile/poison/giant_spider/hunter,
							/mob/living/simple_animal/hostile/blob/blobbernaut/independent,
							/mob/living/simple_animal/hostile/carp/ranged,
							/mob/living/simple_animal/hostile/carp/ranged/chaos,
							/mob/living/simple_animal/hostile/asteroid/basilisk/watcher,
							/mob/living/simple_animal/hostile/asteroid/goliath/beast,
							/mob/living/simple_animal/hostile/stickman,
							/mob/living/simple_animal/hostile/stickman/dog,
							/mob/living/simple_animal/hostile/megafauna/dragon/lesser,
							/mob/living/simple_animal/hostile/gorilla,
							/mob/living/simple_animal/parrot,
							/mob/living/simple_animal/pet/dog/corgi,
							/mob/living/simple_animal/crab,
							/mob/living/simple_animal/pet/dog/pug,
							/mob/living/simple_animal/pet/cat,
							/mob/living/simple_animal/mouse,
							/mob/living/simple_animal/chicken,
							/mob/living/simple_animal/cow,
							/mob/living/simple_animal/hostile/lizard,
							/mob/living/simple_animal/pet/fox,
							/mob/living/simple_animal/butterfly,
							/mob/living/simple_animal/pet/cat/cak,
							/mob/living/simple_animal/chick)
			new_mob = new path(M.loc)

		if("humanoid")
			new_mob = new /mob/living/carbon/human(M.loc)

			if(prob(50))
				var/list/chooseable_races = list()
				for(var/speciestype in subtypesof(/datum/species))
					var/datum/species/S = speciestype
					if(initial(S.changesource_flags) & WABBAJACK)
						chooseable_races += speciestype

				if(chooseable_races.len)
					new_mob.set_species(pick(chooseable_races))

			var/datum/preferences/A = new()	//Randomize appearance for the human
			A.copy_to(new_mob, icon_updates=0)

			var/mob/living/carbon/human/H = new_mob
			H.update_body()
			H.update_hair()
			H.update_body_parts()
			H.dna.update_dna_identity()

	if(!new_mob)
		return
	new_mob.grant_language(/datum/language/common)

	// Some forms can still wear some items
	for(var/obj/item/W in contents)
		new_mob.equip_to_appropriate_slot(W)

	M.log_message("became [new_mob.real_name]", LOG_ATTACK, color="orange")

	new_mob.a_intent = INTENT_HARM

	M.wabbajack_act(new_mob)

	to_chat(new_mob, "<span class='warning'>My form morphs into that of a [randomize].</span>")

	var/poly_msg = get_policy(POLICY_POLYMORPH)
	if(poly_msg)
		to_chat(new_mob, poly_msg)

	M.transfer_observers_to(new_mob)

	qdel(M)
	return new_mob

/obj/projectile/magic/animate
	name = "bolt of animation"
	icon_state = "red_1"
	damage = 0
	damage_type = BURN
	nodamage = TRUE

/obj/projectile/magic/animate/on_hit(atom/target, blocked = FALSE)
	target.animate_atom_living(firer)
	..()

/atom/proc/animate_atom_living(mob/living/owner = null)
	if((isitem(src) || isstructure(src)) && !is_type_in_list(src, GLOB.protected_objects))
		if(istype(src, /obj/structure/statue/petrified))
			var/obj/structure/statue/petrified/P = src
			if(P.petrified_mob)
				var/mob/living/L = P.petrified_mob
				var/mob/living/simple_animal/hostile/statue/S = new(P.loc, owner)
				S.name = "statue of [L.name]"
				if(owner)
					S.faction = list("[REF(owner)]")
				S.icon = P.icon
				S.icon_state = P.icon_state
				S.copy_overlays(P, TRUE)
				S.color = P.color
				S.atom_colours = P.atom_colours.Copy()
				if(L.mind)
					L.mind.transfer_to(S)
					if(owner)
						to_chat(S, "<span class='danger'>I are an animate statue. You cannot move when monitored, but are nearly invincible and deadly when unobserved! Do not harm [owner], my creator.</span>")
				P.forceMove(S)
				return
		else
			var/obj/O = src
			if(istype(O, /obj/item/gun))
				new /mob/living/simple_animal/hostile/mimic/copy/ranged(loc, src, owner)
			else
				new /mob/living/simple_animal/hostile/mimic/copy(loc, src, owner)

	else if(istype(src, /mob/living/simple_animal/hostile/mimic/copy))
		// Change our allegiance!
		var/mob/living/simple_animal/hostile/mimic/copy/C = src
		if(owner)
			C.ChangeOwner(owner)

=======
>>>>>>> upstream/main
/obj/projectile/magic/spellblade
	name = "blade energy"
	icon_state = "lavastaff"
	damage = 15
	damage_type = BURN
	flag = "magic"
	dismemberment = 50
	nodamage = FALSE

/obj/projectile/magic/arcane_barrage
	name = "arcane bolt"
	icon_state = "arcane_barrage"
	damage = 20
	damage_type = BURN
	nodamage = FALSE
	armor_penetration = 0
	flag = "magic"
	hitsound = 'sound/blank.ogg'

/obj/projectile/magic/flying
	name = "bolt of flying"
	icon_state = "flight"

/obj/projectile/magic/flying/on_hit(target)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		var/atom/throw_target = get_edge_target_turf(L, angle2dir(Angle))
		L.throw_at(throw_target, 200, 4)

/obj/projectile/magic/bounty
	name = "bolt of bounty"
	icon_state = "bounty"

/obj/projectile/magic/bounty/on_hit(target)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.apply_status_effect(STATUS_EFFECT_BOUNTY, null, firer)

/obj/projectile/magic/antimagic
	name = "bolt of antimagic"
	icon_state = "antimagic"

/obj/projectile/magic/antimagic/on_hit(target)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		L.apply_status_effect(STATUS_EFFECT_ANTIMAGIC)

/obj/projectile/magic/fetch
	name = "bolt of fetching"
	icon_state = "cursehand0"
	range = 15

/obj/projectile/magic/fetch/on_hit(target)
	. = ..()
	var/atom/throw_target = get_step(firer, get_dir(firer, target))
	if(isliving(target))
		var/mob/living/L = target
		L.throw_at(throw_target, 200, 3) //4 is the default threshold speed to embed
	else
		if(isitem(target))
			var/obj/item/I = target
			var/mob/living/carbon/human/carbon_firer
			if (ishuman(firer))
				carbon_firer = firer
				if (carbon_firer?.can_catch_item())
					throw_target = get_turf(firer)
			I.throw_at(throw_target, 200, 3)

/obj/projectile/magic/sapping
	name = "bolt of sapping"
	icon_state = "sapping"

/obj/projectile/magic/sapping/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/M = target
		M.add_stress(/datum/stress_event/sapped)

/obj/projectile/magic/necropotence
	name = "bolt of necropotence"
	icon_state = "necropotence"

/obj/projectile/magic/necropotence/on_hit(target)
	. = ..()
	if(isliving(target))
		var/mob/living/L = target
		to_chat(L, "<span class='danger'>My body feels drained and there is a burning pain in my chest.</span>")
		L.setMaxHealth(L.maxHealth - 20)
		L.set_health(L.health)
		if(L.getMaxHealth() <= 0)
			to_chat(L, "<span class='danger'>My weakened soul is completely consumed by the [src]!</span>")
			L.mind.hasSoul = FALSE
		for(var/datum/action/cooldown/spell/spell in L.actions)
			spell.StartCooldown()

/obj/projectile/magic/aoe
	name = "Area Bolt"
	desc = ""
	damage = 0
	var/aoe_range = 0
	var/proxdet = TRUE

/obj/projectile/magic/aoe/Range()
	if(proxdet)
		for(var/mob/living/L in range(aoe_range, get_turf(src)))
			if(L.stat != DEAD && L != firer && !L.can_block_magic(MAGIC_RESISTANCE))
				return Bump(L)
	..()


/obj/projectile/magic/aoe/fireball
	name = "bolt of fireball"
	icon_state = "fireball"
	damage = 10
	damage_type = BRUTE
	nodamage = FALSE
	light_color = "#f8af07"
	light_outer_range =  2

	//explosion values
	var/exp_devi = -1
	var/exp_heavy = 0
	var/exp_light = 2
	var/exp_flash = 3
	var/exp_fire = 2
	var/exp_hotspot = 0
	var/explode_sound = list('sound/misc/explode/incendiary (1).ogg','sound/misc/explode/incendiary (2).ogg')

/obj/projectile/magic/aoe/fireball/on_hit(target)
	. = ..()
	if(ismob(target))
		var/mob/living/M = target
		M.adjust_fire_stacks(6)
		M.IgniteMob()

	var/turf/T
	if(isturf(target))
		if(isclosedturf(target))
			var/hitdevi = 0
			var/hitheavy = 0
			var/hitlight = 0
			if(exp_devi > 0)
				hitdevi = 1
			if(exp_heavy > 0)
				hitheavy = 1
			if(exp_light > 0)
				hitlight = 1
			explosion(get_turf(target), hitdevi, hitheavy, hitlight, 0, 0, 0, visfx = "firespark", soundin = null)
			var/datum/point/vector/previous = trajectory.return_vector_after_increments(1,-1)
			T = previous.return_turf()
			explosion(T, exp_devi, exp_heavy, exp_light, exp_flash, 0, flame_range = exp_fire, hotspot_range = exp_hotspot, soundin = explode_sound)
			return TRUE
		else
			T = target
	else
		T = get_turf(target)
	explosion(T, 0, 0, 0, exp_flash, 0, flame_range = exp_fire, hotspot_range = exp_hotspot, soundin = explode_sound)
	cell_explosion(T, exp_light * 5, 0.1)
