defmodule DdstestTest do
  use ExUnit.Case
  doctest Ddstest

  test "greets the world" do
    assert Ddstest.hello() == :world
  end
end
