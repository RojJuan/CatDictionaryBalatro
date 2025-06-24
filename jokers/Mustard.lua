SMODS.Atlas {
  key = 'mustard',
  path = 'mustard.png',
  px = 71,
  py = 95
}

SMODS.Joker { 
    key = 'mustard',
    loc_txt = {
        name = 'Mustard',
        text = {
            "No effect unless {C:attention}Metro{}", 
            "is also owned"
        }
    },
    config = { extra = { chips = 30, Xchips = 30 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.Xchips } }
    end,
    rarity = 3,
    atlas = 'mustard',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
          if next(SMODS.find_card('j_cd_metro')) then
            return {
              message = localize { type = 'variable', key = 'a_xchips', vars = {card.ability.extra.Xchips}},
              Xchip_mod = card.ability.extra.Xchips
            }
          else
            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                chip_mod = card.ability.extra.chips
            }
          end
        end
    end
}

