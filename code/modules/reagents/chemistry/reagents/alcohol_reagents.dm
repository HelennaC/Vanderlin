////////////// I don't know who made this header before I refactored alcohols but I'm going to fucking strangle them because it was so ugly, holy Christ
// ALCOHOLS //
//////////////
#define ALCOHOL_THRESHOLD_MODIFIER 1 //Greater numbers mean that less alcohol has greater intoxication potential
#define ALCOHOL_EXPONENT 1.6 //The exponent applied to boozepwr to make higher volume alcohol at least a little bit damaging to the liver

/datum/reagent/consumable/ethanol
	name = "Ethanol"
	description = "A well-known alcohol with a variety of applications."
	color = "#404030" // rgb: 64, 64, 48
	nutriment_factor = 0
	taste_description = "alcohol"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	liquid_fire_power = 10
	hydration_factor = 10
	var/boozepwr = 65 //Higher numbers equal higher hardness, higher hardness equals more intense alcohol poisoning
	var/datum/reagent/age_path
	var/age_time = 10 MINUTES
	var/age_timer

/datum/reagent/consumable/ethanol/New()
	. = ..()
	if(age_path && holder)
		age_timer = addtimer(CALLBACK(src, PROC_REF(age_beer)), age_time, TIMER_OVERRIDE | TIMER_STOPPABLE | TIMER_UNIQUE)

/datum/reagent/consumable/ethanol/on_merge(data, amount)
	. = ..()
	if(age_path && holder)
		var/timeleft = timeleft(age_timer)
		var/total_amount = volume + amount

		var/existing_progress = (volume / total_amount) * (age_time - timeleft)
		var/new_progress = (amount / total_amount) * age_time
		var/adjusted_progress = existing_progress + new_progress

		age_timer = addtimer(CALLBACK(src, PROC_REF(age_beer)), adjusted_progress, TIMER_OVERRIDE | TIMER_STOPPABLE | TIMER_UNIQUE)

/datum/reagent/consumable/ethanol/proc/age_beer()
	var/old_volume = volume
	var/datum/reagents/old_holder = holder
	holder?.remove_reagent(src.type, volume)
	old_holder?.add_reagent(age_path, old_volume)
/*
Boozepwr Chart
Note that all higher effects of alcohol poisoning will inherit effects for smaller amounts (i.e. light poisoning inherts from slight poisoning)
In addition, severe effects won't always trigger unless the drink is poisonously strong
All effects don't start immediately, but rather get worse over time; the rate is affected by the imbiber's alcohol tolerance

0: Non-alcoholic
1-10: Barely classifiable as alcohol - occassional slurring
11-20: Slight alcohol content - slurring
21-30: Below average - imbiber begins to look slightly drunk
31-40: Just below average - no unique effects
41-50: Average - mild disorientation, imbiber begins to look drunk
51-60: Just above average - disorientation, vomiting, imbiber begins to look heavily drunk
61-70: Above average - small chance of blurry vision, imbiber begins to look smashed
71-80: High alcohol content - blurry vision, imbiber completely shitfaced
81-90: Extremely high alcohol content - heavy toxin damage, passing out
91-100: Dangerously toxic - swift death
*/

/datum/reagent/consumable/ethanol/on_mob_life(mob/living/carbon/C)
	if(C.drunkenness < volume * boozepwr * ALCOHOL_THRESHOLD_MODIFIER || boozepwr < 0)
		var/booze_power = boozepwr
		C.drunkenness = max((C.drunkenness + (sqrt(volume) * booze_power * ALCOHOL_RATE)), 0) //Volume, power, and server alcohol rate effect how quickly one gets drunk
	return ..()

/datum/reagent/consumable/ethanol/reaction_obj(obj/O, reac_volume)
	if(istype(O, /obj/item/paper))
		var/obj/item/paper/paperaffected = O
		paperaffected.clearpaper()
		to_chat(usr, "<span class='notice'>[paperaffected]'s ink washes away.</span>")
	if(istype(O, /obj/item/book))
		if(reac_volume >= 5)
			var/obj/item/book/affectedbook = O
			affectedbook.dat = null
			O.visible_message("<span class='notice'>[O]'s writing is washed away by [name]!</span>")
		else
			O.visible_message("<span class='warning'>[O]'s ink is smeared by [name], but doesn't wash away!</span>")
	return

/datum/reagent/consumable/ethanol/reaction_mob(mob/living/M, method=TOUCH, reac_volume)//Splashing people with ethanol isn't quite as good as fuel.
	if(!isliving(M))
		return

	if(method in list(TOUCH, VAPOR, PATCH))
		M.adjust_fire_stacks(reac_volume / 15)

	return ..()

/datum/reagent/consumable/ethanol/beer
	name = "Beer"
	description = ""
	color = "#a17c10" // rgb: 102, 67, 0
	nutriment_factor = 0.1
	boozepwr = 25
	taste_description = "ale"
	glass_name = "glass of beer"
	glass_desc = ""

/datum/reagent/consumable/ethanol/rum
	name = "Rum"
	description = ""
	color = "#5f3b23" // rgb: 102, 67, 0
	boozepwr = 25
	taste_description = "rum"

/datum/reagent/consumable/ethanol/cider
	name = "Apple Cider"
	boozepwr = 40
	taste_description = "cider"
	glass_name = "glass of cider"
	color = "#d8a175"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/cider/pear
	name = "Pear Cider"
	color = "#6aa945"

/datum/reagent/consumable/ethanol/cider/strawberry
	name = "Strawberry Cider"
	color = "#da4d4d"
	taste_description = "strawberry cider"

/datum/reagent/consumable/ethanol/aqua_vitae
	name = "Aqua Vitae"
	boozepwr = 150
	taste_description = "death"
	color = "#6e6e6e"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/brandy
	name = "Apple Brandy"
	boozepwr = 60
	taste_description = "brandy"
	glass_name = "glass of brandy"
	color = "#6aa945"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/brandy/pear
	name = "Pear Brandy"

/datum/reagent/consumable/ethanol/brandy/strawberry
	name = "Strawberry Brandy"
	color = "#bb1a1a"

/datum/reagent/consumable/ethanol/brandy/tangerine
	name = "Tangerine Brandy"
	color = "#bb751a"

/datum/reagent/consumable/ethanol/brandy/plum
	name = "Plum Brandy"
	color = "#5c0449"

/datum/reagent/consumable/ethanol/wine
	name = "Wine"
	boozepwr = 30
	taste_description = "wine"
	glass_name = "glass of wine"
	color = "#8a0b0b"

/datum/reagent/consumable/ethanol/ale
	name = "Ale"
	description = "A dark alcoholic beverage made with malted barley and yeast."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 65
	taste_description = "hearty barley ale"
	glass_icon_state = "aleglass"
	glass_name = "glass of ale"
	glass_desc = ""


// BEERS - Imported for now, later the styles will be 'mockable', if and when I get to brewing.

