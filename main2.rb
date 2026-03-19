require_relative "lib/lyambda_gem"

include LyambdaGem

x = var("x")
y = var("y")
z = var("z")
u = var("u")
t = var("t")
v = var("v")

app = app(
  abs(x, 
    app(
      app(x, 
        app(x, app(y, z))
      ), 
      x
    )
  ),
  abs(u, app(u, v))
)

puts "((((yz)v)v)(λu.(uv)))"
puts app
puts LyambdaGem::Reducer.to_normal(app, verbose: true).to_s