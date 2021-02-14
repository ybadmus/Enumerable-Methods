require_relative '../enumerable_methods'

describe Enumerable do
  describe '#my_each' do
    let(:list) { %w[Accra Lagos Lome Cotonou Bamako] }

    it "returns a list of all items in an Array" do
      res = []
      list.my_each { |item| res << item }
      expect(res).to eq(list)
    end
  end
end