defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(0), do: raise(ArgumentError, "n must be greater than 0")
  def nth(count), do: find_nth_prime(count, 2, 0)

  defp find_nth_prime(n, current, count) do
    if is_prime?(current) do
      if count + 1 == n do
        current
      else
        find_nth_prime(n, current + 1, count + 1)
      end
    else
      find_nth_prime(n, current + 1, count)
    end
  end

  defp is_prime?(2), do: true
  defp is_prime?(n) when n < 2 or rem(n, 2) == 0, do: false
  defp is_prime?(n) do
    limit = :math.sqrt(n) |> trunc()
    Enum.all?(3..limit//2, fn x -> rem(n, x) != 0 end)
  end
end
