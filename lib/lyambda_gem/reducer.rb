module LyambdaGem
  module Reducer
    def self.to_normal(term, strategy: :normal_order, verbose: false)
      step = 0
      puts "##{step} #{term}" if verbose
      while term.reduceable?
        term = term.reduce(strategy: strategy)

        step += 1
        puts "##{step} #{term}" if verbose
        if (step > 1000)
          puts "Редукция не завершилась за 1000 шагов, возможно бесконечный цикл. Прерывание."
          break
        end
      end
      term
    end
  end
end