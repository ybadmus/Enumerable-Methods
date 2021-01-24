%w[Accra Lagos Lome Cotonou Bamako].my_each { |friend| puts friend }
%w[Accra Lagos Lome Cotonou Bamako].my_each_with_index { |friend, i| puts "#{friend}, #{i}" }
%w[Accra Lagos Lome Cotonou Bamako].my_select { |city| city != 'Lagos' }
%w[ant bear cat].my_all? { |word| word.length >= 3 }
%w[ant bear cat].my_all? { |word| word.length >= 4 }
%w[ant bear cat].my_all?(/t/)
[1, 2i, 3.14].my_all?(Numeric)
[nil, true, 99].my_all?
[].my_all?

%w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
%w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
%w[ant bear cat].my_any?(/d/) #=> false
[nil, true, 99].my_any?(Integer) #=> true
[nil, true, 99].my_any? #=> true
[].my_any? #=> false

%w[ant bear cat].my_none? { |word| word.length == 5 } #=> true
%w[ant bear cat].my_none? { |word| word.length >= 4 } #=> false
%w[ant bear cat].my_none?(/d/) #=> true
[1, 3.14, 42].my_none?(Float) #=> false
[].my_none? #=> true
[nil].my_none? #=> true
[nil, false].my_none? #=> true
[nil, false, true].my_none? #=> false

[1, 2, 4, 2].my_count #=> 4
[1, 2, 4, 2].my_count(2) #=> 2
[1, 2, 4, 2].my_count(&:even?) #=> 3

(1..4).my_map { |i| i * i } #=> [1, 4, 9, 16]
my_proc = proc { |i| i * i }
[2, 5, 7, 4, 2].my_map(&my_proc)

(5..10).my_inject(:+)

(5..10).my_inject(1, :*)

(5..10).my_inject { |sum, n| sum + n }

(5..10).my_inject(1) { |product, n| product * n }

longest = %w[cat sheep bear antelope cattle].my_inject do |memo, word|
  memo.length > word.length ? memo : word
end

puts longest

multiply_els([2, 4, 5])
