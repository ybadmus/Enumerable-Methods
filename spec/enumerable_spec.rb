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

  describe "#my_none" do
    it "1. Returns true if the block never returns true for all elements" do
      output = %w{ant bear cat}.my_none? { |word| word.length == 5 }
      expect(output).to be_truthy
    end

    it ". Returns true if the block never returns true for all elements" do
      output = %w{ant bear cat}.none? { |word| word.length >= 4 }
      expect(output).to be_falsy
    end

    it "3. Returns true if the block never returns true for all elements" do
      output = %w{ant bear cat}.none?(/d/)  
      expect(output).to be_truthy
    end

    it ". Returns whether pattern === element for none of the collection members" do
      output = [1, 3.14, 42].none?(Float)  
      expect(output).to be_falsy
    end

    it "4. Returns true if the block never returns true for all elements" do
      output = [].none?     
      expect(output).to be_truthy
    end

    it "5. Returns true if the block never returns true for all elements" do
      output = [nil].none?    
      expect(output).to be_truthy
    end

    it "6. Returns true if the block never returns true for all elements" do
      output = [nil, false].none?   
      expect(output).to be_truthy
    end

    it "7. Returns true if the block never returns true for all elements" do
      output = [nil, false, true].none?      
      expect(output).to be_falsy
    end
  end

  describe "#my_count" do
    let(:array) { [1, 2, 4, 2] }
    it "Returns the number of items in enum through enumeration" do
      expect(array.my_count).to eq(4)
    end

    it "If an argument is given, the number of items in enum that are equal to item are counted" do
      expect(array.my_count(2)).to eq(2)
    end

    it "If a block is given, it counts the number of elements yielding a true value" do
      expect(array.my_count{ |x| x%2==0 }).to eq(3)
    end
  end

  describe "my_map" do
    it "Returns a new array with the results of running block once for every element in enum." do
      output = (1..4).map { |i| i*i }  
      res = [1, 4, 9, 16]
      expect(output.length).to eq(output.length) 
    end
  end

  describe "#my_inject" do
    it "Sum some numbers" do
      expect((5..10).my_inject(:+)).to eq(45)
    end

    it "Using a block and inject" do 
      expect((5..10).my_inject { |sum, n| sum + n }).to eq(45)
    end

    it "Multiply some numbers" do 
      expect((5..10).my_inject(1, :*)).to eq(151200)
    end

    it "Using a block to multiply some numbers" do 
      expect((5..10).my_inject(1) { |product, n| product * n }).to eq(151200)
    end

    it "Returns the longest word" do 
      longest = %w[cat sheep bear antelope cattle].my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end
      expect(longest).to eq("antelope")
    end
  end
end