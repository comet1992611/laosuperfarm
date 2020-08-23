module SVF
  class Line
    attr_reader :name, :key, :cells, :children, :to

    def initialize(name, key, cells, children = [], to = nil)
      @name = name.to_sym
      @key = key
      @cells = [] # ActiveSupport::OrderedHash.new
      if cells
        cells.each do |cell|
          cell.each do |name, definition|
            unless c = Cell.new(name, definition, @key.length + @cells.inject(0) { |s, c| s += c.length })
              raise "Element #{@name} has an cell #{name} with no definition"
            end
            @cells << c
          end
        end
      end
      @children = SVF.occurrencify(children || [])
      @to = to
    end

    def class_name(prefix = nil)
      if prefix.nil?
        @name.to_s.classify
      else
        "SVF::#{prefix.to_s.classify}::Lines::#{class_name}"
      end
    end

    def inspect
      i = "#{name}(#{key}) #{@cells.inspect}"
      i << "\n" + @children.collect { |c| c.inspect.gsub(/^/, '  ') }.join("\n") unless @children.empty?
      i
    end

    def has_cells?
      !@cells.size.zero?
    end

    def has_children?
      !@children.size.zero?
    end
  end
end
