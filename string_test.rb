# eg: LISTEN & SILENT / TRIANGLE & INTEGRAL
def check_anagram(str1, str2)
  str1.downcase!
  str2.downcase!
  return true if (get_freq(str1) == get_freq(str2)) and !(str1.eql? str2)
end

# eg: Print string frequency
def get_freq(str)
  freq = Hash.new(0)
  str.each_char do |chr|
    # char frequency
    freq[chr] += 1
    # vowels frequency
    # freq[chr] += 1 if ['a', 'e', 'i', 'o', 'u'].include?(chr)
  end
  freq
end
