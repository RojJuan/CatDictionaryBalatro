SMODS.Atlas {
  key = 'pizza',
  path = 'pizza.png',
  px = 71,
  py = 95
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
    atlas = 'pizza',
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
