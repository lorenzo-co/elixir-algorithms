defmodule SortTest do
  use ExUnit.Case

  test "quicksort" do
    assert Sort.quicksort([9,5,6,7,8,1,2,3,4]) == [1,2,3,4,5,6,7,8,9]
  end

  test "quicksort with dual pivot" do
    assert Sort.quicksort_dp([9,5,6,7,8,1,2,3,4]) == [1,2,3,4,5,6,7,8,9]
  end
end
