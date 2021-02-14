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

  describe '#my_each_with_index' do
    let(:list) { %w[Accra Lagos Lome Cotonou Bamako] }
      subject(:res) do
        {
          Accra: 0,
          Lagos: 1,
          Lome: 2,
          Cotonou: 3,
          Bamako: 4,
        }
      end

    it "lists all the items in the Array and their corresponding index" do
      
      output = Hash.new
      list.my_each_with_index { |item, index| output[:item] = index }
      expect(res).to eq(res)
    end
  end

  describe '#my_select' do
    it "Returns an array containing all elements of enum for which the given block returns a true value." do
      output = [1,2,3,4,5].select { |num|  num.even?  } 
      res = [2, 4]
      expect(res.sum).to eq(output.sum)
    end
  end
end