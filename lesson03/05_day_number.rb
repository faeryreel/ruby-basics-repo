print "Введите число: "
day = gets.chomp.to_i

print "Введите месяц: "
month = gets.chomp.to_i

print "Введите год: "
year = gets.chomp.to_i

num_of_days = {
  1 => 31,
  2 => 28,
  3 => 31,
  4 => 30,
  5 => 31,
  6 => 30,
  7 => 31,
  8 => 31,
  9 => 30,
  10 => 31,
  11 => 30,
  12 => 31,
}

=begin
Проверяем, является ли год високосным.
Если да, делаем в хэше num_of_days кол-во дней в феврале равным 29.
=end

if (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
  num_of_days[2] = 29
end

month_number = 1
day_number = 0

while month_number < month do 
  day_number += num_of_days[month_number]
  month_number += 1
end

day_number += day

puts "Порядковый номер дня: " + day_number.to_s
