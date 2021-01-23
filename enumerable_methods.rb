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
    new_arr
  end

  def my_all?(param = nil)
    has_block = block_given? ? true : false

    if has_block && param.nil?
      ret = true

      to_a.my_each do |item|
        ret = false unless yield item
      end

      return ret
    end

    if !has_block && !param.nil?
      ret = true

      if param.instance_of?(Regexp)
        to_a.my_each { |item| ret = false unless item.match(param) }
      elsif param.instance_of?(Class)
        to_a.my_each { |item| ret = false unless [item.class, item.class.superclass].include?(param) }
      end

      return ret
    end

    if !has_block && param.nil?
      ret = true

      to_a.my_each { |item| ret = false unless item }

      ret
    end
  end

  def my_any?(param = nil)
    has_block = block_given? ? true : false

    if has_block && param.nil?
      ret = false

      to_a.my_each do |item|
        ret = true if yield item
      end

      return ret
    end

    if !has_block && !param.nil?
      ret = false

      if param.instance_of?(Regexp)
        to_a.my_each { |item| ret = true if item.match(param) }
      elsif param.instance_of?(Class)
        to_a.my_each { |item| ret = true if [item.class, item.class.superclass].include?(param) }
      end

      return ret
    end

    if !has_block && param.nil?
      ret = false

      to_a.my_each { |item| ret = true if item }

      ret
    end
  end

  def my_none?(param = nil)
    has_block = block_given? ? true : false

    if has_block && param.nil?
      ret = true

      to_a.my_each do |item|
        ret = false if yield item
      end

      return ret
    end

    if !has_block && !param.nil?
      ret = true

      if param.instance_of?(Regexp)
        to_a.my_each { |item| ret = false if item.match(param) }
      elsif param.instance_of?(Class)
        to_a.my_each { |item| ret = false if [item.class, item.class.superclass].include?(param) }
      end

      return ret
    end

    if !has_block && param.nil?
      ret = true

      to_a.my_each { |item| ret = false if item }

      ret
    end
  end

  def my_count(param = nil)
    return param if !param.nil? && !block_given?

    return to_a.length if param.nil? && !block_given?

    if param.nil? && block_given?
      count = 0
      to_a.my_each { |item| count += 1 if yield item }
      count
    end
  end

  def my_map(proc = nil)
    return to_enum(:self) unless block_given? || proc

    new_arr = []

    if proc
      my_each { |item| new_arr << proc.call(item) }
    else
      to_a.my_each { |item| new_arr << yield(item) }
    end

    new_arr
  end

  def my_inject(initial = nil, symb = nil)
    if block_given?

      if initial.nil? && symb.nil?

        accumulator = to_a[0]
        to_a.my_each_with_index { |item, index| accumulator = yield(accumulator, item) if index.positive? }
        accumulator

      elsif !initial.nil? && symb.nil?

        accumulator = initial
        to_a.my_each { |item, _index| accumulator = yield(accumulator, item) }
        accumulator

      end

    elsif !initial.nil? && symb.nil?

      accumulator = 0
      to_a.my_each { |item| accumulator = accumulator.send(initial, item) }
      accumulator

    elsif !initial.nil? && !symb.nil?

      accumulator = initial
      if symb.is_a?(Symbol) || symb.is_a?(String)
        to_a.my_each do |item|
          accumulator = accumulator.send(symb, item)
        end
      end
      accumulator

    end
  end
end

def multiply_els(param = nil)
  param&.my_inject { |accumulator, item| accumulator * item }
end