// Humen Production - Underwhelming, but cheap.

/datum/reagent/consumable/ethanol/gin
	name = "Gin"
	boozepwr = 12
	taste_description = "fruity"
	color = "#809978"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/spottedhen
	name = "Spotted Hen"
	boozepwr = 15
	taste_description = "cheap pisswater"
	color = "#DBD77F"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/hagwoodbitter
	name = "Hagwood Bitter"
	boozepwr = 25
	taste_description = "dull crispness"
	color = "#BBB525"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/blackgoat
	name = "Black Gote Kriek"
	boozepwr = 25
	taste_description = "overwhelming sourness"
	color = "#401806"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/onion
	name = "Royal Onion Cognac"
	boozepwr = 10
	taste_description = "spicy sweet malty overtones"
	color = "#683e00"
	quality = DRINK_NICE

// Elf Production - LEAF-LOVERS MOTHERFUCKER

<<<<<<< HEAD
/datum/reagent/consumable/ethanol/whiskey_cola
	name = "Whiskey Cola"
	description = "Whiskey, mixed with cola. Surprisingly refreshing."
	color = "#3E1B00" // rgb: 62, 27, 0
	boozepwr = 70
=======
/datum/reagent/consumable/ethanol/aurorian
	name = "Aurorian"
	boozepwr = 5
	taste_description = "subtle herbaceous undertones"
	color = "#5D8A8A"
>>>>>>> upstream/main
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/fireleaf // cabbbage
	name = "Fireleaf"
	boozepwr = 2
	taste_description = "bland liquor"
	color = "#475e45"
	quality = DRINK_NICE

// Dwarven Production - Best in the Realms

<<<<<<< HEAD
/datum/reagent/consumable/ethanol/white_russian
	name = "White Russian"
	description = "That's just, like, my opinion, man..."
	color = "#A68340" // rgb: 166, 131, 64
	boozepwr = 50
	quality = DRINK_GOOD
	taste_description = "bitter cream"
	glass_icon_state = "whiterussianglass"
	glass_name = "White Russian"
	glass_desc = ""

/datum/reagent/consumable/ethanol/screwdrivercocktail
	name = "Screwdriver"
	description = "Vodka, mixed with plain ol' orange juice. The result is surprisingly delicious."
	color = "#A68310" // rgb: 166, 131, 16
	boozepwr = 55
	quality = DRINK_NICE
	taste_description = "oranges"
	glass_icon_state = "screwdriverglass"
	glass_name = "Screwdriver"
	glass_desc = ""

/datum/reagent/consumable/ethanol/screwdrivercocktail/on_mob_life(mob/living/carbon/M)
	if(M.mind && (M.mind.assigned_role in list("Station Engineer", "Atmospheric Technician", "Chief Engineer"))) //Engineers lose radiation poisoning at a massive rate.
		M.radiation = max(M.radiation - 25, 0)
	return ..()

/datum/reagent/consumable/ethanol/booger
	name = "Booger"
	description = "Ewww..."
	color = "#8CFF8C" // rgb: 140, 255, 140
	boozepwr = 45
	taste_description = "sweet 'n creamy"
	glass_icon_state = "booger"
	glass_name = "Booger"
	glass_desc = ""

/datum/reagent/consumable/ethanol/bloody_mary
	name = "Bloody Mary"
	description = "A strange yet pleasurable mixture made of vodka, tomato and lime juice. Or at least you THINK the red stuff is tomato juice."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 55
	quality = DRINK_GOOD
	taste_description = "tomatoes with a hint of lime"
	glass_icon_state = "bloodymaryglass"
	glass_name = "Bloody Mary"
	glass_desc = ""

/datum/reagent/consumable/ethanol/bloody_mary/on_mob_life(mob/living/carbon/C)
	if(C.blood_volume < BLOOD_VOLUME_NORMAL)
		C.blood_volume = min(BLOOD_VOLUME_NORMAL, C.blood_volume + 3) //Bloody Mary quickly restores blood loss.
	..()

/datum/reagent/consumable/ethanol/brave_bull
	name = "Brave Bull"
	description = "It's just as effective as Dutch-Courage!"
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 60
	quality = DRINK_NICE
	taste_description = "alcoholic bravery"
	glass_icon_state = "bravebullglass"
	glass_name = "Brave Bull"
	glass_desc = ""
	var/tough_text

/datum/reagent/consumable/ethanol/brave_bull/on_mob_metabolize(mob/living/M)
	tough_text = pick("brawny", "tenacious", "tough", "hardy", "sturdy") //Tuff stuff
	to_chat(M, "<span class='notice'>I feel [tough_text]!</span>")
	M.maxHealth += 10 //Brave Bull makes you sturdier, and thus capable of withstanding a tiny bit more punishment.
	M.health += 10

/datum/reagent/consumable/ethanol/brave_bull/on_mob_end_metabolize(mob/living/M)
	to_chat(M, "<span class='notice'>I no longer feel [tough_text].</span>")
	M.maxHealth -= 10
	M.health = min(M.health - 10, M.maxHealth) //This can indeed crit you if you're alive solely based on alchol ingestion

/datum/reagent/consumable/ethanol/tequila_sunrise
	name = "Tequila Sunrise"
	description = "Tequila, Grenadine, and Orange Juice."
	color = "#FFE48C" // rgb: 255, 228, 140
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "oranges with a hint of pomegranate"
	glass_icon_state = "tequilasunriseglass"
	glass_name = "tequila Sunrise"
	glass_desc = ""
	var/obj/effect/light_holder

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_metabolize(mob/living/M)
	to_chat(M, "<span class='notice'>I feel gentle warmth spread through my body!</span>")
	light_holder = new(M)
	light_holder.set_light(3,3,0.7, l_color = "#FFCC00") //Tequila Sunrise makes you radiate dim light, like a sunrise!

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_life(mob/living/carbon/M)
	if(QDELETED(light_holder))
		M.reagents.del_reagent(/datum/reagent/consumable/ethanol/tequila_sunrise) //If we lost our light object somehow, remove the reagent
	else if(light_holder.loc != M)
		light_holder.forceMove(M)
	return ..()

/datum/reagent/consumable/ethanol/tequila_sunrise/on_mob_end_metabolize(mob/living/M)
	to_chat(M, "<span class='notice'>The warmth in my body fades.</span>")
	QDEL_NULL(light_holder)

/datum/reagent/consumable/ethanol/toxins_special
	name = "Toxins Special"
	description = "This thing is ON FIRE! CALL THE DAMN SHUTTLE!"
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 25
	quality = DRINK_VERYGOOD
	taste_description = "spicy toxins"
	glass_icon_state = "toxinsspecialglass"
	glass_name = "Toxins Special"
	glass_desc = ""
	shot_glass_icon_state = "toxinsspecialglass"

