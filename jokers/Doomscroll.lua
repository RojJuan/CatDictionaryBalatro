SMODS.Joker {
    key = 'doomscroll',
    loc_txt = {
        name = 'Doomscrolling',
        text = {
            "You {C:mult}doomscroll{}"
        }
    },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    rarity = 1,
    atlas = 'test',
    pos = { x = 0, y = 0 },
    cost = 1,
    calculate = function(self, card, context)
        if context.reroll_shop then
            vidtest()
        end
    end
}

