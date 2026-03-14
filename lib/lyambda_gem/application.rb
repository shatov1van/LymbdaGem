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
      return (@left + @right).uniq
    end

    def substitute(term, variable)
      return Application.new(@left.substitute(term, variable), @right.substitute(term, variable))
    end

    def reduceable?
      return @left.is_a?(Abstraction)
    end

    def reduce(strategy: :normal_order)
      rescue NotImplementedError
    end

    def to_s
      "(#{@left.to_s}#{@right.to_s})"
    end
  end
end