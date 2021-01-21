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

end