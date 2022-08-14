purchases = Hash.new
total_sum = 0

loop do
  print "\nУкажите наименование товара: "
  item = gets.chomp
  break if item.downcase == "стоп"
  print "Укажите цену за единицу товара: "
  item_price = gets.chomp.to_i
  print "Укажите количество купленного товара: "
  item_quantity = gets.chomp.to_f
  purchases[item] = {:item_price => item_price, :item_quantity => item_quantity}
end

puts "\nХэш, содержащий сведения о товарах:\n\n"
puts purchases
puts " "

purchases.each_key do |item|
  item_total = purchases[item][:item_price] * purchases[item][:item_quantity]
  puts item + " — итоговая сумма: " + item_total.to_s
  total_sum += item_total
end

puts "\nОбщая сумма покупок: " + total_sum.to_s
