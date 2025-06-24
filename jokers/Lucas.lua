SMODS.Atlas {
  key = "Lucas",
  path = "lucas.png",
  px = 71,
  py = 95
}

SMODS.Joker { --Lucas
    key = "lucas",
    loc_txt = {
        name = "Lucas",
        text = {
            "{C:green}#2# in #3#{} chance to give", 
            "{C:chips}+#1# Chips{}"
        }
    },
    config = { extra = { chips = 200, odds = 10}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, (G.GAME.probabilities.normal or 1), card.ability.extra.odds} }
    end,
    rarity = 2,
    atlas = 'Lucas',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main then
            if pseudorandom('decent') < G.GAME.probabilities.normal / card.ability.extra.odds then
                return {
                    chips = card.ability.extra.chips,
                }
            else
                return {
                    message = "Nope!"
                }
            end
        end
    end
}
