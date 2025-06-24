SMODS.Atlas {
  key = 'fieldsob',
  path = 'fieldsob.png',
  px = 71,
  py = 95
}

SMODS.Joker {
    key = 'fieldsob',
    loc_txt = {
        name = 'Field Sobreity',
        text = {
            "Gains {X:mult,C:white}X#2#{} Mult when {C:attention}scoring{}",
            "{C:attention}hand{} contains either {C:attention}only{}",
            "{C:spades}Spades{} and {C:clubs}Clubs{} or",
            "{C:hearts}Hearts{} and {C:diamonds}Diamonds{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}"
        }
    },
    config = { extra = {Xmult = 1, Xmult_gain= 0.08} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.Xmult, card.ability.extra.Xmult_gain}}
    end,
    rarity = 2,
    atlas = 'fieldsob',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    cost = 6,
    calculate = function(self, card, context)
      if context.before and not context.blueprint then
        local black = false 
        local red = false
        for _, _card in pairs(context.scoring_hand) do
          if _card:is_suit("Spades") or _card:is_suit("Clubs") then
            black = true
          end
          if _card:is_suit("Hearts") or _card:is_suit("Diamonds") then
            red = true
          end
        end
        if (black == true and red == false) or (black == false and red == true) then
          card.ability.extra.Xmult = card.ability.extra.Xmult_gain + card.ability.extra.Xmult
          return {
            message = "Sober!"
          }
        end
      end
      if context.joker_main then
        if card.ability.extra.Xmult > 1 then
          return {
            Xmult_mod = card.ability.extra.Xmult,
            message = localize {type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } } 
          }
        end
      end
    end
}

