defmodule Advent2020Test do
  use ExUnit.Case
  require Logger

  doctest Advent2020

  describe "Puzzle #1" do
    doctest Advent2020.Puzzle01

    test "Part 1" do
      assert Advent2020.Puzzle01.part1() == 388075
    end

    test "Part 2" do
      assert Advent2020.Puzzle01.part2() == 293450526
    end
  end

  describe "Puzzle #2" do
    doctest Advent2020.Puzzle02

    test "Part 1" do
      assert Advent2020.Puzzle02.part1() == 474
    end

    test "Part 2" do
      assert Advent2020.Puzzle02.part2() == 745
    end

  end
end
