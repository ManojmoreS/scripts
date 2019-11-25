require 'benchmark'

def missing_element_array
  p "Find missing number from array"
  p "Enter the array size"
  arr_size = gets.chomp.to_i
  # p "Auto generate the array"
  p "Enter array element"
  test_array = gets.chomp.split(' ').map(&:to_i)
  p "How many elements do you want to delete"
  miss_elements = (1..gets.chomp.to_i).to_a
  test_array = test_array - miss_elements
  # Find missing number from array
  def find_missing arr, size
    o_arr = (1..size).to_a
    p "Missing element are : #{o_arr - arr}"
  end

  find_missing(test_array, arr_size)
end



# Count zeros in a row wise and column wise sorted matrix
def count_zero_in_matrix
  # matrix = [[1,1,1,1,0],[0,0,0,1,1],[1,0,1,0,1],[0,0,0,0,0]]
  # n_m=[4,5]
  # matrix = [[1,1,1,1,0]]
  # n_m=[1,5]
  matrix = []
  p "Enter no of row and column for NxM Matrix"
  n_m= gets.chomp.split(' ').map(&:to_i)
  (0...n_m[0]).each{ |i| temp = []; (0...n_m[1]).each{ |j| temp[j]= rand(2); matrix[i]=temp}}
  p "Matrix"
  p matrix


  def On_zero_count(matrix, rows)
    row = rows-1
    col=0
    count = 0
    while col < matrix[row].count do
      return count if row < 0
      count+=1 if matrix[row][col] == 0
      if col==(matrix[row].count-1)
        col = 0
        row = row-1
      else
        col = col+1
      end
    end
  end

  def On2_zero_count(matrix, rows)
    count = 0
    (0...rows).each do |row|
      (0...matrix[row].count).each do |col|
        count+=1 if matrix[row][col] == 0
      end
    end
    return count
  end

  def ruby_zero_count(matrix)
    matrix.flatten.count{|i| i==0}
  end
  Benchmark.bm do |benchmark|
    benchmark.report("On2_zero_count : "){p On2_zero_count(matrix, n_m[0])}
    benchmark.report("On_zero_count : "){p On_zero_count(matrix, n_m[0])}
    benchmark.report("ruby_zero_count : "){p ruby_zero_count(matrix)}
  end
end
count_zero_in_matrix
