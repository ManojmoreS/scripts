# O(log(n)) - worst/average
# O(1) - best when key is middle element
# iterative implementation of binary search in Ruby
def ibinary_search arr, key
  low = 0
  high = arr.length - 1
  while(high >= low) do
    mid = (low  + high)/ 2
    if arr[mid] > key
      high = mid - 1
    elsif arr[mid] < key
      low = mid + 1
    elsif arr[mid] == key
      return true
      # p "Found #{arr[mid]} @ #{mid} of #{arr}" and return true
    end
  end
  return false
  # p "Oops, Sorry could not find #{key} in #{arr}" and return false
end
# p 'iterative implementation of binary search in Ruby'
# p iterative_binary_search([1,2,3,4,5,6,7,8,9], 9)

# recursive implementation of binary search in Ruby
def rbinary_search arr, key
  low = 0
  high = arr.length
  if arr.length == 0
    return false
    # p 'array seems to be empty' and return false
  else
    mid = (low + high) / 2
    if arr[mid] == key
      return true
      # p "#{key} found @ #{mid}" and return true
    elsif arr[mid] > key
      rbinary_search(arr[0..mid-1], key)
    elsif arr[mid] < key
      rbinary_search(arr[mid+1..arr.length - 1], key)
    end
  end
end
# p 'recursive implementation of binary search in Ruby'
# p recursive_binary_search([1,2,3,4,5,6,7,8,9], 1)

# O(nlogn)
def merge_sort(arr)
  # break recursion
  return arr if arr.length <=1
  # split + merge
  mid = (arr.length / 2)
  left, right = merge_sort(arr[0...mid]), merge_sort(arr[mid...arr.length])
  # merge
  rv = []
  while[left,right].none?(&:empty?) do
    rv << (left[0] < right[0] ? left.shift : right.shift)
  end
  # one of left or right will be less
  rv.concat(left).concat(right)
end

# p 'merge sort'
# p merge_sort([4,3,2,1])

# Quick sort
# O(nlogn) - best / average
# O(n2) - worsts
def quick_sort(arr)
  return arr if arr.empty?
  index = rand(arr.length)
  pivot = arr.delete_at(index)
  left,right = arr.partition { |ele| ele < pivot }
  arr.insert(index, pivot)
  return [*quick_sort(left), pivot, *quick_sort(right)]
end

require 'benchmark'
p "Enter the operation you want to perform"
p "1 - searching, 2 - sorting"
operation = gets.chomp.to_i
case operation
when 1
  p "Enter the key to search"
  key = gets.chomp.to_i
  p "Enter the array size to auto generate"
  arr_size = gets.chomp.to_i
  test_array = (1..arr_size).to_a.sort
  Benchmark.bm do |benchmark|
    benchmark.report("ruby_array include       :"){ p test_array.include?(key) }
    benchmark.report("iterative_binary_search  :"){ p ibinary_search(test_array, key) }
    benchmark.report("recursive_binary_search  :"){ p rbinary_search(test_array, key) }
  end
when 2
  p "Enter the array size to auto generate"
  arr_size = gets.chomp.to_i
  test_array = (1..arr_size).to_a.shuffle
  Benchmark.bm do |benchmark|
    p "Merge Sort"
    benchmark.report("merge_sort :"){ p merge_sort(test_array) }
    p "Quick Sort"
    benchmark.report("quick sort :"){ p quick_sort(test_array) }
    p "Ruby Sort"
    benchmark.report("ruby_sort :"){ p test_array.sort }
  end
else
  p "Option #{operation} is undefined"
  exit
end
