module Enumerable
  def my_each
    return to_enum(:self) unless block_given?

    i = 0

    while i < to_a.length
      yield to_a[i]
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:self) unless block_given?

    i = 0

    while i < to_a.length
      yield to_a[i], i
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:self) unless block_given?

    new_arr = []
    to_a.my_each { |city| new_arr << city if yield city }
    puts new_arr
  end

  def my_all?(param = nil)
    has_block = block_given? ? true : false

    if has_block && param.nil?
      ret = true

      to_a.my_each do |item|
        ret = false unless yield item
      end

      return puts ret
    end

    if !has_block && !param.nil?
      ret = true

      if param.instance_of?(Regexp)
        to_a.my_each { |item| ret = false unless item.match(param) }
      elsif param.instance_of?(Class)
        to_a.my_each { |item| ret = false unless [item.class, item.class.superclass].include?(param) }
      end

      return puts ret
    end

    if !has_block && param.nil?
      ret = true

      to_a.my_each { |item| ret = false unless item }

      puts ret
    end
  end

  def my_any?(param = nil)
    has_block = block_given? ? true : false

    if has_block && param.nil?
      ret = false

      to_a.my_each do |item|
        ret = true if yield item
      end

      return puts ret
    end

    if !has_block && !param.nil?
      ret = false

      if param.instance_of?(Regexp)
        to_a.my_each { |item| ret = true if item.match(param) }
      elsif param.instance_of?(Class)
        to_a.my_each { |item| ret = true if [item.class, item.class.superclass].include?(param) }
      end

      return puts ret
    end

    if !has_block && param.nil?
      ret = false

      to_a.my_each { |item| ret = true if item }

      puts ret
    end
  end

  def my_none?(param = nil)
    has_block = block_given? ? true : false

    if has_block && param.nil?
      ret = true

      to_a.my_each do |item|
        ret = false if yield item
      end

      return puts ret
    end

    if !has_block && !param.nil?
      ret = true

      if param.instance_of?(Regexp)
        to_a.my_each { |item| ret = false if item.match(param) }
      elsif param.instance_of?(Class)
        to_a.my_each { |item| ret = false if [item.class, item.class.superclass].include?(param) }
      end

      return puts ret
    end

    if !has_block && param.nil?
      ret = true

      to_a.my_each { |item| ret = false if item }

      puts ret
    end
  end

  def my_count(param = nil)
    return puts param if !param.nil? && !block_given?

    return puts to_a.length if param.nil? && !block_given?

    if param.nil? && block_given?
      count = 0
      to_a.my_each { |item| count += 1 if yield item }
      puts count
    end
  end

  def my_map(proc = nil)
    return puts to_enum(:self) unless block_given? || proc

    new_arr = []

    if proc
      my_each { |item| new_arr << proc.call(item) }
    else
      to_a.my_each { |item| new_arr << yield(item) }
    end

    puts new_arr
  end

  def my_inject(initial = nil, symb = nil)
    if block_given?

      if initial.nil? && symb.nil?

        accumulator = to_a[0]
        to_a.my_each_with_index { |item, index| accumulator = yield(accumulator, item) if index.positive? }
        puts accumulator

      elsif !initial.nil? && symb.nil?

        accumulator = initial
        to_a.my_each { |item, _index| accumulator = yield(accumulator, item) }
        puts accumulator

      end

    elsif !initial.nil? && symb.nil?

      accumulator = 0
      to_a.my_each { |item| accumulator = accumulator.send(initial, item) }
      puts accumulator

    elsif !initial.nil? && !symb.nil?

      accumulator = initial
      if symb.is_a?(Symbol) || symb.is_a?(String)
        to_a.my_each do |item|
          accumulator = accumulator.send(symb, item)
        end
      end
      puts accumulator

    end
  end
end

def multiply_els(param = nil)
  param&.my_inject { |accumulator, item| accumulator * item }
end

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
