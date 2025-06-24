SMODS.Atlas {
  key = "Decent",
  path = "decent.png",
  px = 71,
  py = 95
}

SMODS.Joker { --Decent
    key = 'decent',
    loc_txt = {
        name = 'Decent',
        text = {
            "Gains {C:mult}+#2# Mult{} per round,",
            "{C:green}#3# in #4#{} chance to reset to 0.",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
    },
    config = { extra = { mult = 0, mult_gain = 2, odds = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    rarity = 2,
    atlas = 'Decent',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
            }
        end
        if context.before and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            if pseudorandom('decent') < G.GAME.probabilities.normal / card.ability.extra.odds then
                card.ability.extra.mult = 0
                return {
                    message = "Nope!"
                }
            end
        end
    end
}

