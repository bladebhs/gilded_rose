require_relative 'services/quality_management'

class GildedRose
  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      next if ItemType.legendary?(item)

      QualityManagement.update(item)
      item.sell_in -= 1
      QualityManagement.check_expiration(item)
    end
  end
end
