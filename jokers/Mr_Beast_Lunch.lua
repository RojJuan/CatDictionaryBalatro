SMODS.Atlas {
  key = 'lunch',
  path = 'lunch.png',
  px = 71,
  py = 95
}

SMODS.Rarity {
  key = "realised",
  loc_txt = {
    name = "realised"
  },
  badge_colour = HEX("ff4287")
}

SMODS.Joker {
  key = 'lunchbox',
  loc_txt = {
    name = 'Mr. Beast Lunchbox',
    text = {
      "{C:green}#1# in #2#{} chance to {C:dark_edition}realise...{}"
    }
  },
  config = { extra =  {odds = 1} },
  atlas = 'lunch',
  pos = { x = 0, y = 0},
  rarity = 1,
  cost = 5,
  loc_vars = function (self, info_queue, card)
    return {vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function (self, card, context)
    if context.joker_main and not context.blueprint then
      if pseudorandom('lunchbox') < G.GAME.probabilities.normal / card.ability.extra.odds then
        SMODS.add_card{key = 'j_cd_real_lunch'}
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
      end
    end
  end
}

SMODS.Joker {
    key = 'real_lunch',
    loc_txt = {
        name = 'Realised Mr. Beast Lunchbox',
        text = {
            "{X:dark_edition,C:white,s:2}#1##2#{} Mult",
            "each time a lucky card triggers",
            "increases operator by 1",
            "earn ^1.1 of current money"
        }
    },
    config = { extra = {op = 1, val = 10} },
    loc_vars = function(self, info_queue, card)
      local op_string = "{"..card.ability.extra.op.."}"
        if card.ability.extra.op < 11 then
          op_string = string.rep("^", card.ability.extra.op)
        end
      return {
        vars = { op_string, card.ability.extra.val}
      }
    end,
    rarity = 'cd_realised',
    atlas = 'lunch',
    pos = { x = 0, y = 0 },
    cost = 2,
    calculate = function(self, card, context)
        if context.individual and context.other_card.lucky_trigger then
            card.ability.extra.op = card.ability.extra.op + 1

        end
        if context.joker_main then
            print(card.ability.extra.op)
            return {
                hypermult_mod = {card.ability.extra.op, card.ability.extra.val},
                message = "I REALISE!!!!!!!!!!!!!"
            }
        end
    end
}
