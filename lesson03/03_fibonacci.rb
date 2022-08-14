fibonacci_seq = []
fibonacci_seq[0] = 0
fibonacci_seq[1] = 1
n = 2

loop do
  if fibonacci_seq[n-2] + fibonacci_seq[n-1] > 100
    break
  else
    fibonacci_seq[n] = fibonacci_seq[n-2] + fibonacci_seq[n-1]
    n += 1
  end
end

print fibonacci_seq
