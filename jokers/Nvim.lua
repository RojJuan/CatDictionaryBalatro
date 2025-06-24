SMODS.Atlas {
  key = 'nvim',
  path = 'nvim.png',
  px = 71,
  py = 95
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
    atlas = 'nvim',
    pos = { x = 0, y = 0 },
    blueprint_compat = true,
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

