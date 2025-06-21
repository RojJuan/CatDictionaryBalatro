SMODS.Atlas {
  key = 'sabrina',
  path = 'sabrina.png',
  px = 71,
  py = 95
}

SMODS.Joker {
    key = 'sabrina',
    loc_txt = {
        name = 'Sabrina Carpenter',
        text = {
            "{C:green}#3# in #2#{} chance to give",
            "{C:money}#1#${} per card scored"
        }
    },
    config = { extra = {money = 8, odds = 2} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.money, card.ability.extra.odds, (G.GAME.probabilities.normal or 1)}}
    end,
    rarity = 1,
    atlas = 'test',
    pos = { x = 0, y = 0 },
    cost = 1,
    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        if pseudorandom('sabrina') < G.GAME.probabilities.normal / card.ability.extra.odds then
        	G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
			    G.E_MANAGER:add_event(Event({
				    func = function()
					    G.GAME.dollar_buffer = 0
					    return true
				    end,
			    }))
          return {
            dollars = card.ability.extra.money,
            card = card
          }
        end
      end
    end
}

