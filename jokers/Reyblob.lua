SMODS.Atlas {
  key = "Reyblob",
  path = "reyblob.png",
  px = 71,
  py = 95
}

SMODS.Joker { -- Reyblob
    key = "reyblob",
    loc_txt = {
        name = "Reyblob",
        text = {
            "{X:mult,C:white}X#1#{} Mult,",
            "destroys after 1 round because of dinner."
        }
    },
    config = { extra = { Xmult = 5 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    rarity = 2,
    atlas = 'Reyblob',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    eternal_compat = false,
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.end_of_round and context.cardarea == G.jokers then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = false,
                func = function()
                  G.jokers:remove_card(card)
                  card:remove()
                  card = nil
                  return true;
                end
              }))
            return {
                message = "Dinner!"
            }
        end
    end
}   

