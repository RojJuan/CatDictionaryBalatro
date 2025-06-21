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
            "{C:green}1 in 10{} chance to reset to 0.",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
    },
    config = { extra = { mult = 0, mult_gain = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,
    rarity = 2,
    atlas = 'Decent',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
            }
        end
        if context.before and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            if math.random(1, 10) == 1 then
                card.ability.extra.mult = 0
                return {
                    message = "Nope!"
                }
            end
        end
    end
}

