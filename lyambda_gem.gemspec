# frozen_string_literal: true

require_relative "lib/lyambda_gem/version"

Gem::Specification.new do |spec|
  spec.name          = "lyambda_gem"
  spec.version       = LyambdaGem::VERSION
  spec.authors       = ["shatov1van", "chokopiku61"]
  spec.email         = ["ivanshatov13@gmail.com", "tim.23tim23.23@gmail.com"]

  spec.summary       = "Lambda calculus interpreter and reducer"
  spec.description   = "A Ruby gem for parsing, reducing, and manipulating lambda calculus expressions"
  spec.homepage      = "https://github.com/shatov1van/LymbdaGem"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Указываем файлы явно: все .rb из lib/ + существующие LICENSE и README
  spec.files = Dir["lib/**/*.rb"] + 
               ["LICENSE", "README.md"].select { |f| File.exist?(f) }
  spec.require_paths = ["lib"]
end