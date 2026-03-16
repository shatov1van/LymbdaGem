require_relative 'term'
require_relative 'variable'
require_relative 'abstraction'
require_relative 'application'
require_relative 'version'

def to_normal(term) 
    puts "#{term}"
    while term.reduceable?
        term = term.reduce
        puts "#{term}"
    end
    term.reduce
    # puts "#{term.left}  | r-le: #{term.left.reduceable?} "
    # puts "#{term.right}  | r-le: #{term.right.reduceable?} "
end

module LyambdaGem
    x = Variable.new("x")
    y = Variable.new("y")
    z = Variable.new("z")
    u = Variable.new("u")

    #abs1 = Abstraction.new(x, Application.new(z, x))
    abs2 = Abstraction.new(y, Application.new(y, x))

    app1 = Application.new(abs2, Application.new(u, x))
    abs3 = Abstraction.new(u, app1)
    app2 = Application.new(abs3, Abstraction.new(z, Application.new(y, z)))
    #puts app2.left
    #puts app2.right
    to_normal(app2)
    # puts app1
    # appnew = app1.reduce
    # puts appnew
    # puts "#{app1}  -  fv:#{app1.free_variables }"
    # puts "#{abs2}  -  fv:#{abs2.free_variables }" 
    # puts "#{appnew}  -  fv:#{appnew.free_variables }" 

end