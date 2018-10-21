class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if legendary?(item)

      if aged_brie?(item) || backstage_passes?(item)
        rise_quality(item)
        if backstage_passes?(item)
          rise_quality(item) if item.sell_in < 11
          rise_quality(item) if item.sell_in < 6
        end
      else
        drop_quality(item)
      end
      item.sell_in -= 1
      if item.sell_in < 0
        if aged_brie?(item)
          rise_quality(item)
        elsif backstage_passes?(item)
          item.quality = 0
        else
          drop_quality(item)
        end
      end
    end
  end

  private

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

  def drop_quality(item)
    item.quality -= 1 if item.quality > 0
  end

  def rise_quality(item)
    item.quality += 1 if item.quality < 50
  end
end
