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

    def my_all? (param = nil)

        block_given? ? has_block = true : has_block = false

        if has_block && param.nil?
            ret = true

            to_a.my_each do |item| 
                ret = false unless yield item 
            end

            return puts ret
        end

        if !has_block && !param.nil?
            ret = true

            if param.class == Regexp
                to_a.my_each { |item| ret = false unless item.match(param) } 
            elsif param.class == Class
                to_a.my_each { |item| ret = false unless [item.class, item.class.superclass].include?(param) } 
            end

            return puts ret
        end

        if !has_block && param.nil?
            ret = true

            to_a.my_each {  |item| ret = false unless item }

            return puts ret
        end

    end

    def my_any? (param = nil)
        
        block_given? ? has_block = true : has_block = false

        if has_block && param.nil?
            ret = false

            to_a.my_each do |item| 
                ret = true if yield item 
            end

            return puts ret
        end

        if !has_block && !param.nil?
            ret = false

            if param.class == Regexp
                to_a.my_each { |item| ret = true if item.match(param) } 
            elsif param.class == Class
                to_a.my_each { |item| ret = true if [item.class, item.class.superclass].include?(param) } 
            end

            return puts ret
        end

        if !has_block && param.nil?
            ret = false

            to_a.my_each {  |item| ret = true if item }

            return puts ret
        end

    end

    def my_none 

        block_given? ? has_block = true : has_block = false

        if has_block && param.nil?
            ret = true

            to_a.my_each do |item| 
                ret = false unless yield item 
            end

            return puts ret
        end

        if !has_block && !param.nil?
            ret = true

            if param.class == Regexp
                to_a.my_each { |item| ret = false unless item.match(param) } 
            elsif param.class == Class
                to_a.my_each { |item| ret = false unless [item.class, item.class.superclass].include?(param) } 
            end

            return puts ret
        end

        if !has_block && param.nil?
            ret = true

            to_a.my_each {  |item| ret = false unless item }

            return puts ret
        end

    end

    def my_count (param = nil)

        if !param.nil? && !block_given?
            return puts param
        end

        if param.nil? && !block_given?
            return puts to_a.length
        end

        if param.nil? && block_given?
            count = 0
            to_a.my_each { |item| count += 1 if yield item }
            return puts count
        end

    end

    def my_map

        return to_enum(:self) unless block_given? 

        new_arr = []

        to_a.my_each { |item| new_arr << yield item }

        return new_arr
    end

    def my_inject(initial = nil, symb = nil)

        if block_given?
            
            if initial.nil? && symb.nil?

                accumulator = to_a[0]
                to_a.my_each_with_index { |item, index| accumulator = yield(accumulator, item) if index > 0  }
                return puts accumulator

            elsif !initial.nil? && symb.nil?

                accumulator = initial
                to_a.my_each { |item, index| accumulator = yield(accumulator, item)  }
                return puts accumulator

            end

        else 

            if !initial.nil? && symb.nil?

                accumulator = 0
                to_a.my_each { |item| accumulator = accumulator.send(initial, item) }
                return puts accumulator

            elsif !initial.nil? && !symb.nil?

                accumulator = initial
                to_a.my_each { |item| accumulator = accumulator.send(symb, item) } if symb.is_a?(Symbol) || symb.is_a?(String)
                return puts accumulator

            end

        end
    end

end