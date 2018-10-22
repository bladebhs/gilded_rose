require './item'
require './gilded_rose'

describe GildedRose do
  describe '#update_quality' do
    it 'does not change the name' do
      item = build(:item, name: 'Mithril')
      GildedRose.new([item]).update_quality
      expect(item.name).to eq('Mithril')
    end

    it 'decreases sell_in and quality' do
      item = build(:item, sell_in: 2, quality: 5)
      GildedRose.new([item]).update_quality
      expect(item.sell_in).to eq(1)
      expect(item.quality).to eq(4)
    end

    context 'when the sell by date has passed' do
      it 'decreases quality twice as fast' do
        item = build(:item, sell_in: 0, quality: 4)
        expect do
          GildedRose.new([item]).update_quality
        end.to change { item.quality }.by(-2)
      end
    end

    it 'does not decrease the quality if it equals to 0' do
      item = build(:item, sell_in: 2, quality: 0)
      GildedRose.new([item]).update_quality
      expect(item.quality).to eq(0)
    end

    context 'when the item is Aged Brie' do
      let(:aged_brie) { build(:item, name: 'Aged Brie') }

      it 'increases the quality' do
        expect do
          GildedRose.new([aged_brie]).update_quality
        end.to change { aged_brie.quality }.by(1)
      end

      it 'does not increase the quality if it equals to 50' do
        aged_brie.quality = 50
        GildedRose.new([aged_brie]).update_quality
        expect(aged_brie.quality).to eq(50)
      end
    end

    context 'when the item is Sulfuras' do
      let(:sulfuras) do
        build(:item,
              name: 'Sulfuras, Hand of Ragnaros',
              sell_in: 50,
              quality: 80)
      end
      before { GildedRose.new([sulfuras]).update_quality }

      it 'does not change sell_in and quality' do
        expect(sulfuras.sell_in).to eq(50)
        expect(sulfuras.quality).to eq(80)
      end
    end

    context 'when the item is Backstage passes' do
      let(:backstage_passes) do
        build(:item, name: 'Backstage passes to a TAFKAL80ETC concert',
                     quality: 5)
      end

      it 'increases the quality by 1 when there are more than 10 days' do
        backstage_passes.sell_in = 11
        expect do
          GildedRose.new([backstage_passes]).update_quality
        end.to change { backstage_passes.quality }.by(1)
      end

      it 'increases the quality by 2 when there are 10 days or less' do
        backstage_passes.sell_in = 10
        expect do
          GildedRose.new([backstage_passes]).update_quality
        end.to change { backstage_passes.quality }.by(2)
      end

      it 'increases the quality by 3 when there are 5 days or less' do
        backstage_passes.sell_in = 5
        expect do
          GildedRose.new([backstage_passes]).update_quality
        end.to change { backstage_passes.quality }.by(3)
      end

      it 'drops the quality to 0 after the concert' do
        backstage_passes.sell_in = -1
        GildedRose.new([backstage_passes]).update_quality
        expect(backstage_passes.quality).to eq(0)
      end
    end

    context 'when the item is Conjured' do
      let(:conjured) { build(:item, name: 'Conjured Mana Cake') }

      it 'decreases quality twice as fast' do
        expect do
          GildedRose.new([conjured]).update_quality
        end.to change { conjured.quality }.by(-2)
      end
    end
  end
end
