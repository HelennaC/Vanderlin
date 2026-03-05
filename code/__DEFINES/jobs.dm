#define JOB_AVAILABLE 0
#define JOB_UNAVAILABLE_GENERIC 1
#define JOB_UNAVAILABLE_BANNED 2
#define JOB_UNAVAILABLE_PLAYTIME 3
#define JOB_UNAVAILABLE_SLOTFULL 4
#define JOB_UNAVAILABLE_AGE 5
#define JOB_UNAVAILABLE_RACE 6
#define JOB_UNAVAILABLE_SEX 7
#define JOB_UNAVAILABLE_DEITY 8
#define JOB_UNAVAILABLE_QUALITY 9
#define JOB_UNAVAILABLE_DONATOR 10
#define JOB_UNAVAILABLE_LASTCLASS 11
#define JOB_UNAVAILABLE_ACCOUNTAGE 12
#define JOB_UNAVAILABLE_JOB_COOLDOWN 13
#define JOB_UNAVAILABLE_RACE_BANNED 14

/* Job datum job_flags */
/// Whether the mob is announced on arrival.
#define JOB_ANNOUNCE_ARRIVAL (1<<0)
/// Whether the mob is added to the crew manifest.
#define JOB_SHOW_IN_CREDITS (1<<1)
/// Whether the mob is equipped through SSjob.EquipRank() on spawn.
#define JOB_EQUIP_RANK (1<<2)
/// Whether this job can be joined through the new_player menu.
#define JOB_NEW_PLAYER_JOINABLE (1<<3)
/// Whether the job can be displayed on the actors list
#define JOB_SHOW_IN_ACTOR_LIST (1<<4)

#define ALL_FACTIONS list( \
	FACTION_NONE, \
	FACTION_NEUTRAL, \
	FACTION_HOSTILE, \
	FACTION_TOWN, \
	FACTION_FOREIGNERS, \
	FACTION_MIGRANTS, \
	FACTION_UNDEAD, \
	FACTION_PLANTS, \
	FACTION_VINES, \
	FACTION_CABAL, \
	FACTION_RATS, \
	FACTION_ORCS, \
	FACTION_BUMS, \
	FACTION_VIKINGS, \
	FACTION_MATTHIOS \
)

#define FACTION_NONE		"None"
#define FACTION_NEUTRAL		"Neutral"
#define FACTION_HOSTILE		"Hostile"
#define FACTION_TOWN		"Town"
#define FACTION_FOREIGNERS  "Foreigners"
#define FACTION_MIGRANTS  	"Migrants"
#define FACTION_UNDEAD		"Undead"
#define FACTION_PLANTS		"Plants"
#define FACTION_VINES		"Vines" //Seemingly unused
#define FACTION_CABAL		"Cabal"
#define FACTION_RATS		"Rats"
#define FACTION_ORCS		"Orcs"
#define FACTION_BUMS		"Bums"
#define FACTION_MATTHIOS	"Matthios"
#define FACTION_VIKINGS     "Vikings"

#define NOBLEMEN		(1<<0)
<<<<<<< HEAD

#define LORD		(1<<0)
#define CONSORT		(1<<1)
#define HAND		(1<<2)
#define STEWARD		(1<<3)
#define WIZARD		(1<<4)
#define ARCHIVIST   (1<<5)
#define BUTLER		(1<<6)
#define JESTER  	(1<<7)
#define ROYAL_GUARD	(1<<8)


#define GARRISON		(1<<1)

#define CAPTAIN		(1<<0)
#define GUARDSMAN	(1<<1)
#define WATCHMAN	(1<<2)
#define DUNGEONEER	(1<<3)


#define TEMPLE			(1<<2)

#define PRIEST		(1<<0)
#define ACOLYTE		(1<<1)
#define TEMPLAR		(1<<2)
#define GRAVEKEEPER	(1<<3)
#define INQUISITOR	(1<<4)
#define ADEPT		(1<<5)


#define TOWNERS			(1<<3)

#define MERCHANT	(1<<0)
#define STEVEDORE	(1<<1)
#define BLACKSMITH	(1<<2)
#define MASON		(1<<3)
#define FELDSHER    (1<<4)
#define INNKEEP		(1<<5)
#define COOK		(1<<6)
#define TAILOR		(1<<7)
#define NIGHTMAN 	(1<<8)
#define NITEMAIDEN	(1<<9)
#define ALCHEMIST	(1<<10)
#define SCRIBE		(1<<11)


#define PEASANTS		(1<<4)

#define MAYOR       (1<<0)
#define FARMER		(1<<1)
#define BEASTMASTER	(1<<2)
#define FISHER		(1<<3)
#define LUMBERJACK	(1<<4)
#define MINER		(1<<5)
#define HUNTER		(1<<6)
#define BEGGAR		(1<<6)


#define OUTSIDERS		(1<<5)

#define ADVENTURER	(1<<0)
#define WAVE_DRIFTER (1<<1)
#define MERCENARY	(1<<2)
#define GRAVEDIGGER	(1<<3)


#define APPRENTICES		(1<<7)
=======
#define GARRISON		(1<<1)
#define CHURCHMEN		(1<<2)
#define SERFS			(1<<3)
#define PEASANTS		(1<<4)
#define APPRENTICES		(1<<5)
#define YOUNGFOLK		(1<<6)
#define OUTSIDERS		(1<<7)
#define COMPANY			(1<<8)
#define INQUISITION 	(1<<9)

