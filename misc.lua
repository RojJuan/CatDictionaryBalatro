SMODS.Atlas {
    key = "Metro",
    path = "metro.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
  key = "Lucas",
  path = "lucas.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "Reyblob",
  path = "reyblob.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "Decent",
  path = "decent.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = 'test',
  path = 'CatDictionary.png',
  px = 71,
  py = 95
}

SMODS.Rarity {
  key = "freaky",
  loc_txt = {
    name = "freaky"
  },
  badge_colour = HEX("000000")
}

SMODS.Consumable {
  key = "testcard",
  set = 'Tarot',
  loc_txt = {
    name = "Testing thing",
    text = { "idk put smth here" }
  },
  cost = 999,
  atlas = 'Metro',
  pos = { x = 0, y = 0},
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area)
    G.E_MANAGER:add_event(Event({
      SMODS.add_card{set = 'Joker', key="j_cd_csmajor"},
      SMODS.add_card{key = "j_cd_velk"},
      SMODS.add_card{key = "c_death"},
      SMODS.add_card{key = "c_death"}
    })) 
  end
}

SMODS.Back{
    name = "Cat Deck",
    key = "freck",
    atlas = 'Metro',
    pos = {x = 0, y = 0},
    config = {jokers = {'j_cd_decent', 'j_cd_reyblob', 'j_cd_metro', 'j_cd_lucas'}, consumables = {'c_cd_testcard'}},
    loc_txt = {
        name = "Cat Deck",
        text = {
            "Start with a {C:mult}CAT{}, and a {C:mult}LUCAS{} card."
        },
    },
}

SMODS.Rarity {
  key = "realised",
  loc_txt = {
    name = "realised"
  },
  badge_colour = HEX("ff4287")
}

SMODS.Sound {
  key = 'what_help_me',
  path = 'what_help_me.wav'
}
