SMODS.Atlas {
    key = "CatDictionary",
    path = "CatDictionary.png",
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
  set = 'Spectral',
  loc_txt = {
    name = "Testing thing",
    text = { "idk put smth here" }
  },
  cost = 999,
  atlas = 'CatDictionary',
  pos = { x = 0, y = 0},
  can_use = function(self, card)
    return true
  end,
  use = function(self, card, area)
    G.E_MANAGER:add_event(Event({
      SMODS.add_card{set = 'Joker', rarity = 'cd_freaky'}
    }))
  end
}

SMODS.Back{
    name = "Freaky Deck",
    key = "freck",
    atlas = 'CatDictionary',
    pos = {x = 0, y = 0},
    config = {consumables = {'c_cd_testcard'}},
    loc_txt = {
        name = "Freaky Deck",
        text = {
            "Start with a {C:mult}TESTING{} card"
        },
    },
}
