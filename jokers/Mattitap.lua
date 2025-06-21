SMODS.Joker {
    key = 'matt',
    loc_txt = {
        name = 'Mattitap',
        text = {
            "When {C:attention}blind{} is selected,",
            "destroy a random {C:attention}number{} card",
            "this joker gains {C:mult}+#2#{} Mult",
            "{C:inactive}(currently {}{C:mult}+#1#{} {C:inactive}Mult){}"
        }
    },
    config = { extra = {mult = 0, mult_gain = 4} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.mult_gain}}
    end,
    rarity = 2,
    atlas = 'test',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
      if context.setting_blind and not context.blueprint then
        local face = false
        local killed = false
        for _, _card in pairs(G.deck.cards) do
          face = false
          if _card:get_id() == 11 or _card:get_id() == 12 or _card:get_id() == 13 then
            face = true
          end
          if face == false and killed == false then
            killed = true
            _card:start_dissolve(nil, _first_dissolve)
            _first_dissolve = true
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
          end
        end
        return {
          message = '+4 Mult',
          colour = G.C.MULT
        }
      end
      if context.joker_main then
        return {
          mult_mod = card.ability.extra.mult,
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
        }
      end
    end
}

