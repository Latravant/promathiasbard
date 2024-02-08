function user_job_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc')
	state.HybridMode:options('Normal','DT')
    state.CastingMode:options('Normal','Resistant','AoE')
    state.IdleMode:options('Normal','NoRefresh','DT')
	state.Weapons:options('None','Naegling','Aeneas','DualWeapons','DualNaegling','DualTauret','DualAeolian')
	-- Whether to use Carn (or song daggers in general) under a certain threshhold even when weapons are locked.
	state.CarnMode = M{'Always','300','1000','Never'}

	gear.melee_jse_back = {name="Intarabus's Cape",augments={'Accuracy+20 Attack+20'}}
	gear.magic_jse_back = {name="Intarabus's Cape",augments={'CHR+30','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-5%',}}

	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 2
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(false, 'Use Custom Timers')
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !r gs c weapons None;gs c update')
	send_command('bind !q gs c weapons NukeWeapons;gs c update')
	send_command('bind ^q gs c weapons Swords;gs c update')
	send_command('bind !f7 gs c cycle CarnMode')

		state.Moving = M{false, "moving"}    	
		
	select_default_macro_book()
	send_command('wait 2; input /lockstyleset 1')		
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	-- Weapons sets
	sets.weapons.Aeneas = {main="Aeneas",sub="Genmei Shield"}
	sets.weapons.DualWeapons = {main="Aeneas",sub="Crepuscular Knife"}
	sets.weapons.DualNaegling = {main="Naegling",sub="Crepuscular Knife"}
	sets.weapons.Naegling = {main="Naegling",sub="Genmei Shield"}
	sets.weapons.DualTauret = {main="Tauret",sub="Crepuscular Knife"}
	sets.weapons.DualAeolian = {main="Tauret",sub="Crepuscular Knife"}

    sets.buff.Sublimation = {waist="Embla Sash"}
    sets.buff.DTSublimation = {waist="Embla Sash"}
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head="Bunzi's Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back=gear.magic_jse_back,waist="Witful Belt",legs="Aya. Cosciales +2",feet="Bihu Slippers +1"}
		
	sets.precast.FC.DT = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head="Bunzi's Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back=gear.magic_jse_back,waist="Witful Belt",legs="Aya. Cosciales +2",feet="Bihu Slippers +1"}

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {feet="Vanya Clogs"})

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak",sub="Genmei Shield"})
	
	sets.precast.FC.BardSong = {
    main={ name="Skinflayer", augments={'Mag. Acc.+12','AGI+7','Crit. hit damage +1%','DMG:+15',}},
    sub="Genmei Shield",range = empty, head="Fili Calot +1", body="Inyanga Jubbah +2", hands="Aya. Manopolas +2",
    legs={ name="Gende. Spats +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -5%',}},
    feet={ name="Bihu Slippers +2", augments={'Enhances "Nightingale" effect',}},     neck="Twilight Torque",
    waist="Embla Sash", left_ear="Loquac. Earring", right_ear="Aoidos' Earring", left_ring="Defending Ring",
    right_ring="Weather. Ring", back={ name="Intarabus's Cape", augments={'CHR+1','Mag. Acc+20 /Mag. Dmg.+20','Attack+6','"Fast Cast"+10',}},}

	sets.precast.FC.SongDebuff = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC.SongDebuff.Resistant = set_combine(sets.precast.FC.BardSong,{range="Blurred Harp +1"})
		
	sets.precast.FC.Mazurka = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})

	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
	sets.precast.DaurdablaDummy = sets.precast.FC.Daurdabla
		
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +2"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps. +2"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +2"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}

	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Asperity Necklace",
    waist="Chaac Belt",
    left_ear="Digni. Earring",
    right_ear="Mache Earring",
    left_ring="Petrov Ring",
    right_ring="Chirich Ring",}
		
	sets.precast.WS.Acc = {ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Moonshade Earring",ear2="Mache Earring +1",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
		
	sets.precast.WS['Savage Blade'] = {
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Asperity Necklace",
    waist="Sailfi Belt +1",
    left_ear="Digni. Earring",
    right_ear="Mache Earring",
    left_ring="Petrov Ring",
    right_ring="Chirich Ring",}
		
	sets.precast.WS['Aeolian Edge'] = {
    head="Inyanga Tiara +2",
    body="Gyve Doublet",
    hands={ name="Chironic Gloves", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+3','Quadruple Attack +2','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
    legs={ name="Kaykaus Tights", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}},
    feet={ name="Chironic Slippers", augments={'Enmity-4','Pet: Haste+4','Quadruple Attack +2','Accuracy+3 Attack+3','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Eschan Stone",
    left_ear="Digni. Earring",
    right_ear="Friomisi Earring",
    left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    right_ring="Fenrir Ring",
    back="Izdubar Mantle",}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {ear1="Ishvara Earring",ear2="Telos Earring",}
	sets.AccMaxTP = {ear1="Mache Earring +1",ear2="Telos Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Bunzi's Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
		back=gear.magic_jse_back,waist="Witful Belt",legs="Aya. Cosciales +2",feet="Bihu Slippers +1"}

	-- Gear to enhance certain classes of songs
	sets.midcast.Ballad = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}, range="Gjallarhorn", 
	head="Fili Calot +1", body="Fili Hongreline +2", hands="Fili Manchettes +1", legs="Inyanga Shalwar +2", feet="Brioso Slippers +2", neck="Moonbow Whistle",}
	sets.midcast.Lullaby = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}, sub="Ammurapi Shield", range="Marsyas",  
		head="Brioso Roundlet +2", body="Brioso Justau. +2", hands="Inyan. Dastanas +2", legs="Inyanga Shalwar +2", 
		feet={ name="Bihu Slippers +2", augments={'Enhances "Nightingale" effect',}}, neck="Moonbow Whistle", 
		waist="Harfner's Sash", left_ear="Gersemi Earring", right_ear="String Earring", left_ring="Stikini Ring", right_ring="Stikini Ring", back="Erato's Cape",}
	sets.midcast.Lullaby.Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby'] = {range="Marsyas"}
	sets.midcast['Horde Lullaby'].Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby'].AoE = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'] = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}, sub="Ammurapi Shield", range="Daurdabla", 
		head="Brioso Roundlet +2", body="Brioso Justau. +2", hands="Inyan. Dastanas +2", legs="Inyanga Shalwar +2", 
		feet={ name="Bihu Slippers +2", augments={'Enhances "Nightingale" effect',}}, neck="Moonbow Whistle", 
		waist="Harfner's Sash", left_ear="Gersemi Earring", right_ear="String Earring", left_ring="Stikini Ring", right_ring="Stikini Ring", back="Erato's Cape",}
	sets.midcast['Horde Lullaby II'].Resistant = {range="Blurred Harp +1"}
	sets.midcast['Horde Lullaby II'].AoE = {range="Blurred Harp +1"}
	sets.midcast.Madrigal = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}, range="Gjallarhorn", 
	head="Fili Calot +1", body="Fili Hongreline +2", hands="Fili Manchettes +1", legs="Inyanga Shalwar +2", feet="Brioso Slippers +2", 
	neck="Moonbow Whistle", back={ name="Intarabus's Cape", augments={'CHR+11','Mag. Acc+20 /Mag. Dmg.+20','Attack+6','"Fast Cast"+10',}},}
	sets.midcast.Paeon = {}
	sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.March,{range="Marsyas"})
	sets.midcast.Minuet = {body="Fili Hongreline +2"}
	sets.midcast.Minne = {}
	sets.midcast.Carol = {}
	sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
	sets.midcast['Magic Finale'] = {range="Blurred Harp +1"}
	sets.midcast.Mazurka = {range="Marsyas"}
	sets.midcast.Prelude = {main={ name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}, range="Gjallarhorn", 
	head="Fili Calot +1", body="Fili Hongreline +2", hands="Fili Manchettes +1", legs="Inyanga Shalwar +2", feet="Fili Cothurnes +1", 
	neck="Moonbow Whistle", back={ name="Intarabus's Cape", augments={'CHR+11','Mag. Acc+20 /Mag. Dmg.+20','Attack+6','"Fast Cast"+10',}},}
	
	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
    main="Carnwenhan",
    sub="Ammurapi shield",
    head="Fili Calot +1",
    body="Fili Hongreline +2",
    hands="Fili Manchettes +1",
    legs="Inyanga Shalwar +2",
    feet="Brioso Slippers +2",
    neck="Aoidos' Matinee",}
		
	sets.midcast.SongEffect.DW = {main="Carnwenhan",sub="Kali"} --Only weapons in this set. This set is overlayed onto  SongEffect

	-- For song defbuffs (duration primary, accuracy secondary)
	sets.midcast.SongDebuff = {main="Kali",sub="Ammurapi Shield",range="Marsyas",ammo=empty,
		head="Inyanga Tiara +2",neck="Mnbw. Whistle +1",ear1="Regal Earring",ear2="Digni. Earring",
		body="Fili Hongreline +2",hands="Inyan. Dastanas +2",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
		back=gear.magic_jse_back,waist="Acuity Belt +1",legs="Inyanga Shalwar +2",feet="Brioso Slippers +2"}
		
	sets.midcast.SongDebuff.DW = {main="Kali",sub="Kali"} --Only weapons in this set. This set is overlayed onto  SongDebuff

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.SongDebuff.Resistant = {main="Daybreak",sub="Ammurapi Shield",range="Blurred Harp +1",ammo=empty,
		head="Inyanga Tiara +2",neck="Mnbw. Whistle +1",ear1="Regal Earring",ear2="Digni. Earring",
		body="Inyanga Jubbah +2",hands="Inyan. Dastanas +2",ring1="Metamorph Ring +1",ring2="Stikini Ring +1",
		back=gear.magic_jse_back,waist="Acuity Belt +1",legs="Inyanga Shalwar +2",feet="Aya. Gambieras +2"}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {main=gear.grioavolr_fc_staff,sub="Clerisy Strap +1",range="Blurred Harp +1",ammo=empty,
		head="Bunzi's Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",
		body="Inyanga Jubbah +2",hands="Gendewitha Gages +1",ring1="Kishar Ring",ring2="Prolix Ring",
		back=gear.magic_jse_back,waist="Witful Belt",legs="Fili Rhingrave +1",feet="Aya. Gambieras +2"}
		
	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {main="Serenity",sub="Curatio Grip",ammo="Pemphredo Tathlum",
        head="Gende. Caubeen +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Mendi. Earring",
        body="Kaykaus Bliaut",hands="Kaykaus Cuffs",ring1="Janniston Ring",ring2="Menelaus's Ring",
        back="Tempered Cape +1",waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Kaykaus Boots"}
		
	sets.midcast.Curaga = sets.midcast.Cure
		
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Received = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] = {main="Serenity",sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Voltsurge Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=gear.magic_jse_back,waist="Embla Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
		
	sets.midcast['Elemental Magic'] = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Daybreak",sub="Ammurapi Shield",ammo="Ghastly Tathlum +1",
		head="C. Palug Crown",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Chironic Doublet",hands="Volte Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Gyve Trousers",feet=gear.chironic_nuke_feet}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		back="Oretan. Cape +1",ring1="Haoma's Ring",ring2="Menelaus's Ring",waist="Witful Belt",feet="Vanya Clogs"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main=gear.grioavolr_fc_staff,sub="Clemency Grip"})

	-- Resting sets
	sets.resting = {main="Chatoyant Staff",sub="Umbra Strap",ammo="Staunch Tathlum +1",
		head=empty,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Respite Cloak",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flume Belt +1",legs="Assid. Pants +1",feet=gear.chironic_refresh_feet}
	
	sets.idle = {
    main={ name="Ipetam", augments={'Mag. Evasion+14','Magic dmg. taken -5%','INT+13 MND+13',}},
    sub="Genmei Shield",
    range={ name="Linos", augments={'Mag. Evasion+11','Magic dmg. taken -4%','INT+6 MND+6',}},
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Flashward Earring",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back="Solemnity Cape",}
		
	sets.idle.DT = {
    main={ name="Ipetam", augments={'Mag. Evasion+14','Magic dmg. taken -5%','INT+13 MND+13',}},
    sub="Genmei Shield",
    range={ name="Linos", augments={'Mag. Evasion+11','Magic dmg. taken -4%','INT+6 MND+6',}},
    head="Aya. Zucchetto +2",
    body="Ayanmo Corazza +2",
    hands="Aya. Manopolas +2",
    legs="Aya. Cosciales +2",
    feet="Aya. Gambieras +2",
    neck="Twilight Torque",
    waist="Flume Belt",
    left_ear="Flashward Earring",
    right_ear="Eabani Earring",
    left_ring="Defending Ring",
    right_ring="Moonbeam Ring",
    back="Solemnity Cape",}
	
	-- Defense sets

	sets.defense.PDT = {main="Terra's Staff", sub="Umbra Strap",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.defense.MDT = {main="Terra's Staff", sub="Umbra Strap",ammo="Staunch Tathlum +1",
		head="Nyame Helm",neck="Warder's charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonlight Cape",waist="Carrier's Sash",legs="Nyame Flanchard",feet="Nyame Sollerets"}

	sets.Kiting = {feet="Fili Cothurnes +1"}
	sets.MoveSpeed = {feet="Fili Cothurnes +1",}
	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_refresh_grip = {sub="Oneiros Grip"}
	sets.TPEat = {neck="Chrys. Torque"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	sets.engaged = {main="Aeneas",sub="Genmei Shield",ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Windbuffet Belt +1",legs="Aya. Cosciales +2",feet="Battlecast Gaiters"}
	sets.engaged.DT = {main="Aeneas",sub="Genmei Shield",ammo="Aurgelmir Orb +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Windbuffet Belt +1",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.engaged.Acc = {main="Aeneas",sub="Genmei Shield",ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Olseni Belt",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
	sets.engaged.DW = {main="Aeneas", sub="Crepuscular Knife",range={ name="Linos", augments={'Accuracy+15','"Store TP"+4','Quadruple Attack +3',}},
		head="Aya. Zucchetto +2", body="Ayanmo Corazza +2", hands="Aya. Manopolas +2", legs="Aya. Cosciales +2",
		feet="Aya. Gambieras +2", neck="Asperity Necklace", waist="Sailfi Belt +1", left_ear="Suppanomimi",
		right_ear="Eabani Earring", left_ring="Petrov Ring", right_ring="Hetairoi Ring", back="Bleating Mantle",}
	sets.engaged.DW.DT = {main="Aeneas",sub="Blurred Knife +1",ammo="Aurgelmir Orb +1",
		head="Nyame Helm",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Brutal Earring",
		body="Nyame Mail",hands="Nyame Gauntlets",ring1="Petrov Ring",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Reiki Yotai",legs="Nyame Flanchard",feet="Nyame Sollerets"}
	sets.engaged.DW.Acc = {main="Aeneas",sub="Blurred Knife +1",ammo="Aurgelmir Orb +1",
		head="Aya. Zucchetto +2",neck="Combatant's Torque",ear1="Suppanomimi",ear2="Telos Earring",
		body="Ayanmo Corazza +2",hands="Aya. Manopolas +2",ring1="Ramuh Ring +1",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Reiki Yotai",legs="Aya. Cosciales +2",feet="Aya. Gambieras +2"}
	sets.engaged.DW.Acc.DT = {main="Aeneas",sub="Blurred Knife +1",ammo="Aurgelmir Orb +1",
		head="Nyame Helm",neck="Combatant's Torque",ear1="Suppanomimi",ear2="Telos Earring",
		body="Ayanmo Corazza +2",hands="Nyame Gauntlets",ring1="Defending Ring",ring2="Ilabrat Ring",
		back=gear.melee_jse_back,waist="Reiki Yotai",legs="Nyame Flanchard",feet="Nyame Sollerets"}
		

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 10)
end

function user_job_lockstyle()
	windower.chat.input('/lockstyleset 001')
end

state.Weapons:options('None','Naegling','Aeneas','DualWeapons','DualNaegling','DualTauret','DualAeolian')

autows_list = {['Naegling']='Savage Blade',['Aeneas']="Rudra's Storm",['DualWeapons']="Rudra's Storm",['DualNaegling']='Savage Blade',['DualTauret']='Evisceration',
     ['DualAeolian']='Aeolian Edge'}

