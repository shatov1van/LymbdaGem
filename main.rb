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
    v = Variable.new("v")
    w = Variable.new("w")
    t = Variable.new("t")
    z1 = Variable.new("z1")

    app = Application.new(Abstraction.new(x, Application.new(Application.new(x, Application.new(x, Application.new(y,z))), x)), Abstraction.new(u, Application.new(u, v)))
    puts "Тест 1: на лямбде #{app.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app).to_s}"

    puts "\n\nПроверка правил подстановки:\n"

    app21 = Application.new(Abstraction.new(x, x), y)
    puts "\n\nТест №2:"
    puts "Проверка правила №1-2: [N/x]x = (N) и [N/x]y = (y) (если x != y)"
    puts "Тест 2.1: на лямбде #{app21.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app21).to_s}"

    app22 = Application.new(Abstraction.new(x, z), y)
    puts "\nТест 2.2: на лямбде #{app22.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app22).to_s}"

    app23 = Application.new(Abstraction.new(x, Abstraction.new(y, z)), y)
    puts "\nТест 2.3: на лямбде #{app23.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app23).to_s}"

    puts "\n\nТест №3:"
    puts "Проверка правила №3: [N/x](PQ) = (([N/x]P)([N/x]Q))"
    app31 = Application.new(Abstraction.new(v, Application.new(u, v)), Application.new(v, v))
    puts "\nТест 3.1: на лямбде #{app31.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app31).to_s}"

    app32 = Application.new(Abstraction.new(v, Application.new(z, y)), x)
    puts "\nТест 3.2: на лямбде #{app32.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app32).to_s}"

    app33 = Application.new(Abstraction.new(v, Application.new(u, v)), v)
    puts "\nТест 3.3: на лямбде #{app33.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app33).to_s}"
    
    puts "\n\nТест №4:"
    puts "Проверка правила №4: [N/x](λx.P) = (λx.P)"
    app41 = Application.new(Abstraction.new(x, Abstraction.new(x, z)), y)
    puts "\nТест 4.1: на лямбде #{app41.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app41).to_s}"

    app42 = Application.new(Abstraction.new(z, Abstraction.new(z, y)), v)
    puts "\nТест 4.2: на лямбде #{app42.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app42).to_s}"

    app43 = Application.new(Abstraction.new(x, Abstraction.new(x, Application.new(y,x))), Application.new(x, v))
    puts "\nТест 4.3: на лямбде #{app43.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app43).to_s}"
    
    puts "\n\nТест №5:"
    puts "Проверка правила №5: [N/x](λy.P) = (λy.P), (если free_variables(P).include?(x) == false"
    app51 = Application.new(Abstraction.new(x, Abstraction.new(y, y)), u)
    puts "\nТест 5.1: на лямбде #{app51.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app51).to_s}"

    app52 = Application.new(Abstraction.new(v, Abstraction.new(y, Application.new(x, Abstraction.new(v, Application.new(y,v))))), u)
    puts "\nТест 5.2: на лямбде #{app52.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app52).to_s}"

    app53 = Application.new(Abstraction.new(x, Abstraction.new(z, Abstraction.new(x, y))), u)
    puts "\nТест 5.3: на лямбде #{app53.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app53).to_s}"
    
    puts "\n\nТест №6:"
    puts "Проверка правила №6: [N/x](λy.P) = (λy.([N/x]P)),\n(если free_variables(P).include?(y) == true && free_variables(N).include?(y) == false"
    app61 = Application.new(Abstraction.new(x, Abstraction.new(y, x)), u)
    puts "\nТест 6.1: на лямбде #{app61.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app61).to_s}"

    app62 = Application.new(Abstraction.new(t, Abstraction.new(y, Application.new(t, z))), Abstraction.new(y, Application.new(y, v)))
    puts "\nТест 6.2: на лямбде #{app62.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app62).to_s}"

    app63 = Application.new(Abstraction.new(x, Abstraction.new(u, Application.new(Application.new(z, z), x))), t)
    puts "\nТест 6.3: на лямбде #{app63.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app63).to_s}"
    
    puts "\n\nТест №7:"
    puts "Проверка правила №7: [N/x](λy.P) = (λz.([N/x]([z/y]P))),\n(если free_variables(P).include?(y) == true && free_variables(N).include?(y) == true && free_variables(NP).include?(z) == false"
    app71 = Application.new(Abstraction.new(x, Abstraction.new(u, Application.new(x, u))), u)
    puts "\nТест 7.1: на лямбде #{app71.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app71).to_s}"

    app72 = Application.new(Abstraction.new(u, Application.new(Abstraction.new(z1, Application.new(u, z1)), Application.new(u, t))), Application.new(w, z1))
    puts "\nТест 7.2: на лямбде #{app72.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app72).to_s}"

    app73 = Application.new(Abstraction.new(t, Abstraction.new(w, Application.new(x, Application.new(z,t)))), w)
    puts "\nТест 7.3: на лямбде #{app73.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(app73).to_s}"

    z2 = Variable.new("z2")
    appbeta = Application.new(Abstraction.new(z1, Abstraction.new(z2, Application.new(w, z1))), Application.new(w, z2))
    puts "\nТест бета: на лямбде #{appbeta.to_s}\nРедуцирование:\n"
    puts "Результат: #{to_normal(appbeta).to_s}"
end