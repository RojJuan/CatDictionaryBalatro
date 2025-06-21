SMODS.Atlas {
  key = 'apple_man',
  path = 'apple_man.png',
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'apple_man',
  loc_txt = {
    name = 'APPLE MAN',
    text = {
      "{C:mult}+#1#{} Mult",
      "{C:mult}-#2#{} Mult for",
      "every scored {C:attention}face card{}"
    }
  },
  config = { extra = { mult = 24, mult_loss = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.mult_loss } }
  end,
  atlas = 'apple_man',
  pos = { x = 0, y = 0},
  rarity = 3,
  cost = 8,
  calculate = function(self, card, context)
    if context.joker_main then
      if card.ability.extra.mult < 1 then
        G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('cd_what_help_me')
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
          card.states.drag.is = true
					card.children.center.pinch.x = true
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
					return true
				end
			  }))
        return {
          message = 'WHAT? HELP ME!',
          colour = G.C.MULT
        }
      end
      return {
        message = localize { type = 'variable', key= 'a_mult', vars = { card.ability.extra.mult } },
        mult_mod = card.ability.extra.mult
      }
    end
    if context.before and not context.blueprint then
      local count = 0
      for _, _card in pairs(context.scoring_hand) do
        if _card:is_face() then
          count = count + 1
        end
      end
      card.ability.extra.mult = card.ability.extra.mult - (card.ability.extra.mult_loss * count)
        return {
          message = "Spooked!",
          colour = G.C.MULT,
          card = card
        } 
    end
  end
}

