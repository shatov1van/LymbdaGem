require_relative 'term'
require_relative 'variable'
require_relative 'abstraction'
require_relative 'application'
require_relative 'version'

module LyambdaGem
    x = Variable.new("x")
    y = Variable.new("y")
    z = Variable.new("z")
    u = Variable.new("u")

    #abs1 = Abstraction.new(x, Application.new(z, x))
    abs2 = Abstraction.new(y, Application.new(y, x))

    app1 = Application.new(abs2, Application.new(z, u))
    puts app1
    appnew = app1.reduce
    puts appnew.to_s
end