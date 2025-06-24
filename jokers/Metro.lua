SMODS.Atlas {
    key = "Metro",
    path = "metro.png",
    px = 71,
    py = 95
}

SMODS.Joker { --Metro
    key = 'metro',
    loc_txt = {
        name = 'Metro',
        text = {
            "No effect unless {C:attention}Mustard{}", 
            "is also owned"
        }
    },
    config = { extra = { mult = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    rarity = 3,
    atlas = 'Metro',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
}
