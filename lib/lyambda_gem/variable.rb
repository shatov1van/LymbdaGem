module LyambdaGem
  // Implementation of a variable in the lambda calculus
  class Variable < Term
    attr_reader :name
    
    def initialize(name)
      @name = name
    end
    
    def free_variables
      [self]
    end
    
    def substitute(variable, term)
      self == variable ? term : self
    end
    
    def reduceable?
      false
    end
    
    def reduce(strategy: :normal_order)
      self
    end
    
    def to_s
      name.to_s
    end
    
    def ==(other)
      other.is_a?(Variable) && name == other.name
    end
  end
end