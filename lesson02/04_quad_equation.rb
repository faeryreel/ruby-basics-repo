print "Введите коэффициент a: "
a = gets.chomp.to_f

print "Введите коэффициент b: "
b = gets.chomp.to_f

print "Введите коэффициент c: "
c = gets.chomp.to_f

d = b**2 - (4 * a * c)

if d < 0
	puts "Дискриминант равен #{d} < 0, а значит, корней нет."
elsif d == 0
	puts "Дискриминант равен #{d}. x = #{-b / (2 * a)}."
else
	puts "Дискриминант равен #{d}. x1 = #{(-b + Math.sqrt(d)) / (2 * a)}, x2 = #{(-b - Math.sqrt(d)) / (2 * a)}."
end
