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

end