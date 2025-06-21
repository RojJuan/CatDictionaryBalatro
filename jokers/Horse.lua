SMODS.Atlas {
  key = 'horse',
  path = 'horse.png',
  px = 71,
  py = 95
}

SMODS.Joker {
  key = 'horse',
  loc_txt = {
    name = 'HORSE',
    text = {
      "{C:chips}+#1#{} Chips",
      "{C:chips}-#2#{} Chips for",
      "every scored {C:attention}face card{}"
    }
  },
  config = { extra = { chips = 120, chips_loss = 10 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.chips_loss } }
  end,
  atlas = 'horse',
  pos = { x = 0, y = 0},
  rarity = 2,
  cost = 6,
  calculate = function(self, card, context)
    if context.joker_main then
      if card.ability.extra.chips < 1 then
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
          colour = G.C.CHIPS
        }
      end
      return {
        message = localize { type = 'variable', key= 'a_chips', vars = { card.ability.extra.chips } },
        chips_mod = card.ability.extra.chips
      }
    end
    if context.before and not context.blueprint then
      local count = 0
      for _, _card in pairs(context.scoring_hand) do
        if _card:is_face() then
          count = count + 1
        end
      end
      card.ability.extra.chips = card.ability.extra.chips - (card.ability.extra.chips_loss * count)
        return {
          message = "Spooked!",
          colour = G.C.CHIPS,
          card = card
        }
    end
  end
}

