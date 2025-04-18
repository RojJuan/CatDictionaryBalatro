SMODS.Joker { --Metro
    key = 'metro',
    loc_txt = {
        name = 'Metro',
        text = {
            "No effect unless {C:attention}Mustard{}", 
            "is also owned"
        }
    },
    config = { extra = { mult = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    rarity = 3,
    atlas = 'Metro',
    pos = { x = 0, y = 0 },
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
            }
        end
    end
}

SMODS.Joker { --Lucas
    key = "lucas",
    loc_txt = {
        name = "Lucas",
        text = {
            "{C:green}1 in 10{} chance to give", 
            "{C:chips}+200 Chips{}"
        }
    },
    config = { extra = { chips = 200}},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips} }
    end,
    rarity = 2,
    atlas = 'Lucas',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main then
            if math.random(1, 10) == 1 then
                return {
                    chips = card.ability.extra.chips,
                }
            else
                return {
                    message = "Nope!"
                }
            end
        end
    end
}

SMODS.Joker { -- Reyblob
    key = "reyblob",
    loc_txt = {
        name = "Reyblob",
        text = {
            "{X:mult,C:white}X#1#{} Mult,",
            "destroys after 1 round because of dinner."
        }
    },
    config = { extra = { Xmult = 5 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    rarity = 2,
    atlas = 'Reyblob',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
        if context.end_of_round and context.cardarea == G.jokers then
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
            return {
                message = "Dinner!"
            }
        end
    end
}   

SMODS.Joker { --Decent
    key = 'decent',
    loc_txt = {
        name = 'Decent',
        text = {
            "Gains {C:mult}+#2# Mult{} per round,",
            "{C:green}1 in 10{} chance to reset to 0.",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
    },
    config = { extra = { mult = 0, mult_gain = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
    end,
    rarity = 2,
    atlas = 'Decent',
    pos = { x = 0, y = 0 },
    cost = 4,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult,
            }
        end
        if context.before and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            if math.random(1, 10) == 1 then
                card.ability.extra.mult = 0
                return {
                    message = "Nope!"
                }
            end
        end
    end
}

SMODS.Joker {
  key = 'lunchbox',
  loc_txt = {
    name = 'Mr. Beast Lunchbox',
    text = {
      "{C:green}#1# in #2#{} chance to {C:dark_edition}realise...{}"
    }
  },
  config = { extra =  {odds = 100} },
  atlas = 'test',
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
            "{X:dark_edition,C:white}^1{} Mult for each dollar",
            "gives {X:money,C:white}X10{} of current {C:money}money{}"
        }
    },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    rarity = 'cd_realised',
    atlas = 'test',
    pos = { x = 0, y = 0 },
    cost = 2,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Emult_mod = G.GAME.dollars,
                message = "I REALISE!!!!!!!!!!!!!"
            }
        end
    end,
  calc_dollar_bonus = function (self, card)
    local bonus = 10 * G.GAME.dollars
    return bonus
  end
}
