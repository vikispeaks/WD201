todos = [
  ["Send invoice", "money"],
  ["Clean room", "organize"],
  ["Pay rent", "money"],
  ["Arrange books", "organize"],
  ["Pay taxes", "money"],
  ["Buy groceries", "food"]
]

def singleArrayToHash(array)
  hash = {}
  array.each do |item|
    temp = item[1].downcase.to_sym
    if hash.has_key? temp
        hash[temp] << item[0]
    else
        hash[temp] = []
        hash[temp] << item[0]
    end
  end
  puts hash
end

singleArrayToHash(todos)
