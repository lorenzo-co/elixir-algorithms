defmodule Sort do
  def quicksort([]), do: []
  def quicksort(list) do
    list
    |> List.pop_at(index_of_median(list))
    |> _quicksort()
  end

  defp _quicksort({nil, _}), do: []
  defp _quicksort({pivot, []}), do: [pivot]
  defp _quicksort({pivot, sublist}) do
    smaller_elements = for x <- sublist, x < pivot, do: x
    larger_elements = for x <- sublist, x >= pivot, do: x
      _quicksort(List.pop_at(smaller_elements, index_of_median(smaller_elements)))
      ++ [pivot] ++
      _quicksort(List.pop_at(larger_elements, index_of_median(larger_elements)))
  end

  defp index_of_median(list) when length(list) < 3, do: 0
  defp index_of_median(list = [_|_]) do
    median =
      list
      |> Enum.take_random(3)
      |> case do
        [a, b, c] when (a >= b and a <= c) or (a <= b and a >= c) -> a
        [a, b, c] when (b >= a and b <= c) or (b <= a and b >= c) -> b
        [_, _, c] -> c
      end
    Enum.find_index(list, fn(x) -> x == median end)
  end

  def quicksort_dp([]), do: []
  def quicksort_dp([h]), do: [h]
  def quicksort_dp([h,t]) do
    cond do
      h < t -> [h,t]
      true -> [t,h]
    end
  end
  def quicksort_dp(list) do
    {first_pivot, temp_sublist} = List.pop_at(list,
     random_position_in(list))
    {second_pivot, target_sublist} = List.pop_at(temp_sublist,
     random_position_in(temp_sublist))

    smaller_pivot = Enum.min([first_pivot, second_pivot])
    larger_pivot = Enum.max([first_pivot, second_pivot])

    quicksort_dp(for x <- target_sublist, x < smaller_pivot, do: x)
    ++ [smaller_pivot] ++
    quicksort_dp(for x <- target_sublist, x >= smaller_pivot, x < larger_pivot, do: x)
    ++ [larger_pivot] ++
    quicksort_dp(for x <- target_sublist, x >= larger_pivot, do: x)
  end
  
  defp random_position_in(list) when length(list) > 1, do: :rand.uniform(length(list)) - 1
  defp random_position_in(_), do: 0
end