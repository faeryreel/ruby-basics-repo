puts "Как вас зовут?"
user_name = gets.chomp

puts "Какой у вас рост?"
user_height = gets.chomp.to_f

ideal_weight = (user_height - 110) * 1.15

if ideal_weight < 0
	puts "Ваш вес уже оптимальный."
else
	puts "#{user_name}, ваш идеальный вес — #{ideal_weight} кг."
end
