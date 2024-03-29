require "date"

class Todo
  def initialize(text, due_date, completed)
    @text = text
    @due_date = due_date
    @completed = completed
  end

  def overdue?
    return @due_date < Date.today
  end

  def due_today?
    return @due_date == Date.today
  end

  def due_later?
    return @due_date > Date.today
  end

  def to_displayable_string
    date_to_display = if due_today?
        ""
      else
        @due_date
      end
    check_mark = if @completed
        "[X]"
      else
        "[ ]"
      end
    return "#{check_mark} #{@text} #{date_to_display}"
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  def to_displayable_list
    display_list = @todos.map do |todo|
      todo.to_displayable_string
    end
    return display_list.join("\n")
  end

  def add(todo)
    @todos.push(todo)
  end
end

# ####################################### #
# DO NOT CHANGE ANYTHING BELOW THIS LINE. #
# ####################################### #

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
