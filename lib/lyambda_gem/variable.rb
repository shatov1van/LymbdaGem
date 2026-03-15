module LyambdaGem
  #Implementation of a variable in the lambda calculus
  class Variable < Term
    attr_reader :name
    
    def initialize(name)
      @name = name
    end
    
    #Список свободных переменных
    def free_variables
      return Set.new([@name])
    end
    
    #Подстановка
    def substitute(term, variable)
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
      other.is_a?(Variable) && @name == other.name
    end
  end
end