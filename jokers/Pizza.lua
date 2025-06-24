SMODS.Atlas {
  key = 'pizza',
  path = 'pizza.png',
  px = 71,
  py = 95
}

SMODS.Joker {
    key = 'pizza',
    loc_txt = {
        name = 'pizza',
        text = {
            "You {C:mult}die{}"
        }
    },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    rarity = 1,
    atlas = 'pizza',
    pos = { x = 0, y = 0 },
    eternal_compat = false,
    cost = 1,
    add_to_deck = function(self, card, from_debuff)
        SMODS.restart_game()
    end
}