#define UNDEAD			(1<<10)
>>>>>>> upstream/main



#define JCOLOR_NOBLE "#9c40bf"
#define JCOLOR_MERCHANT "#c2b449"
#define JCOLOR_SOLDIER "#b64949"
#define JCOLOR_SERF "#669968"
#define JCOLOR_PEASANT "#936d6c"
#define JCOLOR_INQUISITION "#FF0000"

// job display orders //

#define JDO_DEFAULT 0
#define JDO_LORD 1
#define JDO_CONSORT 1.1
#define JDO_PRINCE 1.2
#define JDO_HAND 2
<<<<<<< HEAD
#define JDO_ROYALGUARD 3
#define JDO_STEWARD 4
#define JDO_MAGICIAN 5
#define JDO_WAPP 5.1
#define JDO_ARCHIVIST 6
#define JDO_BUTLER 7
#define JDO_JESTER 8
#define JDO_SERVANT 9.1
=======
#define JDO_STEWARD 3
#define JDO_MINOR_NOBLE 3.5
#define JDO_PHYSICIAN 3.7
>>>>>>> upstream/main

#define JDO_CAPTAIN 10
#define JDO_GARRISONGUARD 11
#define JDO_GARRISONARCHER 12
#define JDO_SQUIRE 13
#define JDO_DUNGEONEER 14
#define JDO_PRISONER 15

<<<<<<< HEAD
#define JDO_PRIEST 20
#define JDO_ACOLYTE 21
#define JDO_GRAVEKEEPER 22
#define JDO_TEMPLAR 23
#define JDO_INQUISITOR 24
#define JDO_ADEPT 24.1
#define JDO_CLERIC 25

#define JDO_MERCHANT 30
#define JDO_STEVEDORE 30.1
#define JDO_ARMORER 31
#define JDO_WSMITH 31.1
#define JDO_BAPP 31.2
#define JDO_MASON 31.3
#define JDO_FELDSHER 34
#define JDO_TAILOR 35
#define JDO_INNKEEP 36
#define JDO_COOK 36.1
#define JDO_NITEMAN 37.1
#define JDO_NITEMAIDEN 37.2
#define JDO_VILLAGER 38

#define JDO_CHIEF 40
#define JDO_VET 41
#define JDO_BUTCHER 42
#define JDO_SOILSON 43

#define JDO_ADVENTURER 50
#define JDO_PILGRIM 51
#define JDO_DRIFTER 52
#define JDO_MERCENARY 53
#define JDO_VAGRANT 54
=======
#define JDO_APOTHECARY 6
#define JDO_FELDSHER 6.1
#define JDO_CLINICAPPRENTICE 6.2

#define JDO_CAPTAIN 7
#define JDO_VET 7.1
#define JDO_ROYALKNIGHT 7.2
#define JDO_MENATARMS 8
#define JDO_CITYWATCHMEN 8.1
#define JDO_GATEMASTER 8.2
#define JDO_DUNGEONEER 9
#define JDO_JAILOR 9.1
#define JDO_SQUIRE 10
#define JDO_FORWARDEN 11
#define JDO_FORGUARD 11.1

#define JDO_PRIEST 12
#define JDO_GMTEMPLAR 12.1
#define JDO_CLERIC 13
#define JDO_MONK 14
#define JDO_GRAVETENDER 15
#define JDO_CHURCHLING 15.1

#define JDO_SHEPHERD 17
#define JDO_TEMPLAR 17.1

#define JDO_MERCHANT 18
#define JDO_SHOPHAND 18.1
#define JDO_GRABBER 18.2

#define JDO_TAILOR 19

#define JDO_BLACKSMITH 21
#define JDO_BAPP 22
#define JDO_ARTIFICER 23



#define JDO_BUTLER 25
#define JDO_SERVANT 26

#define JDO_INNKEEP 27
#define JDO_INNKEEP_CHILD 27.5
#define JDO_COOK 28

#define JDO_BUTCHER 28.1
#define JDO_SOILSON 28.2
#define JDO_FISHER 28.3
#define JDO_HUNTER 28.4
#define JDO_CARPENTER 28.6
#define JDO_MASON 28.61
#define JDO_CHEESEMAKER 28.7
#define JDO_MINER 28.8
#define JDO_MATRON 28.9
#define JDO_GRAVEMAN 29


#define JDO_JESTER 30
#define JDO_BARD 30.1
#define JDO_PRISONER 31

#define JDO_CHIEF 32

#define JDO_ADVENTURER 33
#define JDO_GAFFER 33.1
#define JDO_PILGRIM 34.2
#define JDO_MIGRANT  34.3
#define JDO_BANDIT 34.3
#define JDO_WRETCH 34.4

#define JDO_MERCENARY 35

#define JDO_VAGRANT 36
#define JDO_ORPHAN 37
#define JDO_SOILCHILD 38

#define JDO_PURITAN 40
#define JDO_ORTHODOXIST	40.1
#define JDO_ABSOLVER 40.2

#define BITFLAG_CHURCH (1<<0)
#define BITFLAG_ROYALTY (1<<1)
#define BITFLAG_CONSTRUCTOR (1<<2)
#define BITFLAG_GARRISON (1<<3)

>>>>>>> upstream/main
