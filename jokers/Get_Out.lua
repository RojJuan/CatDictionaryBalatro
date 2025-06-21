SMODS.Atlas {
  key = 'get_out',
  path = 'get_out.png',
  px = 71,
  py = 95
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
    atlas = 'get_out',
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

