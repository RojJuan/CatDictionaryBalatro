SMODS.Joker {
    key = 'jonkler',
    loc_txt = {
        name = 'Test Jimbo',
        text = {
            "{C:mult}+#1# {} Mult"
        }
    },
    config = { extra = { mult = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    rarity = 4,
    atlas = 'CatDictionary',
    pos = { x = 0, y = 0 },
    cost = 999,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
}