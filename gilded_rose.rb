class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      if item.name != 'Aged Brie' && item.name != 'Backstage passes to a TAFKAL80ETC concert'
        drop_quality(item)
      else
        if item.quality < 50
          item.quality += 1
          if item.name == 'Backstage passes to a TAFKAL80ETC concert'
            if item.sell_in < 11
              item.quality += 1
            end
            if item.sell_in < 6
              item.quality += 1
            end
          end
        end
      end
      item.sell_in -= 1 unless legendary?(item)
      if item.sell_in < 0
        if item.name != 'Aged Brie'
          if item.name != 'Backstage passes to a TAFKAL80ETC concert'
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

  def drop_quality(item)
    return if legendary?(item)

    item.quality -= 1 if item.quality > 0
  end
end
