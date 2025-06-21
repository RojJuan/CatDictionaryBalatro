SMODS.Joker {
  key = 'velk',
  loc_txt = {
    name = 'Velk',
    text = {
      "First scoring {C:attention}King{} or {C:attention}Queen{}",
      "turns into a {C:mult}Mult{} card"
    }
  },
  config = { extra = {} },
  loc_vars = function(self, info_queue, card)
    return { vars = {} }
  end,
  atlas = 'test',
  pos = { x = 0, y = 0},
  rarity = 2,
  cost = 6,
  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      local count = 0
      for _, _card in pairs(context.scoring_hand) do
        if _card:get_id() == 13 or _card:get_id() == 12 then
          if count < 1 then
            _card:set_ability(G.P_CENTERS.m_mult, nil, true)
            count = count + 1
          end
        end
      end
      if count > 0 then
        return {
          message = 'Bisexual',
         colour = G.C.MULT
        }
      end
    end
  end
}

