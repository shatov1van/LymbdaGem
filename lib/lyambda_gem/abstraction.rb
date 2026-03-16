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
      @body.free_variables - Set.new([@parameter])
    end

    #Получение новой переменной относительно терма (для правила 7)
    def fresh_variable(term)
      cnt = 1

      while term.free_variables.include?("x#{cnt}")
        cnt += 1
      end

      return Variable.new("x#{cnt}")     
    end

    #Подстановка
    def substitute(term, variable)
      #puts "p:#{@parameter} | body:#{@body} | t:#{term} | v:#{variable}"
      return self if variable == @parameter

      return self if !@body.free_variables.include?(variable)
      
      return Abstraction.new(@parameter, @body.substitute(term, variable)) if !term.free_variables.include?(@parameter)

      new_variable = fresh_variable((Application.new(term, @body)))
      return Abstraction.new(new_variable, @body.substitute(new_variable, @parameter).substitute(term, variable))
    end

    def reduceable?
      @body.reduceable?
    end

    def reduce(strategy: :normal_order)
      #puts "  abs:#{self.to_s} | r-able: #{reduceable?}"
      return self unless reduceable?

      return Abstraction.new(@parameter, @body.reduce)
    end

    def to_s
      "(λ#{parameter}.#{body})"
    end
  end
end