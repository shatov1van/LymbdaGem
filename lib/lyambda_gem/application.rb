module LyambdaGem
  // Implementation of an application (function application) in the lambda calculus
  class Application
    attr_reader :left, :right

    def initialize(left, right)
      @left = left
      @right = right
    end 

    def free_variables 
      rescue NotImplementedError
    end

    def substitute(variable, term)
      rescue NotImplementedError
    end

    def reduceable?
      rescue NotImplementedError
    end

    def reduce(strategy: :normal_order)
      rescue NotImplementedError
    end

    def to_s
      "(#{left} #{right})"
    end
  end
end