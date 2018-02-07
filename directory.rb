def student_input
  puts "This program will ask you to enter student names and"
  puts "cohort months until you type in 'stop'"
  puts "------------------------------------\n\n"

  students = []
  stu_name = ""
  stu_cohort = ""

  until stu_name.downcase == "stop" || stu_cohort.downcase == "stop"
    puts "Enter a name to add to the cohort."
    stu_name = gets.chomp
    puts "Enter a cohort month."
    stu_cohort = gets.chomp
    students.push({name: stu_name, cohort: stu_cohort}) if (stu_name.downcase != "stop" && stu_cohort.downcase != "stop")
  end
  students
end

# puts a list of all the students
def print_header
  puts "\nThe students of Villain Academy"
  puts "-------------------------------\n"
end

def print(students)
  students.each { |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  }
end

# print/puts how many students we have
def print_footer(students)
  puts "Overall we have #{students.count} great students."
end

students = student_input
print_header
print(students)
print_footer(students)
