def salute(name, greeting)
    nameArray = name.split
    puts "#{greeting.capitalize} Mr.#{nameArray.last}"
end

puts salute("Nelson Rolihlahla Mandela", "hello")
puts salute("Sir Alan Turing", "welcome")