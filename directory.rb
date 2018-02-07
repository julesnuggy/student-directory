def student_input
  puts "\nPlease enter the requested student details."
  puts "To stop, provide a blank entry by pressing Enter for all options."
  puts "-------------------------------------------------------------\n\n"

  students = []
  stu_num = 1
  stu_name = stu_cohort = stu_hobbies = "BLANK"

  until stu_name == "" && stu_cohort == "" && stu_hobbies == ""
    puts "Enter student #{stu_num}'s name:"
    stu_name = gets.chomp
    puts "Enter #{stu_num}'s cohort month."
    stu_cohort = gets.chomp
    puts "Enter #{stu_num}'s hobbies."
    stu_hobbies = gets.chomp
    students.push({name: stu_name, cohort: stu_cohort, hobbies: stu_hobbies}) unless (stu_name == "" && stu_cohort == "" && stu_hobbies == "")
    stu_num += 1
  end
  students.each_with_index
end

# puts a list of all the students
def print_header
  puts "Would you like to print all students or just those of a specific letter"
  puts "or would you like to print only students with names of a particular"
  puts "character length? Enter 'NONE', LETTER' or 'LENGTH'."
  print_options = gets.chomp
end

def print_students(students, print_options)
  $let_count = 0

  puts "\nThe students of Villain Academy"
  puts "-------------------------------\n"

  # PRINT ALL NAMES
  if print_options.upcase == "NONE"
    students.each { |student, index|
      puts "#{index+1}. Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]})"
    }

  # PRINT ONLY SPECIFIC LETTER NAMES
  elsif print_options.upcase == "LETTER"
    puts "Enter the first letter of the names you want to see:"
    letter = gets.chomp

    students.each { |student, index|
      if student[:name][0].upcase == letter.upcase
        puts "#{index+1}. Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]})"
        $let_count += 1
      end
    }

  # PRINT ONLY SPECIFIC LENGTH NAMES
  elsif print_options.upcase == "LENGTH"
    puts "Enter the name length limit (integers only):"
    name_length = gets.chomp.to_i

    students.each { |student, index|
      if student[:name].length <= name_length
        puts "#{index+1}. Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]})"
        $let_count += 1
      end
    }

  end
end

# print/puts how many students we have
def print_footer(students)
  puts "In total, we have #{students.count} great students."
  puts "You have chosen to display #{$let_count} students." if $let_count > 0
end

students = student_input
print_options = print_header
print_students(students, print_options)
print_footer(students)
