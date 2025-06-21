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
            "{C:green}1 in 10{} chance to give", 
            "{C:chips}+200 Chips{}"
        }
    },
    config = { extra = { chips = 200}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips} }
    end,
    rarity = 2,
    atlas = 'Lucas',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main then
            if math.random(1, 10) == 1 then
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
