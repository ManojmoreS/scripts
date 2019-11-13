# O(log(n)) - worst/average
# O(1) - best when key is middle element
# iterative implementation of binary search in Ruby
def iterative_binary_search arr, key
  low = 0
  high = arr.length - 1
  while(high >= low) do
    mid = low  + (high - low) / 2
    if arr[mid] > key
      high = mid - 1
    elsif arr[mid] < key
      low = mid + 1
    elsif arr[mid] == key
      return mid
    end
  end
  return -1
end
# p 'iterative implementation of binary search in Ruby'
# p iterative_binary_search([1,2,3,4,5,6,7,8,9], 9)

# recursive implementation of binary search in Ruby
def recursive_binary_search arr, key
  low = 0
  high = arr.length - 1
  if arr.length == 0
    return 'array seems to be empty'
  else
    mid = low + (high-low) / 2
    if arr[mid] > key
      recursive_binary_search(arr[0..mid-1], key)
    elsif arr[mid] < key
      recursive_binary_search(arr[mid..arr.length - 1], key)
    elsif arr[mid] == key
      return "#{key} found @ #{mid}"
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
  left, right = merge_sort(arr[0...mid]), merge_sort(arr[mid..-1])
  # merge
  rv = []
  while[left,right].none?(&:empty?) do
    rv << (left[0] < right[0] ? left.shift : right.shift)
  end

  # one of a/b is empty
  rv.concat(left).concat(right)
end

# p 'merge sort'
# p merge_sort([4,3,2,1])

# Quick sort
# O(nlogn) - best / average
# O(n2) - worsts
def qs(arr)
  return arr if arr.empty?
  index = rand(arr.length)
  pivot = arr.delete_at(index)
  left,right = arr.partition { |ele| ele < pivot }
  arr.insert(index, pivot)
  return [*qs(left), pivot, *qs(right)]
end
 p 'quick sort'
 p qs([9,8,7,6,5,4,3,2,1])
