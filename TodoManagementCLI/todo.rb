require "active_record"

class Todo < ActiveRecord::Base
  
  def overdue?
    due_date < Date.today
  end

  def due_today?
    due_date == Date.today
  end

  def due_later?
    due_date > Date.today
  end

  def to_displayable_string
    display_status = completed ? "[x]" : "[ ]"
    display_date = due_today? ? nil : due_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  end

  def self.add_task(h)
    Todo.create!(todo_text: h[:todo_text], due_date: Date.today + h[:due_in_days], completed: false)
  end

  def self.mark_as_complete(id)
    Todo.update(id, completed: true)
  end

  def self.overdue
    where("due_date < ?", Date.today)
  end

  def self.due_today
    where("due_date = ?", Date.today)
  end

  def self.due_later
    where("due_date > ?", Date.today)
  end

  def self.show_list
    puts "My Todo-list\n\n"

    puts "Overdue"
    puts overdue.map { |todo| todo.to_displayable_string }.join("\n")
    puts "\n\n"

    puts "Due Today"
    puts due_today.map { |todo| todo.to_displayable_string }.join("\n")
    puts "\n\n"

    puts "Due Later"
    puts due_later.map { |todo| todo.to_displayable_string }.join("\n")
    puts "\n\n"
  end
end
