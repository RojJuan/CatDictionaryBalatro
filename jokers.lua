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
  config = { extra =  {odds = 1} },
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

SMODS.Joker {
    key = 'pizza',
    loc_txt = {
        name = 'pizza',
        text = {
            "You {C:mult}die{}"
        }
    },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {}}
    end,
    rarity = 1,
    atlas = 'test',
    pos = { x = 0, y = 0 },
    cost = 1,
    calculate = function(self, card, context)
      if context.buying_card then
        SMODS.add_card{key = "CRASHH!!"}
      end
      if context.ending_shop then
        SMODS.add_card{key = "FALLBACK CRASH BECAUSE OF BOOSTER PACKS!!!"}
      end
    end
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
    atlas = 'test',
    pos = { x = 0, y = 0 },
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

SMODS.Joker {
    key = 'nvim',
    loc_txt = {
        name = 'Neovim',
        text = {
            "If {C:attention}blind{} is defeated in {C:attention}1 hand{}",
            "create a random {C:spectral}Spectral{} card",
            "{C:inactive}this joker was coded in Neovim (BTW){}"
        }
    },
    config = { extra = {hands = 0} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.hands} }
    end,
    rarity = 3,
    atlas = 'test',
    pos = { x = 0, y = 0 },
    cost = 8,
    calculate = function(self, card, context)
      if context.setting_blind and not context.blueprint then
        card.ability.extra.hands = 0
      end
      if context.before and not context.blueprint then
        card.ability.extra.hands = card.ability.extra.hands + 1
      end
      if context.end_of_round and context.cardarea == G.jokers and card.ability.extra.hands == 1 then
        SMODS.add_card{set = 'Spectral'}
        return {
          message = "Blazingly fast!"
        }
      end
    end
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
  atlas = 'test',
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
  atlas = 'test',
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

SMODS.Joker {
    key = 'csmajor',
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
    atlas = 'test',
    pos = { x = 0, y = 0 },
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

SMODS.Joker {
    key = 'get_out',
    loc_txt = {
        name = 'GO! GET OUT!',
        text = {
            "When last {C:attention}hand{} of round is played",
            "{C:attention}destroys{} all cards held in hand and",
            "all scored cards get {C:mult}+#1#{} Bonus Mult"
        }
    },
    config = { extra = {bonus_mult = 8} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.bonus_mult}}
    end,
    rarity = 1,
    atlas = 'test',
    pos = { x = 0, y = 0 },
    cost = 1,
    calculate = function(self, card, context)
      if context.before and not context.blueprint then
        if G.GAME.current_round.hands_left == 0 then
          for _, _card in pairs(G.hand.cards) do
            _card:start_dissolve(nil, _first_dissolve)
            _first_dissolve = true
          end
          play_sound('cd_get_out')
          return {
            message = 'GET OUT!',
            colour = G.C.MULT
          }
        end
      end
      if context.individual and context.cardarea == G.play then
        if G.GAME.current_round.hands_left == 0 then
          context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.bonus_mult
          return {
            extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT },
            card = card
          }
        end
      end
    end
}

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

SMODS.Joker { 
    key = 'mustard',
    loc_txt = {
        name = 'Mustard',
        text = {
            "No effect unless {C:attention}Metro{}", 
            "is also owned"
        }
    },
    config = { extra = { chips = 30, Xchips = 30 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.Xchips } }
    end,
    rarity = 3,
    atlas = 'Metro',
    pos = { x = 0, y = 0 },
    cost = 7,
    calculate = function(self, card, context)
        if context.joker_main then
          if next(SMODS.find_card('j_cd_metro')) then
            return {
              message = localize { type = 'variable', key = 'a_xchips', vars = {card.ability.extra.Xchips}},
              Xchip_mod = card.ability.extra.Xchips
            }
          else
            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                chip_mod = card.ability.extra.chips
            }
          end
        end
    end
}
