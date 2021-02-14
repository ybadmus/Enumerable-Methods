require_relative '../enumerable_methods'

describe Enumerable do
  describe '#my_each' do
    let(:list) { %w[Accra Lagos Lome Cotonou Bamako] }

    it "Returns a list of all items in an Array" do
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

    it "Lists all the items in the Array and their corresponding index" do
      
      output = Hash.new
      list.my_each_with_index { |item, index| output[:item] = index }
      expect(res).to eq(res)
    end
  end

  describe '#my_select' do
    it "Returns an array containing all elements of enum for which the given block returns a true value." do
      res = [2, 4]
      output = [1,2,3,4,5].my_select { |num|  num.even?  } 
      expect(res.sum).to eq(output.sum)
    end
  end

  describe '#my_all' do
    it "1. The method returns true if the block never returns false or nil" do
      output = %w[ant bear cat].my_all? { |word| word.length >= 3 }
      expect(output).to be_truthy
    end

    it "2. The method returns true if the block never returns false or nil" do
      output = %w[ant bear cat].my_all? { |word| word.length >= 4 }
      expect(output).to be_falsy
    end

    it "3. The method returns true if the block never returns false or nil" do
      output = [nil, true, 99].my_all?    
      expect(output).to be_falsy
    end

    it "4. The method returns true if the block never returns false or nil" do
      output = [].my_all?             
      expect(output).to be_truthy
    end

    it "1. Returns whether pattern === element for every collection member." do
      output = %w[ant bear cat].my_all?(/t/)  
      expect(output).to be_falsy
    end

    it "2. Returns whether pattern === element for every collection member." do
      output = [1, 2i, 3.14].my_all?(Numeric)   
      expect(output).to be_truthy
    end
  end

  describe "#my_any" do
    it "1. The method returns true if the block ever returns a value other than false or nil" do
      output = %w[ant bear cat].my_any? { |word| word.length >= 3 }
      expect(output).to be_truthy
    end

    it "2. The method returns true if the block ever returns a value other than false or nil" do
      output = %w[ant bear cat].my_any? { |word| word.length >= 4 }
      expect(output).to be_truthy
    end

    it "1. Returns whether pattern === element for any collection member." do
      output = %w[ant bear cat].my_any?(/d/)  
      expect(output).to be_falsy
    end

    it "3. Returns whether pattern === element for any collection member." do
      output = [nil, true, 99].my_any?(Integer)  
      expect(output).to be_truthy
    end

    it "2. Return true if at least one of the collection members is not false or nil" do
      output = [nil, true, 99].my_any?    
      expect(output).to be_truthy
    end

    it "4. The method returns true if the block ever returns a value other than false or nil." do
      output = [].my_any?             
      expect(output).to be_falsy
    end
  end
end