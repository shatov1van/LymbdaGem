# lib/lyambda_gem/parser.rb
module LyambdaGem
  class ParseError < StandardError; end

  class Parser
    def initialize(input)
      @tokens = input.gsub('λ', '\\')  # унифицируем
                     .scan(/[()\\\.]|[^\s()\\\.]+/)
      @pos = 0
    end

    def parse
      term = parse_expression
      raise ParseError, "Unexpected tokens after end: #{@tokens[@pos..].join(' ')}" unless @pos == @tokens.size
      term
      rescue ParseError => e
      raise e
      rescue => e
      raise ParseError, "Invalid syntax: #{e.message}"
    end

    private

    def current
      @tokens[@pos]
    end

    def advance
      @pos += 1
    end

    def parse_expression
      left = parse_atom
      while @pos < @tokens.size && current != ')' && current != '.'
        # Применение: следующая атомарная – аргумент
        right = parse_atom
        left = Application.new(left, right)
      end
      left
    end

    def parse_atom
      if current == '('
        advance
        expr = parse_expression
        raise ParseError, "Missing closing ')'" unless current == ')'
        advance
        expr
      elsif current == '\\'
        advance
        param_name = current
        raise ParseError, "Expected variable after '\\'" unless param_name && param_name !~ /[()\\\.]/
        advance
        raise ParseError, "Expected '.' after variable in abstraction" unless current == '.'
        advance
        body = parse_expression
        Abstraction.new(Variable.new(param_name), body)
      else
        # переменная
        name = current
        raise ParseError, "Unexpected token '#{name}'" if name.nil? || name.match?(/[()\\\.]/)
        advance
        Variable.new(name)
      end
    end
  end
end