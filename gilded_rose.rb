class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if legendary?(item)

      if item.name != 'Aged Brie' && !backstage_passes?(item)
        drop_quality(item)
      else
        if item.quality < 50
          item.quality += 1
          if backstage_passes?(item)
            if item.sell_in < 11
              item.quality += 1
            end
            if item.sell_in < 6
              item.quality += 1
            end
          end
        end
      end
      item.sell_in -= 1
      if item.sell_in < 0
        if item.name != 'Aged Brie'
          if !backstage_passes?(item)
            drop_quality(item)
          else
            item.quality = 0
          end
        else
          if item.quality < 50
            item.quality += 1
          end
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

  def drop_quality(item)
    item.quality -= 1 if item.quality > 0
  end
end
