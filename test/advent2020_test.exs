defmodule Advent2020Test do
  use ExUnit.Case
  require Logger

  doctest Advent2020

  describe "Puzzle #1" do
    import Advent2020.Puzzle01
    doctest Advent2020.Puzzle01

    test "Part 1" do
      assert part1() == 388075
    end

    test "Part 2" do
      assert part2() == 293450526
    end
  end

  describe "Puzzle #2" do
    import Advent2020.Puzzle02
    doctest Advent2020.Puzzle02

    test "Part 1" do
      assert part1() == 474
    end

    test "Part 2" do
      assert part2() == 745
    end

  end

  describe "Puzzle #3" do
    import Advent2020.Puzzle03

    doctest Advent2020.Puzzle03

    test "Part 1" do
      assert part1() == 232
    end

    test "Part 2" do
      assert part2() == 3952291680
    end
  end
end
