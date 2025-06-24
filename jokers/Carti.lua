SMODS.Atlas {
  key = 'carti',
  path = 'carti.png',
  px = 71,
  py = 95
}

SMODS.Joker {
    key = 'carti',
    loc_txt = {
        name = 'Playboi Carti',
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult",
            "after playing {C:attention}50 hands{}",
            "{C:inactive}(Currently {}{X:mult,C:white}X#1#{} {C:inactive}Mult){}",
            "{C:inactive}(Currently {}{C:attention}#3# hands{} {C:inactive}left){}"
        }
    },
    config = { extra = {Xmult = 1, Xmult_gain = 8, HandsRem = 50} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.Xmult, card.ability.extra.Xmult_gain, card.ability.extra.HandsRem}}
    end,
    rarity = 2,
    atlas = 'carti',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    cost = 6,
    calculate = function(self, card, context)
      if context.before and not context.blueprint then
        if card.ability.extra.HandsRem > 1 then
          card.ability.extra.HandsRem = card.ability.extra.HandsRem - 1
        else
          card.ability.extra.HandsRem = 50
          card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
          return {
            message = "HE DROPPED!",
            colour = G.C.MULT
          }
        end
      end
      if context.joker_main and card.ability.extra.Xmult > 1 then
        return {
          Xmult_mod = card.ability.extra.Xmult,
          message = localize {type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
        }
      end 
    end
}

