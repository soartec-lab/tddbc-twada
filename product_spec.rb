require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product) { Product.new('name', 300) }

  describe '`#contract` は即時計上した金額を返す' do
    it '計上ロジックはサブクラス毎に異なる' do
      expect{ product.contract }.to raise_error(NotImplementedError)
    end
  end
end

RSpec.describe WordProcessor, type: :model do
  let(:word_processor) { WordProcessor.new('name', 300) }

  describe '#contract' do
    it '値段全てを即時計上する' do
      expect(word_processor.contract).to eq 300
    end
  end

  describe '#delayed_revenue' do
    it '値段から販売時に計上した額を引いた金額を計上する' do
      expect(word_processor.delayed_revenue).to eq 0
    end
  end
end

RSpec.describe SpreadSheet, type: :model do
  let(:spread_sheet) { SpreadSheet.new('name', 300) }

  describe '#contract' do
    it '値段の2/3を即時計上する' do
      expect(spread_sheet.contract).to eq 200
    end

    context '1/3が割り切れない場合' do
      let(:spread_sheet) { SpreadSheet.new('name', 301) }

      it do
        expect(spread_sheet.contract).to eq 200
      end
    end
  end

  describe '#delayed_revenue' do
    it '値段から販売時に計上した額を引いた金額を計上する' do
      expect(spread_sheet.delayed_revenue).to eq 100
    end
  end
end

RSpec.describe Database, type: :model do
  let(:database) { Database.new('name', 300) }

  describe '#contract' do
    it '値段の1/3を即時計上する' do
      expect(database.contract).to eq 100
    end
  end

  describe '#delayed_revenue' do
    it '値段から販売時に計上した額を引いた金額を計上する' do
      expect(database.delayed_revenue).to eq 200
    end
  end
end

 
