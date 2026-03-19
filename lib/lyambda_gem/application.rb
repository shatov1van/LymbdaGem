module LyambdaGem
  #Implementation of an application (function application) in the lambda calculus
  class Application < Term
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end

    #Список свободных переменных
    def free_variables 
      return @left.free_variables + @right.free_variables
    end

    def substitute(term, variable)
      return Application.new(@left.substitute(term, variable), @right.substitute(term, variable))
    end

    def reduceable?
      return @left.is_a?(Abstraction) || @left.reduceable? || @right.reduceable?
    end

    def reduce(strategy: :normal_order)
      #puts "  app:#{self.to_s} | r-able: #{reduceable?}"
      return self unless reduceable?
      #puts @left.body.substitute(@right, @left.parameter)
      return @left.body.substitute(@right, @left.parameter) if @left.is_a?(Abstraction)

      return Application.new(@left.reduce, @right) if @left.reduceable? 

      return Application.new(@left, @right.reduce) if @right.reduceable? 
    end

    def to_s
      "(#{@left.to_s} #{@right.to_s})"
    end
  end
end