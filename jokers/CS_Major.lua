SMODS.Joker {
    key = 'cs_major',
    loc_txt = {
        name = 'CS Major',
        text = {
            "All {C:attention}Queens{} are {C:mult}debuffed{}",
            "{C:green}#1# in #2#{} chance to",
            "earn {C:money}#4#${} and",
            "gain {X:mult,C:white}X#3#{} Mult"
        }
    },
    config = { extra = {odds = 42, Xmult = 10, money = 50} },
    loc_vars = function(self, info_queue, card)
        return { vars = {(G.GAME.probabilities.normal or 1), card.ability.extra.odds, card.ability.extra.Xmult, card.ability.extra.money }}
    end,
    rarity = 2,
    atlas = 'test',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
    cost = 5,
    update = function(self, card, dt)
      if G.deck and card.added_to_deck then
        for i, _card in pairs(G.deck.cards) do
          if _card:get_id() == 12 then
            _card:set_debuff(true)
          end
        end
      end
      if G.deck and card.added_to_deck then
        for i, _card in pairs(G.hand.cards) do
          if _card:get_id() == 12 then
            _card:set_debuff(true)
          end
        end
      end
    end,
    calculate = function (self, card, context)
      if context.joker_main then
        if pseudorandom('csmajor') <  G.GAME.probabilities.normal / card.ability.extra.odds then
          return {
            p_dollars = card.ability.extra.money,
            Xmult_mod = card.ability.extra.Xmult,
            message = localize {type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
          }
        end
      end
    end
}

