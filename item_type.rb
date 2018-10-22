class ItemType
  class << self
    def legendary?(item)
      item.name == 'Sulfuras, Hand of Ragnaros'
    end

    def backstage_passes?(item)
      item.name == 'Backstage passes to a TAFKAL80ETC concert'
    end

    def conjured?(item)
      item.name == 'Conjured Mana Cake'
    end

    def aged_brie?(item)
      item.name == 'Aged Brie'
    end
  end
end
