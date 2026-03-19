# frozen_string_literal: true

require_relative "lyambda_gem/version"
require_relative "lyambda_gem/version"
require_relative "lyambda_gem/term"
require_relative "lyambda_gem/variable"
require_relative "lyambda_gem/abstraction"
require_relative "lyambda_gem/application"
require_relative "lyambda_gem/reducer"

module LyambdaGem
  class Error < StandardError; end

  extend self 

  def var(name)
    Variable.new(name)
  end
  
  def abs(param, body)
    Abstraction.new(param, body)
  end
  
  def app(left, right)
    Application.new(left, right)
  end

  module_function :var, :abs, :app
end
