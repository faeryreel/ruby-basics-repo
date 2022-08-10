print "Укажите длину первой стороны треугольника: "
a = gets.chomp.to_f

print "Укажите длину второй стороны треугольника: "
b = gets.chomp.to_f

print "Укажите длину третьей стороны треугольника: "
c = gets.chomp.to_f

# Определяем, является ли треугольник равносторонним или равнобедренным.

if a == b && a == c && b == c
	eq_trngl = true
	isos_trngl = true
elsif a == b || a == c || b == c
	eq_trngl = false
	isos_trngl = true
else
	eq_trngl = false
	isos_trngl = false
end

# Определяем, является ли треугольник прямоугольным.

if eq_trngl == false && isos_trngl == false

	# Определяем самую длинную сторону и вычисляем сумму квадратов двух других сторон.

	if a > b && a > c
		greatest_side = a
		quad_sum = b**2 + c**2
	elsif b > a && b > c
		greatest_side = b
		quad_sum = a**2 + c**2
	else
		greatest_side = c
		quad_sum = a**2 + b**2
	end

	# Используем теорему Пифагора.

	if greatest_side**2 == quad_sum
		right_trngl = true
	else
		right_trngl = false
	end

else
	right_trngl = false
end

if eq_trngl == true
	puts "Треугольник является равносторонним и равнобедренным."
elsif isos_trngl == true
	puts "Треугольник является равнобедренным."
elsif right_trngl == true
	puts "Треугольник является прямоугольным."
else
	puts "Треугольник не является ни равносторонним, ни равнобедренным, ни прямоугольным."
end
