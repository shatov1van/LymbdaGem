module LyambdaGem
  // Implementation of an abstraction (lambda function) in the lambda calculus
  class Abstraction < Term
    attr_reader :parameter, :body
    
    def initialize(parameter, body)
      @parameter = parameter
      @body = body
    end

    def free_variables
      body.free_variables - [parameter]
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
      "λ#{parameter}.#{body}"
    end
  end
end