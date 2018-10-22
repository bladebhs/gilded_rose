require_relative 'item_type'

class QualityManagement
  class << self
    def update(item)
      if ItemType.aged_brie?(item) || ItemType.backstage_passes?(item)
        rise_quality(item)
      else
        drop_quality(item)
      end
    end

    def check_expiration(item)
      return if item.sell_in >= 0

      if ItemType.aged_brie?(item)
        item.quality += 1 if item.quality < 50
      elsif ItemType.backstage_passes?(item)
        item.quality = 0
      else
        drop_quality(item)
      end
    end

    private

    def drop_quality(item)
      step = ItemType.conjured?(item) ? 2 : 1
      item.quality -= step if item.quality > 0
    end

    def rise_quality(item)
      return if item.quality == 50

      item.quality += 1
      return unless ItemType.backstage_passes?(item)

      item.quality += 1 if item.sell_in < 11
      item.quality += 1 if item.sell_in < 6
    end
  end
end
