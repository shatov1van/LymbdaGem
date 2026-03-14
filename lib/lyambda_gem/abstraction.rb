module LyambdaGem
  #Implementation of an abstraction (lambda function) in the lambda calculus
  class Abstraction < Term
    attr_reader :parameter, :body
    
    def initialize(parameter, body)
      @parameter = parameter
      @body = body
    end

    #Список свободных переменных
    def free_variables
      return @body.free_variables.reject{|x| x == parameter}
    end

    #Подстановка
    def substitute(term, variable)
      if variable == @parameter
        self
      end
      #...
    end

    def reduceable?
      @body.reduceable?
    end

    def reduce(strategy: :normal_order)
      #rescue NotImplementedError
    end

    def to_s
      "(λ#{parameter}.#{body})"
    end
  end
end