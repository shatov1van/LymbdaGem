# frozen_string_literal: true

require "test_helper"

class TestLyambdaGem < Minitest::Test

  def setup
    @x = LyambdaGem::Variable.new("x")
    @y = LyambdaGem::Variable.new("y")
    @z = LyambdaGem::Variable.new("z")
    @u = LyambdaGem::Variable.new("u")
    @t = LyambdaGem::Variable.new("t")
    @v = LyambdaGem::Variable.new("v")
  end

  def test_that_it_has_a_version_number
    refute_nil ::LyambdaGem::VERSION
  end

  #Проверка редуцирования (λx.((x(x(yz)))x)(λu.(uv)) -> ((((yz)v)v)(λu.(uv)))
  def test_reduce_one
    app = LyambdaGem::Application.new(LyambdaGem::Abstraction.new(@x, LyambdaGem::Application.new(LyambdaGem::Application.new(@x, LyambdaGem::Application.new(@x, LyambdaGem::Application.new(@y,@z))), @x)), LyambdaGem::Abstraction.new(@u, LyambdaGem::Application.new(@u, @v)))
    assert_equal "((((yz)v)v)(λu.(uv)))", LyambdaGem::Reducer.to_normal(app).to_s
  end
end
