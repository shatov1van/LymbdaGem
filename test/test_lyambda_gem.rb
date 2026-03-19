# frozen_string_literal: true

require "test_helper"


class TestLyambdaGem < Minitest::Test 
  include LyambdaGem

  def setup
    @x = var("x")
    @y = var("y")
    @z = var("z")
    @u = var("u")
    @t = var("t")
    @v = var("v")
    @w = var("w")
  end

  def test_that_it_has_a_version_number
    refute_nil ::LyambdaGem::VERSION
  end

  #Проверка редуцирования (λx.((x(x(yz)))x)(λu.(uv)) -> ((((yz)v)v)(λu.(uv)))
  def test_complex_reduction
    term = app(
      abs(@x, app(app(@x, app(@x, app(@y, @z))), @x)),
      abs(@u, app(@u, @v)))

    assert_equal "((((y z) v) v) (λu.(u v)))", Reducer.to_normal(term).to_s
  end

  # Правила 1-2: [N/x]x = N и [N/x]y = y (если x ≠ y)
  def test_rules_1_2
    # Правило 1: [N/x]x = N
    term1 = app(abs(@x, @x), @y)
    assert_equal "y", Reducer.to_normal(term1).to_s

    # Правило 2: [N/x]y = y (если x ≠ y)
    term2 = app(abs(@x, @z), @y)
    assert_equal "z", Reducer.to_normal(term2).to_s
    
    # Вложенная абстракция
    term3 = app(abs(@x, abs(@y, @z)), @y)
    assert_equal "(λy.z)", Reducer.to_normal(term3).to_s
  end

  # Правило 3: [N/x](PQ) = ([N/x]P)([N/x]Q)
  def test_rule_3
    term1 = app(abs(@v, app(@u, @v)), app(@v, @v))
    assert_equal "(u (v v))", 
                 Reducer.to_normal(term1).to_s
    
    term2 = app(abs(@v, app(@z, @y)), @x)
    assert_equal "(z y)", Reducer.to_normal(term2).to_s
    
    term3 = app(abs(@v, app(@u, @v)), @v)
    assert_equal "(u v)", Reducer.to_normal(term3).to_s
  end

  # Правило 4: [N/x](λx.P) = λx.P
  def test_rule_4
    term1 = app(abs(@x, abs(@x, @z)), @y)
    assert_equal "(λx.z)", Reducer.to_normal(term1).to_s
    
    term2 = app(abs(@z, abs(@z, @y)), @v)
    assert_equal "(λz.y)", Reducer.to_normal(term2).to_s
    
    term3 = app(abs(@x, abs(@x, app(@y, @x))), app(@x, @v))
    assert_equal "(λx.(y x))", Reducer.to_normal(term3).to_s
  end

  # Правило 5: [N/x](λy.P) = λy.P, если x ∉ FV(P)
  def test_rule_5
    term1 = app(abs(@x, abs(@y, @y)), @u)
    assert_equal "(λy.y)", Reducer.to_normal(term1).to_s
    
    inner = abs(@v, app(@y, @v))
    term2 = app(abs(@v, abs(@y, app(@x, inner))), @u)
    assert_equal "(λy.(x (λv.(y v))))", 
                 Reducer.to_normal(term2).to_s
    
    term3 = app(abs(@x, abs(@z, abs(@x, @y))), @u)
    assert_equal "(λz.(λx.y))", Reducer.to_normal(term3).to_s
  end

  # Правило 6: [N/x](λy.P) = λy.[N/x]P, если x ∈ FV(P) и y ∉ FV(N)
  def test_rule_6
    term1 = app(abs(@x, abs(@y, @x)), @u)
    assert_equal "(λy.u)", Reducer.to_normal(term1).to_s
    
    term3 = app(abs(@x, abs(@u, app(app(@z, @z), @x))), @t)
    assert_equal "(λu.((z z) t))", 
                 Reducer.to_normal(term3).to_s
  end

  # Правило 7: [N/x](λy.P) = λz.[N/x]([z/y]P), если x ∈ FV(P) и y ∈ FV(N)
  def test_rule_7
    term1 = app(abs(@x, abs(@u, app(@x, @u))), @u)
    result1 = Reducer.to_normal(term1).to_s
    assert_match(/λz\d*\.\(u z\d*\)/, result1) # d* это типо новая переменная
    
    term3 = app(abs(@t, abs(@w, app(@x, app(@z, @t)))), @w)
    result3 = Reducer.to_normal(term3).to_s
    refute_includes result3, "λw"
  end
end
