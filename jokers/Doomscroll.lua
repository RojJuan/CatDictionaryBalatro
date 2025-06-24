SMODS.Joker {
    key = 'doomscroll',
    loc_txt = {
        name = 'Doomscrolling',
        text = {
            "{C:mult}Youtube shorts{}"
        }
    },
    config = { extra = {vid = 0, rerolls = (10^69)} },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    rarity = 1,
    atlas = 'test',
    pos = { x = 0, y = 0 },
    cost = 1,
    calculate = function(self, card, context)
        if context.reroll_shop and not context.blueprint then
            card.ability.extra.vid = math.random(1, 33)
            G.FUNCS.overlay_menu{
                definition = create_UIBox_custom_video1(tostring(card.ability.extra.vid),"Keep scrolling.", 7),
                config = {no_esc = true}
            } 
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(card.ability.extra.rerolls)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_free_rerolls(-card.ability.extra.rerolls)
    end
}

