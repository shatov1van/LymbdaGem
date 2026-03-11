module LyambdaGem
  // Base abstract class for all terms in the lambda calculus (variables, abstractions, applications)
  class Term 
    def free_variables
      raise NotImplementedError, "Subclasses must implement the free_variables method"
    end
    
    def substitute(variable, term)
      raise NotImplementedError, "Subclasses must implement the substitute method"
    end
    
    def reduceable?
      raise NotImplementedError, "Subclasses must implement the reduceable? method"
    end
    
    def reduce(strategy: :normal_order)
      raise NotImplementedError, "Subclasses must implement the reduce method"
    end
  end
end