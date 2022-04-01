books = ["Design as Art", "Anathem", "Shogun"]
authors = ["Bruno Munari", "Neal Stephenson", "James Clavell"]

def arrays_to_hash(array1, array2)
  hash = {}
  array1.each_with_index do |item, index|
    temp = item.downcase.to_sym
    hash[temp] = array2[index]
  end
  puts "#{hash}"
end

arrays_to_hash(books, authors)