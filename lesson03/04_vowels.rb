alphabet = ("a".."z").to_a
vowels = Hash.new
n = 1

alphabet.each do |letter|
  if "aeiou".include?(letter)
    vowels[letter] = n
    n += 1
  else
    n += 1
  end
end

puts vowels
