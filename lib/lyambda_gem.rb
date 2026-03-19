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
  
  def self.var(name)
    Variable.new(name)
  end
  
  def self.abs(param, body)
    Abstraction.new(param, body)
  end
  
  def self.app(left, right)
    Application.new(left, right)
  end
end