/datum/reagent/consumable/ethanol/toxins_special/on_mob_life(mob/living/M)
	M.adjust_bodytemperature(15 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL + 20) //310.15 is the normal bodytemp.
	return ..()

/datum/reagent/consumable/ethanol/beepsky_smash
	name = "Beepsky Smash"
	description = "Drink this and prepare for the LAW."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 60 //THE FIST OF THE LAW IS STRONG AND HARD
	quality = DRINK_GOOD
	metabolization_rate = 0.5
	taste_description = "JUSTICE"
	glass_icon_state = "beepskysmashglass"
	glass_name = "Beepsky Smash"
	glass_desc = ""
	overdose_threshold = 40
	var/datum/brain_trauma/special/beepsky/B

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_metabolize(mob/living/carbon/M)
	if(HAS_TRAIT(M, TRAIT_ALCOHOL_TOLERANCE))
		metabolization_rate = 0.8
	if(!HAS_TRAIT(M.mind, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		B = new()
		M.gain_trauma(B, TRAUMA_RESILIENCE_ABSOLUTE)
	..()

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_life(mob/living/carbon/M)
	M.Jitter(2)
	if(HAS_TRAIT(M.mind, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		M.adjustStaminaLoss(-10, 0)
		if(prob(20))
			new /datum/hallucination/items_other(M)
		if(prob(10))
			new /datum/hallucination/stray_bullet(M)
	..()
	. = 1

/datum/reagent/consumable/ethanol/beepsky_smash/on_mob_end_metabolize(mob/living/carbon/M)
	if(B)
		QDEL_NULL(B)
	return ..()

/datum/reagent/consumable/ethanol/beepsky_smash/overdose_start(mob/living/carbon/M)
	if(!HAS_TRAIT(M.mind, TRAIT_LAW_ENFORCEMENT_METABOLISM))
		M.gain_trauma(/datum/brain_trauma/mild/phobia/security, TRAUMA_RESILIENCE_BASIC)

/datum/reagent/consumable/ethanol/irish_cream
	name = "Irish Cream"
	description = "Whiskey-imbued cream, what else would you expect from the Irish?"
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 50
	quality = DRINK_NICE
	taste_description = "creamy alcohol"
	glass_icon_state = "irishcreamglass"
	glass_name = "Irish Cream"
	glass_desc = ""

/datum/reagent/consumable/ethanol/manly_dorf
	name = "The Manly Dorf"
	description = "Beer and Ale, brought together in a delicious mix. Intended for true men only."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 100 //For the manly only
	quality = DRINK_NICE
	taste_description = "hair on my chest and my chin"
	glass_icon_state = "manlydorfglass"
	glass_name = "The Manly Dorf"
	glass_desc = ""
	var/dorf_mode

/datum/reagent/consumable/ethanol/manly_dorf/on_mob_metabolize(mob/living/M)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(H.dna.check_mutation(DWARFISM) || HAS_TRAIT(H, TRAIT_ALCOHOL_TOLERANCE))
			to_chat(H, "<span class='notice'>Now THAT is MANLY!</span>")
			boozepwr = 5 //We've had worse in the mines
			dorf_mode = TRUE

/datum/reagent/consumable/ethanol/manly_dorf/on_mob_life(mob/living/carbon/M)
	if(dorf_mode)
		M.adjustBruteLoss(-2)
		M.adjustFireLoss(-2)
	return ..()

/datum/reagent/consumable/ethanol/longislandicedtea
	name = "Long Island Iced Tea"
	description = "The liquor cabinet, brought together in a delicious mix. Intended for middle-aged alcoholic women only."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "a mixture of cola and alcohol"
	glass_icon_state = "longislandicedteaglass"
	glass_name = "Long Island Iced Tea"
	glass_desc = ""


/datum/reagent/consumable/ethanol/moonshine
	name = "Moonshine"
	description = "You've really hit rock bottom now... my liver packed its bags and left last night."
	color = "#AAAAAA77" // rgb: 170, 170, 170, 77 (alpha) (like water)
	boozepwr = 95
	taste_description = "bitterness"
	glass_icon_state = "glass_clear"
	glass_name = "Moonshine"
	glass_desc = ""

/datum/reagent/consumable/ethanol/b52
	name = "B-52"
	description = "Coffee, Irish Cream, and cognac. You will get bombed."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 85
	quality = DRINK_GOOD
	taste_description = "angry and irish"
	glass_icon_state = "b52glass"
	glass_name = "B-52"
	glass_desc = ""
	shot_glass_icon_state = "b52glass"

/datum/reagent/consumable/ethanol/b52/on_mob_metabolize(mob/living/M)
	playsound(M, 'sound/blank.ogg', 100, FALSE)

/datum/reagent/consumable/ethanol/irishcoffee
	name = "Irish Coffee"
	description = "Coffee, and alcohol. More fun than a Mimosa to drink in the morning."
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "giving up on the day"
	glass_icon_state = "irishcoffeeglass"
	glass_name = "Irish Coffee"
	glass_desc = ""

/datum/reagent/consumable/ethanol/margarita
	name = "Margarita"
	description = "On the rocks with salt on the rim. Arriba~!"
	color = "#8CFF8C" // rgb: 140, 255, 140
	boozepwr = 35
	quality = DRINK_NICE
	taste_description = "dry and salty"
	glass_icon_state = "margaritaglass"
	glass_name = "Margarita"
	glass_desc = ""

/datum/reagent/consumable/ethanol/black_russian
	name = "Black Russian"
	description = "For the lactose-intolerant. Still as classy as a White Russian."
	color = "#360000" // rgb: 54, 0, 0
	boozepwr = 70
	quality = DRINK_NICE
	taste_description = "bitterness"
	glass_icon_state = "blackrussianglass"
	glass_name = "Black Russian"
	glass_desc = ""


/datum/reagent/consumable/ethanol/manhattan
	name = "Manhattan"
	description = "The Detective's undercover drink of choice. He never could stomach gin..."
	color = "#664300" // rgb: 102, 67, 0
=======
/datum/reagent/consumable/ethanol/butterhairs
	name = "Butterhairs"
>>>>>>> upstream/main
	boozepwr = 30
	taste_description = "buttery richness"
	color = "#5D8A8A"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/stonebeards
	name = "Stonebeard Reserve"
	boozepwr = 40
	taste_description = "potent oatlike liquor"
	color = "#5D8A8A"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/voddena // Not vodka. Trust me.
	name = "Voddena"
	boozepwr = 55  // holy shit
	taste_description = "burning starchy wet dirt"
	color = "#a1a1a1"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/limoncello
	name = "Limoncello"
	boozepwr = 45  // holy shit
	taste_description = "burning and lemony"
	color = "#d2da63"
	quality = DRINK_GOOD

// WINE - Fancy.. And yes: all drinks are beer, technically. Cope. Seethe. I didnt code it like this.

// Humen Production - Grape Based

/datum/reagent/consumable/ethanol/sourwine // Peasant grade shit.
	name = "Sour Wine"
	boozepwr = 20
	taste_description = "sour wine"
	color = "#552b4b"

/datum/reagent/consumable/ethanol/whitewine
	name = "White Wine"
	boozepwr = 30
	taste_description = "sweet white wine"
	color = "#F3ED91"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/redwine
	name = "Red Wine"
	boozepwr = 30
	taste_description = "tannin-stricken wine"
	color = "#571111"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/jackberrywine
	name = "Jacksberry Wine"
	boozepwr = 15
	taste_description = "sickly sweet young wine"
	color = "#3b2342"
	quality = DRINK_NICE
	age_path = /datum/reagent/consumable/ethanol/jackberrywine/aged
	age_time = 10 MINUTES

/datum/reagent/consumable/ethanol/jackberrywine/aged
	name = "Aged Jacksberry Wine"
	boozepwr = 30
	taste_description = "sickly sweet aged wine"
	color = "#402249"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/jackberrywine/delectable

/datum/reagent/consumable/ethanol/jackberrywine/delectable
	name = "Delectable Jacksberry Wine"
	boozepwr = 30
	taste_description = "sickly sweet delectably aged wine"
	color = "#652679"
	quality = DRINK_VERYGOOD
	age_path = null

/datum/reagent/consumable/ethanol/plum_wine
	name = "Umeshu"
	boozepwr = 15
	taste_description = "sickly sweet young wine"
	color = "#c997d8"
	quality = DRINK_NICE
	age_path = /datum/reagent/consumable/ethanol/plum_wine/aged
	age_time = 10 MINUTES

/datum/reagent/consumable/ethanol/plum_wine/aged
	name = "Aged Umeshu"
	boozepwr = 30
	taste_description = "sickly sweet aged wine"
	color = "#c27cd8"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/plum_wine/delectable

/datum/reagent/consumable/ethanol/plum_wine/delectable
	name = "Delectable Umeshu"
	boozepwr = 30
	taste_description = "sickly sweet delectably aged wine"
	color = "#a854c2"
	quality = DRINK_VERYGOOD
	age_path = null

/datum/reagent/consumable/ethanol/tangerine
	name = "Tangerine Wine"
	boozepwr = 15
	taste_description = "bittersweet young wine"
	color = "#e7aa59"
	quality = DRINK_NICE
	age_path = /datum/reagent/consumable/ethanol/tangerine/aged

/datum/reagent/consumable/ethanol/tangerine/aged
	name = "Aged Tangerine Wine"
	boozepwr = 30
	taste_description = "bittersweet aged wine"
	color = "#d68d2d"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/tangerine/delectable

/datum/reagent/consumable/ethanol/tangerine/delectable
	name = "Delectable Tangerine Wine"
	boozepwr = 30
	taste_description = "bittersweet delectably aged wine"
	color = "#eb9321"
	quality = DRINK_VERYGOOD
	age_path = null

/datum/reagent/consumable/ethanol/raspberry
	name = "Raspberry Wine"
	boozepwr = 15
	taste_description = "bittersweet young wine"
	color = "#ee5ea6"
	quality = DRINK_NICE
	age_path = /datum/reagent/consumable/ethanol/raspberry/aged

/datum/reagent/consumable/ethanol/raspberry/aged
	name = "Aged Raspberry Wine"
	boozepwr = 30
	taste_description = "bittersweet aged wine"
	color = "#d83788"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/raspberry/delectable

/datum/reagent/consumable/ethanol/raspberry/delectable
	name = "Delectable Raspberry Wine"
	boozepwr = 30
	taste_description = "bittersweet delectably aged wine"
	color = "#db0d74"
	quality = DRINK_VERYGOOD
	age_path = null

/datum/reagent/consumable/ethanol/blackberry
	name = "Blackberry Wine"
	boozepwr = 15
	taste_description = "bitter tart young wine"
	color = "#861491"
	quality = DRINK_NICE
	age_path = /datum/reagent/consumable/ethanol/blackberry/aged

/datum/reagent/consumable/ethanol/blackberry/aged
	name = "Aged Blackberry Wine"
	boozepwr = 30
	taste_description = "bitter tart aged wine"
	color = "#58065f"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/blackberry/delectable

/datum/reagent/consumable/ethanol/blackberry/delectable
	name = "Delectable Blackberry Wine"
	boozepwr = 30
	taste_description = "bitter tart delectably aged wine"
	color = "#330038"
	quality = DRINK_VERYGOOD
	age_path = null

/datum/reagent/consumable/ethanol/tiefling
	name = "Tiefling Blood Wine"
	boozepwr = 15
	taste_description = "bitter young wine"
	color = "#b32525"
	quality = DRINK_NICE
	glows = TRUE
	age_path = /datum/reagent/consumable/ethanol/tiefling/aged

/datum/reagent/consumable/ethanol/tiefling/aged
	name = "Aged Tiefling Blood Wine"
	boozepwr = 30
	taste_description = "bitter aged wine"
	color = "#e21313"
	quality = DRINK_GOOD
	age_path = /datum/reagent/consumable/ethanol/tiefling/delectable

/datum/reagent/consumable/ethanol/tiefling/delectable
	name = "Delectable Tiefling Blood Wine"
	boozepwr = 30
	taste_description = "bitter delectably aged wine"
	color = "#ff0000"
	quality = DRINK_VERYGOOD
	age_path = null

// Elf Production - Berries & Herbal

/datum/reagent/consumable/ethanol/elfred
	name = "Elven Red"
	boozepwr = 15
	taste_description = "delectable fruity notes"
	color = "#6C0000"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/elfblue
	name = "Valmora Blue"
	boozepwr = 50
	taste_description = "saintly sweetness"
	color = "#2C9DAF"
	quality = DRINK_FANTASTIC

/datum/reagent/consumable/ethanol/jagdtrunk // JÄGERMEISTER!!!!
	name = "Jagdtrunk"
	boozepwr = 55  // gotta be stronk
	taste_description = "spicy herbal remedy"
	color = "#331f18"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/apfelweinheim
	name = "Appelheimer"
	boozepwr = 45
	taste_description = "tart crispness and mellow sweetness"
	color = "#e0cb55"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/rtoper
	name = "Rockhill Toper"
	boozepwr = 40
	taste_description = "overwhelming tartness"
	color = "#e0a400"
	quality = DRINK_NICE

/datum/reagent/consumable/ethanol/nred
	name = "Norwardine Red"
	boozepwr = 30
	taste_description = "heavy caramel note and slight bitterness"
	color = "#543633"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/gronnmead
	name = "Ragnar's Brew"
	boozepwr = 35
	taste_description = "notes of honey and red berries" //I love red mead ok...
	color = "#772C48"
	quality = DRINK_GOOD

//Avar boozes

/datum/reagent/consumable/ethanol/avarmead
	name = "Zögiin bal"
	boozepwr = 30
	taste_description = "spicy honey"
	color = "#e0a400"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/avarrice
	name = "Makkolir"
	boozepwr = 30
	taste_description = "tangy sweetness"
	color = "#ddcbc9"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/saigamilk //No way, kumys from avar!!!
	name = "Bökhiin Arkhi"
	boozepwr = 15
	taste_description = "bubbly, sour salt"
	color = "#dddddd"

//Kazengun boozes

/datum/reagent/consumable/ethanol/kgunlager
	name = "Yamaguchi Pale"
	boozepwr = 10 //A PALE imitation actual beer...
	taste_description = "mellow bitterness and a hint of green tea"
	color = "#d7dbbc"

/datum/reagent/consumable/ethanol/kgunsake
	name = "Junmai-ginjo"
	boozepwr = 50
	taste_description = "dry sweetness"
	color = "#ccd7e0"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/kgunplum
	name = "Umeshu"
	boozepwr = 30
	taste_description = "a mix of sweet and sour"
	color = "#ddb99b"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/mead
	name = "Mead"
	description = "A warriors drink, though a cheap one."
	color = "#664300" // rgb: 102, 67, 0
	nutriment_factor = 1 * REAGENTS_METABOLISM
	boozepwr = 30
	quality = DRINK_NICE
	taste_description = "sweet, sweet alcohol"
	glass_icon_state = "meadglass"
	glass_name = "Mead"
	glass_desc = ""

/datum/reagent/consumable/ethanol/mead/spider
	color = "#660061"
	glows = TRUE


/datum/status_effect/buff/murkwine
	id = "murkwine"
	alert_type = /atom/movable/screen/alert/status_effect/buff/drunkmurk
	effectedstats = list(STATKEY_INT = 5)
	duration = 2 MINUTES

/datum/status_effect/buff/nocshine
	id = "nocshine"
	alert_type = /atom/movable/screen/alert/status_effect/buff/drunknoc
	effectedstats = list(STATKEY_STR = 1, STATKEY_END = 1)
	duration = 2 MINUTES

/atom/movable/screen/alert/status_effect/buff/drunkmurk
	name = "Murk-Knowledge"
	desc = ""
	icon_state = "drunk"

/atom/movable/screen/alert/status_effect/buff/drunknoc
	name = "Noc-Shine Strength"
	desc = ""
	icon_state = "drunk"

/datum/reagent/consumable/ethanol/murkwine // not Toilet wine
	name = "Mürkwine"
	boozepwr = 50  // bubba's best
	taste_description = "hints of questionable choices--a bouquet of murkwater and pure ethanol"
	color = "#4b1e00"

<<<<<<< HEAD
/datum/reagent/consumable/ethanol/irishcarbomb
	name = "Irish Car Bomb"
	description = "Mmm, tastes like chocolate cake..."
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 25
	quality = DRINK_GOOD
	taste_description = "delicious anger"
	glass_icon_state = "irishcarbomb"
	glass_name = "Irish Car Bomb"
	glass_desc = ""

/datum/reagent/consumable/ethanol/syndicatebomb
	name = "Syndicate Bomb"
	description = "Tastes like terrorism!"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 90
	quality = DRINK_GOOD
	taste_description = "purified antagonism"
	glass_icon_state = "syndicatebomb"
	glass_name = "Syndicate Bomb"
	glass_desc = ""

/datum/reagent/consumable/ethanol/syndicatebomb/on_mob_life(mob/living/carbon/M)
	if(prob(5))
		playsound(get_turf(M), 'sound/blank.ogg', 100, TRUE)
	return ..()

/datum/reagent/consumable/ethanol/erikasurprise
	name = "Erika Surprise"
	description = "The surprise is, it's green!"
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 35
	quality = DRINK_VERYGOOD
	taste_description = "tartness and bananas"
	glass_icon_state = "erikasurprise"
	glass_name = "Erika Surprise"
	glass_desc = ""

/datum/reagent/consumable/ethanol/driestmartini
	name = "Driest Martini"
	description = "Only for the experienced. You think you see sand floating in the glass."
	nutriment_factor = 1 * REAGENTS_METABOLISM
	color = "#2E6671" // rgb: 46, 102, 113
	boozepwr = 65
	quality = DRINK_GOOD
	taste_description = "a beach"
	glass_icon_state = "driestmartiniglass"
	glass_name = "Driest Martini"
	glass_desc = ""

/datum/reagent/consumable/ethanol/bananahonk
	name = "Banana Honk"
	description = "A drink from Clown Heaven."
	nutriment_factor = 1 * REAGENTS_METABOLISM
	color = "#FFFF91" // rgb: 255, 255, 140
	boozepwr = 60
	quality = DRINK_GOOD
	taste_description = "a bad joke"
	glass_icon_state = "bananahonkglass"
	glass_name = "Banana Honk"
	glass_desc = ""

/datum/reagent/consumable/ethanol/bananahonk/on_mob_life(mob/living/carbon/M)
	if((ishuman(M) && M.job == "Clown") || ismonkey(M))
		M.heal_bodypart_damage(1,1)
		. = 1
	return ..() || .

/datum/reagent/consumable/ethanol/silencer
	name = "Silencer"
	description = "A drink from Mime Heaven."
	nutriment_factor = 1 * REAGENTS_METABOLISM
	color = "#664300" // rgb: 102, 67, 0
	boozepwr = 59 //Proof that clowns are better than mimes right here
	quality = DRINK_GOOD
	taste_description = "a pencil eraser"
	glass_icon_state = "silencerglass"
	glass_name = "Silencer"
	glass_desc = ""

/datum/reagent/consumable/ethanol/silencer/on_mob_life(mob/living/carbon/M)
	if(ishuman(M) && M.job == "Mime")
		M.silent = max(M.silent, MIMEDRINK_SILENCE_DURATION)
		M.heal_bodypart_damage(1,1)
		. = 1
	return ..() || .

/datum/reagent/consumable/ethanol/drunkenblumpkin
	name = "Drunken Blumpkin"
	description = "A weird mix of whiskey and blumpkin juice."
	color = "#1EA0FF" // rgb: 102, 67, 0
	boozepwr = 50
	quality = DRINK_VERYGOOD
	taste_description = "molasses and a mouthful of pool water"
	glass_icon_state = "drunkenblumpkin"
	glass_name = "Drunken Blumpkin"
	glass_desc = ""

/datum/reagent/consumable/ethanol/whiskey_sour //Requested since we had whiskey cola and soda but not sour.
	name = "Whiskey Sour"
	description = "Lemon juice/whiskey/sugar mixture. Moderate alcohol content."
	color = rgb(255, 201, 49)
	boozepwr = 35
	quality = DRINK_GOOD
	taste_description = "sour lemons"
	glass_icon_state = "whiskey_sour"
	glass_name = "whiskey sour"
	glass_desc = ""

/datum/reagent/consumable/ethanol/hcider
	name = "Hard Cider"
	description = "Apple juice, for adults."
	color = "#CD6839"
	nutriment_factor = 1 * REAGENTS_METABOLISM
	boozepwr = 25
	taste_description = "the season that <i>falls</i> between summer and winter"
	glass_icon_state = "whiskeyglass"
	glass_name = "hard cider"
	glass_desc = ""
	shot_glass_icon_state = "shotglassbrown"


/datum/reagent/consumable/ethanol/fetching_fizz //A reference to one of my favorite games of all time. Pulls nearby ores to the imbiber!
	name = "Fetching Fizz"
	description = "Whiskey sour/iron/uranium mixture resulting in a highly magnetic slurry. Mild alcohol content." //Requires no alcohol to make but has alcohol anyway because ~magic~
	color = rgb(255, 91, 15)
	boozepwr = 10
	quality = DRINK_VERYGOOD
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	taste_description = "charged metal" // the same as teslium, honk honk.
	glass_icon_state = "fetching_fizz"
	glass_name = "Fetching Fizz"
	glass_desc = ""


/datum/reagent/consumable/ethanol/fetching_fizz/on_mob_life(mob/living/carbon/M)
	for(var/obj/item/stack/ore/O in orange(3, M))
		step_towards(O, get_turf(M))
	return ..()

//Another reference. Heals those in critical condition extremely quickly.
/datum/reagent/consumable/ethanol/hearty_punch
	name = "Hearty Punch"
	description = "Brave bull/syndicate bomb/absinthe mixture resulting in an energizing beverage. Mild alcohol content."
	color = rgb(140, 0, 0)
	boozepwr = 90
	quality = DRINK_VERYGOOD
	metabolization_rate = 0.4 * REAGENTS_METABOLISM
	taste_description = "bravado in the face of disaster"
	glass_icon_state = "hearty_punch"
	glass_name = "Hearty Punch"
	glass_desc = ""

/datum/reagent/consumable/ethanol/hearty_punch/on_mob_life(mob/living/carbon/M)
	if(M.health <= 0)
		M.adjustBruteLoss(-3, 0)
		M.adjustFireLoss(-3, 0)
		M.adjustCloneLoss(-5, 0)
		M.adjustOxyLoss(-4, 0)
		M.adjustToxLoss(-3, 0)
		. = 1
	return ..() || .

/datum/reagent/consumable/ethanol/bacchus_blessing //An EXTREMELY powerful drink. Smashed in seconds, dead in minutes.
	name = "Bacchus' Blessing"
	description = "Unidentifiable mixture. Unmeasurably high alcohol content."
	color = rgb(51, 19, 3) //Sickly brown
	boozepwr = 300 //I warned you
	taste_description = "a wall of bricks"
	glass_icon_state = "glass_brown2"
	glass_name = "Bacchus' Blessing"
	glass_desc = ""



/datum/reagent/consumable/ethanol/atomicbomb
	name = "Atomic Bomb"
	description = "Nuclear proliferation never tasted so good."
	color = "#666300" // rgb: 102, 99, 0
	boozepwr = 0 //custom drunk effect
	quality = DRINK_FANTASTIC
	taste_description = "da bomb"
	glass_icon_state = "atomicbombglass"
	glass_name = "Atomic Bomb"
	glass_desc = ""

/datum/reagent/consumable/ethanol/atomicbomb/on_mob_life(mob/living/carbon/M)
	M.set_drugginess(50)
	if(!HAS_TRAIT(M, TRAIT_ALCOHOL_TOLERANCE))
		M.confused = max(M.confused+2,0)
		M.Dizzy(10)
	if (!M.slurring)
		M.slurring = 1
	M.slurring += 3
	switch(current_cycle)
		if(51 to 200)
			M.Sleeping(100, FALSE)
			. = 1
		if(201 to INFINITY)
			M.AdjustSleeping(40, FALSE)
			M.adjustToxLoss(2, 0)
			. = 1
=======
/datum/reagent/consumable/ethanol/murkwine/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/murkwine)
	M.adjust_stamina(0.1)
>>>>>>> upstream/main
	..()
	. = 1

/datum/reagent/consumable/ethanol/murkwine/on_mob_end_metabolize(mob/living/M)
	M.remove_status_effect(/datum/status_effect/buff/murkwine)

/datum/reagent/consumable/ethanol/nocshine // wait, no, NOCSHINE
	name = "Noc's Shine"
	boozepwr = 70  // YEEEEEHAAAWWWWWW
	taste_description = "what might be my throat melting and nose hair burning"
	color = "#d8fbfd63"
	quality = DRINK_NICE


/datum/reagent/consumable/ethanol/nocshine/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/nocshine)
	if(HAS_TRAIT(M, TRAIT_CRACKHEAD))
		M.adjustToxLoss(0.1, 0)
	else
		M.adjustToxLoss(0.75, 0)
	..()
	. = 1

/datum/reagent/consumable/ethanol/nocshine/on_mob_end_metabolize(mob/living/M)
	M.remove_status_effect(/datum/status_effect/buff/nocshine)

/datum/reagent/consumable/ethanol/luxwine // oh no.
	name = "Luxintenebre" // lux left w/ sugar in a darkened place for quite some time... U could say... Light in Darkness.....
	description = "A fermented form of vitae, highly alcoholic, and with a particularly grim taste. Often sought out by the daring, foolhardy, and heretical..."
	boozepwr = 80 // THE END OF THE FUCKING WORLD.
	taste_description = "a green numbness, then a burning vigor in the heart" // heartburn (healing)
	color = "#86cca3"
	quality = DRINK_VERYGOOD // good stuff!

/datum/reagent/consumable/ethanol/luxwine/on_mob_life(mob/living/carbon/M) // stolen healthpot code. i am shameless.
	if(volume > 0.99) // i have no clue if this works.
		M.adjustBruteLoss(-1*REM, 0)
		M.adjustFireLoss(-1*REM, 0)
	..()

/datum/reagent/consumable/ethanol/whipwine // dont ask
	name = "Magickal Whip Wine"
	description = "A recipe recently floated into the Peaks. Magickal Whip Wine is said to increase one's potence and stamina sevenfold."
	boozepwr = 10 // it's a whip. it's an actual whip.
	taste_description = "leather, bitter herbs, and regret" // what did you expect
	color = "#3a1d18"

/datum/reagent/consumable/ethanol/komuchisake // if you put this outside the lich dungeon i'll kill you
	name = "Divine Snake Wine"
	description = "The True Form of the Whipwine. The Magickal Snake Wine was an exclusively produced medicinal wine from over three centuries ago in the Kazengun Shogunate..."
	boozepwr = 60 // ancient lichebrau...
	taste_description = "bitterness, pain, iron, and ancient mistakes" // what did you expect [2]
	color = "#553837"

/datum/reagent/consumable/ethanol/huangjiu
	name = "Huangjiu"
	boozepwr = 30
	taste_description = "a mix of sweet and sour"
	color = "#d8b84c"

<<<<<<< HEAD
/datum/reagent/consumable/ethanol/bastion_bourbon/on_mob_metabolize(mob/living/L)
	var/heal_points = 10
	if(L.health <= 0)
		heal_points = 20 //heal more if we're in softcrit
	for(var/i in 1 to min(volume, heal_points)) //only heals 1 point of damage per unit on add, for balance reasons
		L.adjustBruteLoss(-1)
		L.adjustFireLoss(-1)
		L.adjustToxLoss(-1)
		L.adjustOxyLoss(-1)
		L.adjustStaminaLoss(-1)
	L.visible_message("<span class='warning'>[L] shivers with renewed vigor!</span>", "<span class='notice'>One taste of [lowertext(name)] fills you with energy!</span>")
	if(!L.stat && heal_points == 20) //brought us out of softcrit
		L.visible_message("<span class='danger'>[L] lurches to [L.p_their()] feet!</span>", "<span class='boldnotice'>Up and at 'em, kid.</span>")

/datum/reagent/consumable/ethanol/bastion_bourbon/on_mob_life(mob/living/L)
	if(L.health > 0)
		L.adjustBruteLoss(-1)
		L.adjustFireLoss(-1)
		L.adjustToxLoss(-0.5)
		L.adjustOxyLoss(-3)
		L.adjustStaminaLoss(-5)
		. = TRUE
	..()

/datum/reagent/consumable/ethanol/squirt_cider
	name = "Squirt Cider"
	description = "Fermented squirt extract with a nose of stale bread and ocean water. Whatever a squirt is."
	color = "#FF0000"
	boozepwr = 40
	taste_description = "stale bread with a staler aftertaste"
	nutriment_factor = 2 * REAGENTS_METABOLISM
	glass_icon_state = "squirt_cider"
	glass_name = "Squirt Cider"
	glass_desc = ""
	shot_glass_icon_state = "shotglassgreen"

/datum/reagent/consumable/ethanol/squirt_cider/on_mob_life(mob/living/carbon/M)
	M.satiety += 5 //for context, vitamins give 30 satiety per tick
	..()
	. = TRUE

/datum/reagent/consumable/ethanol/fringe_weaver
	name = "Fringe Weaver"
	description = "Bubbly, classy, and undoubtedly strong - a Glitch City classic."
	color = "#FFEAC4"
	boozepwr = 90 //classy hooch, essentially, but lower pwr to make up for slightly easier access
	quality = DRINK_GOOD
	taste_description = "ethylic alcohol with a hint of sugar"
	glass_icon_state = "fringe_weaver"
	glass_name = "Fringe Weaver"
	glass_desc = ""

/datum/reagent/consumable/ethanol/sugar_rush
	name = "Sugar Rush"
	description = "Sweet, light, and fruity - as girly as it gets."
	color = "#FF226C"
	boozepwr = 10
	quality = DRINK_GOOD
	taste_description = "your arteries clogging with sugar"
	nutriment_factor = 2 * REAGENTS_METABOLISM
	glass_icon_state = "sugar_rush"
	glass_name = "Sugar Rush"
	glass_desc = ""

/datum/reagent/consumable/ethanol/sugar_rush/on_mob_life(mob/living/carbon/M)
	M.satiety -= 10 //junky as hell! a whole glass will keep you from being able to eat junk food
	..()
	. = TRUE

/datum/reagent/consumable/ethanol/crevice_spike
	name = "Crevice Spike"
	description = "Sour, bitter, and smashingly sobering."
	color = "#5BD231"
	boozepwr = -10 //sobers you up - ideally, one would drink to get hit with brute damage now to avoid alcohol problems later
	quality = DRINK_VERYGOOD
	taste_description = "a bitter SPIKE with a sour aftertaste"
	glass_icon_state = "crevice_spike"
	glass_name = "Crevice Spike"
	glass_desc = ""

/datum/reagent/consumable/ethanol/crevice_spike/on_mob_metabolize(mob/living/L) //damage only applies when drink first enters system and won't again until drink metabolizes out
	L.adjustBruteLoss(3 * min(5,volume)) //minimum 3 brute damage on ingestion to limit non-drink means of injury - a full 5 unit gulp of the drink trucks you for the full 15

/datum/reagent/consumable/ethanol/sake
	name = "Sake"
	description = "A sweet rice wine of questionable legality and extreme potency."
	color = "#DDDDDD"
	boozepwr = 70
	taste_description = "sweet rice wine"
	glass_icon_state = "sakecup"
	glass_name = "cup of sake"
	glass_desc = ""

/datum/reagent/consumable/ethanol/peppermint_patty
	name = "Peppermint Patty"
	description = "This lightly alcoholic drink combines the benefits of menthol and cocoa."
	color = "#45ca7a"
	taste_description = "mint and chocolate"
	boozepwr = 25
	quality = DRINK_GOOD
	glass_icon_state = "peppermint_patty"
	glass_name = "Peppermint Patty"
	glass_desc = ""

/datum/reagent/consumable/ethanol/peppermint_patty/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/throat_soothed)
	M.adjust_bodytemperature(5 * TEMPERATURE_DAMAGE_COEFFICIENT, 0, BODYTEMP_NORMAL)
	..()

/datum/reagent/consumable/ethanol/sidecar
	name = "Sidecar"
	description = "The one ride you'll gladly give up the wheel for."
	color = "#FFC55B"
	boozepwr = 45
	quality = DRINK_GOOD
	taste_description = "delicious freedom"
	glass_icon_state = "sidecar"
	glass_name = "Sidecar"
	glass_desc = ""

/datum/reagent/consumable/ethanol/between_the_sheets
	name = "Between the Sheets"
	description = "A provocatively named classic. Funny enough, doctors recommend drinking it before taking a nap."
	color = "#F4C35A"
	boozepwr = 55
	quality = DRINK_GOOD
	taste_description = "seduction"
	glass_icon_state = "between_the_sheets"
	glass_name = "Between the Sheets"
	glass_desc = ""

/datum/reagent/consumable/ethanol/between_the_sheets/on_mob_life(mob/living/L)
	..()
	if(L.IsSleeping())
		if(L.getBruteLoss() && L.getFireLoss()) //If you are damaged by both types, slightly increased healing but it only heals one. The more the merrier wink wink.
			if(prob(50))
				L.adjustBruteLoss(-0.25)
			else
				L.adjustFireLoss(-0.25)
		else if(L.getBruteLoss()) //If you have only one, it still heals but not as well.
			L.adjustBruteLoss(-0.2)
		else if(L.getFireLoss())
			L.adjustFireLoss(-0.2)

/datum/reagent/consumable/ethanol/kamikaze
	name = "Kamikaze"
	description = "Divinely windy."
	color = "#EEF191"
=======
/datum/reagent/consumable/ethanol/baijiu
	name = "Baijiu"
>>>>>>> upstream/main
	boozepwr = 60
	taste_description = "fiery and pungent alcohol with a hint of sweetness"
	color = "#f8fdfc"
	quality = DRINK_GOOD

/datum/reagent/consumable/ethanol/yaojiu
	name = "Yaojiu"
	boozepwr = 50
	taste_description = "bittersweet alcohol with deep herbal notes"
	color = "#8C4B1F"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/shejiu
	name = "Shejiu"
	boozepwr = 50
	taste_description = "musky and strong alcohol with a hint of gaminess"
	color = "#C49A6C"
	quality = DRINK_VERYGOOD

/datum/reagent/consumable/ethanol/kgunshochu
	name = "Shochu"
	boozepwr = 60
	taste_description = "dry, clean finish"
	color = "#F8FDFC"
	quality = DRINK_VERYGOOD

<<<<<<< HEAD
/datum/reagent/consumable/ethanol/trappist/on_mob_life(mob/living/carbon/M)
	if(M.mind.isholy)
		M.adjustFireLoss(-2.5, 0)
		M.jitteriness = max(0, M.jitteriness-1)
		M.stuttering = max(0, M.stuttering-1)
	return ..()

/datum/reagent/consumable/ethanol/blazaam
	name = "Blazaam"
	description = "A strange drink that few people seem to remember existing. Doubles as a Berenstain remover."
	boozepwr = 70
	quality = DRINK_FANTASTIC
	taste_description = "alternate realities"
	glass_icon_state = "blazaamglass"
	glass_name = "Blazaam"
	glass_desc = ""
	var/stored_teleports = 0

/datum/reagent/consumable/ethanol/blazaam/on_mob_life(mob/living/carbon/M)
	if(M.drunkenness > 40)
		if(stored_teleports)
			do_teleport(M, get_turf(M), rand(1,3), channel = TELEPORT_CHANNEL_WORMHOLE)
			stored_teleports--
		if(prob(10))
			stored_teleports += rand(2,6)
			if(prob(70))
				M.vomit()
	return ..()


/datum/reagent/consumable/ethanol/planet_cracker
	name = "Planet Cracker"
	description = "This jubilant drink celebrates humanity's triumph over the alien menace. May be offensive to non-human crewmembers."
	boozepwr = 50
	quality = DRINK_FANTASTIC
	taste_description = "triumph with a hint of bitterness"
	glass_icon_state = "planet_cracker"
	glass_name = "Planet Cracker"
	glass_desc = ""

/datum/reagent/consumable/ethanol/mauna_loa
	name = "Mauna Loa"
	description = "Extremely hot; not for the faint of heart!"
	boozepwr = 40
	color = "#fe8308" // 254, 131, 8
	quality = DRINK_FANTASTIC
	taste_description = "fiery, with an aftertaste of burnt flesh"
	glass_icon_state = "mauna_loa"
	glass_name = "Mauna Loa"
	glass_desc = ""

/datum/reagent/consumable/ethanol/mauna_loa/on_mob_life(mob/living/carbon/M)
	// Heats the user up while the reagent is in the body. Occasionally makes you burst into flames.
	M.adjust_bodytemperature(25 * TEMPERATURE_DAMAGE_COEFFICIENT)
	if (prob(5))
		M.adjust_fire_stacks(1)
		M.IgniteMob()
	..()



///////////////////
/// ROGUE BOOZE ///
///////////////////

// BEERS - Imported for now, later the styles will be 'mockable', if and when I get to brewing.

// Humen Production - Underwhelming, but cheap.

/datum/reagent/consumable/ethanol/beer/spottedhen
	name = "Spotted Hen"
	boozepwr = 15
	taste_description = "cheap pisswater"
	color = "#DBD77F"

/datum/reagent/consumable/ethanol/beer/hagwoodbitter
	name = "Hagwood Bitter"
	boozepwr = 25
	taste_description = "dull crispness"
	color = "#BBB525"

/datum/reagent/consumable/ethanol/beer/blackgoat
	name = "Black Gote Kriek"
	boozepwr = 25
	taste_description = "overwhelming sourness"
	color = "#401806"

/datum/reagent/consumable/ethanol/beer/onion
	name = "Royal Onion Cognac"
	boozepwr = 10
	taste_description = "spicy sweet malty overtones"
	color = "#683e00"

// Elf Production - LEAF-LOVERS MOTHERFUCKER

/datum/reagent/consumable/ethanol/beer/aurorian
	name = "Aurorian"
	boozepwr = 5
	taste_description = "subtle herbacious undertones"
	color = "#5D8A8A"

/datum/reagent/consumable/ethanol/beer/fireleaf // cabbbage
	name = "Fireleaf"
	boozepwr = 2
	taste_description = "bland liquor"
	color = "#475e45"

// Dwarven Production - Best in the Realms

/datum/reagent/consumable/ethanol/beer/butterhairs
	name = "Butterhairs"
	boozepwr = 30
	taste_description = "buttery richness"
	color = "#5D8A8A"

/datum/reagent/consumable/ethanol/beer/stonebeards
	name = "Stonebeard Reserve"
	boozepwr = 40
	taste_description = "potent oatlike liquor"
	color = "#5D8A8A"

/datum/reagent/consumable/ethanol/beer/voddena // Not vodka. Trust me.
	name = "Voddena"
	boozepwr = 55  // holy shit
	taste_description = "burning starchy wet dirt"
	color = "#a1a1a1"

// WINE - Fancy.. And yes: all drinks are beer, technically. Cope. Seethe. I didnt code it like this.

// Humen Production - Grape Based

/datum/reagent/consumable/ethanol/beer/sourwine // Peasant grade shit.
	name = "Sour Wine"
	boozepwr = 20
	taste_description = "sour wine"
	color = "#552b4b"

/datum/reagent/consumable/ethanol/beer/whitewine
	name = "White Wine"
	boozepwr = 30
	taste_description = "sweet white wine"
	color = "#F3ED91"

/datum/reagent/consumable/ethanol/beer/redwine
	name = "Red Wine"
	boozepwr = 30
	taste_description = "tannin-stricken wine"
	color = "#571111"

/datum/reagent/consumable/ethanol/beer/jacksberrywine
	name = "Jacksberry Wine"
	boozepwr = 15
	taste_description = "sickly sweet young wine"
	color = "#3b2342"


// Elf Production - Berries & Herbal

/datum/reagent/consumable/ethanol/beer/elfred
	name = "Elven Red"
	boozepwr = 15
	taste_description = "delectable fruity notes"
	color = "#6C0000"

/datum/reagent/consumable/ethanol/beer/elfblue
	name = "Valmora Blue"
	boozepwr = 50
	taste_description = "saintly sweetness"
	color = "#2C9DAF"
=======
#undef ALCOHOL_THRESHOLD_MODIFIER
#undef ALCOHOL_EXPONENT
>>>>>>> upstream/main
