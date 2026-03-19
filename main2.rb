require_relative "lib/lyambda_gem"

include LyambdaGem

x = var("x")
y = var("y")
z = var("z")
u = var("u")
t = var("t")
v = var("v")

app1 = app(abs(x,  app( app(x,  app(x, app(y, z)) ), x)), abs(u, app(u, v)))

puts "((((yz)v)v)(λu.(uv)))"
puts app1
puts LyambdaGem::Reducer.to_normal(app1, verbose: true).to_s

term1 = app(abs(v, app(u, v)), app(v, v))
puts term1
puts Reducer.to_normal(term1, verbose: true).to_s

term1 = app(abs(x, abs(u, app(x, u))), u)
puts term1
puts Reducer.to_normal(term1, verbose: true).to_s