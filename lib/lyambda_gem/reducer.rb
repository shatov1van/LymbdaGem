module LyambdaGem
  module Reducer
    def self.to_normal(term, strategy: :normal_order, verbose: false)
      step = 0
      puts "##{step} #{term}" if verbose
      while term.reduceable?
        term = term.reduce(strategy: strategy)

        step += 1
        puts "##{step} #{term}" if verbose
      end
      term
    end
  end
end