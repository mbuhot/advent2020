defmodule Advent2020 do

  @doc """
  Successive tails of a list

  ## Examples

      iex> Advent2020.tails([1,2,3,4,5])
      [
        [1,2,3,4,5],
        [2,3,4,5],
        [3,4,5],
        [4,5],
        [5]
      ]
  """
  @spec tails([a]) :: [[a]] when a: var
  def tails([]), do: []
  def tails([_head | tail] = list), do: [list | tails(tail)]

  @doc """
  Combinations of a list

  ## Examples

      iex> Advent2020.combinations([1,2,3,4,5], 3)
      [
        [1,2,3],
        [1,2,4],
        [1,2,5],
        [1,3,4],
        [1,3,5],
        [1,4,5],
        [2,3,4],
        [2,3,5],
        [2,4,5],
        [3,4,5],
      ]
  """
  @spec combinations([a], non_neg_integer()) :: [[a]] when a: var
  def combinations(_list, 0) do
    [[]]
  end
  def combinations([], _n) do
    []
  end
  def combinations([h | t], n) do
    Enum.map(combinations(t, n-1), &[h | &1]) ++ combinations(t, n)
  end

  defmodule Puzzle01 do
    @doc """
    Loads the input data converting to list of integers
    """
    @spec data :: [integer()]
    def data do
      "priv/puzzle01.txt"
      |> File.stream!()
      |> Stream.map(&String.trim/1)
      |> Enum.map(&String.to_integer/1)
    end

    @doc """
    Find the product of a combination from a list having the expected sum.

    ## Examples

    iex> Advent2020.Puzzle01.find_product_where_sum([1,2,3,4], 2, 6)
    2 * 4

    iex> Advent2020.Puzzle01.find_product_where_sum([1,2,3,4,5], 3, 11)
    2 * 4 * 5
    """
    @spec find_product_where_sum([integer], non_neg_integer, integer) :: integer()
    def find_product_where_sum(numbers, n, expected_sum) do
      numbers
      |> Advent2020.combinations(n)
      |> Enum.find(&Enum.sum(&1) == expected_sum)
      |> Enum.reduce(&Kernel.*/2)
    end

    @spec part1 :: integer
    def part1 do
      find_product_where_sum(data(), 2, 2020)
    end

    @spec part2 :: integer
    def part2 do
      find_product_where_sum(data(), 3, 2020)
    end
  end

  defmodule Puzzle02 do
    @type line :: %{
      low: integer,
      high: integer,
      letter: binary,
      password: binary
    }

    @doc """
    Produces a stream of parsed lines from the input file
    """
    @spec data :: Stream.t()
    def data do
      "priv/puzzle02.txt"
      |> File.stream!()
      |> Stream.map(&parse_line/1)
    end

    @doc """
    Parse a line from the password policy file into a map

    ## Examples

        iex> Advent2020.Puzzle02.parse_line("3-4 h: hrht")
        %{low: 3, high: 4, letter: "h", password: "hrht"}
    """
    @spec parse_line(binary) :: line
    def parse_line(line) do
      [low, high, letter, password] = Regex.run(~r/(\d+)-(\d+) (\w): (\w+)/, line, capture: :all_but_first)
      %{low: String.to_integer(low), high: String.to_integer(high), letter: letter, password: password}
    end

    @doc """
    Tests if a password policy line is valid (method 1)

    ## Examples

        iex> Advent2020.Puzzle02.valid_password1?(%{low: 3, high: 4, letter: "h", password: "hrht"})
        false

        iex> Advent2020.Puzzle02.valid_password1?(%{low: 2, high: 5, letter: "h", password: "hrht"})
        true
    """
    @spec valid_password1?(line) :: boolean
    def valid_password1?(%{low: l, high: h, letter: x, password: p}) do
      Enum.member?(l .. h,
        p
        |> String.graphemes()
        |> Enum.count(& &1 == x)
      )
    end

    @doc """
    Tests if a password policy line is valid (method 2)

    ## Examples
        iex> Advent2020.Puzzle02.valid_password2?(%{low: 1, high: 3, letter: "a", password: "abcde"})
        true

        iex> Advent2020.Puzzle02.valid_password2?(%{low: 1, high: 3, letter: "b", password: "cdefg"})
        false

        iex> Advent2020.Puzzle02.valid_password2?(%{low: 2, high: 9, letter: "c", password: "ccccccccc"})
        false
    """
    @spec valid_password2?(line) :: boolean
    def valid_password2?(%{low: l, high: h, letter: x, password: p}) do
      graphemes = String.graphemes(p)
      [match1, match2] = Enum.map([l-1, h-1], &Enum.at(graphemes, &1) == x)
      :erlang.xor(match1, match2)
    end

    @spec part1 :: non_neg_integer
    def part1 do
      data()
      |> Enum.count(&valid_password1?/1)
    end

    @spec part2 :: non_neg_integer
    def part2 do
      data()
      |> Enum.count(&valid_password2?/1)
    end
  end
end
