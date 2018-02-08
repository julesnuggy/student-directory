# Ask user to input student details to create a "database" (array of hashes)
def student_input
  puts "\nPlease enter the requested student details."
  puts "To stop, provide a blank entry by pressing Enter for all options."
  puts "-------------------------------------------------------------\n\n"

  students = [] # Array which will contain the data
  stu_num = 1 # Number displayed during user input to keep track of inputs

  stu_name = stu_cohort = stu_hobbies = "" # Decalre variables

  # The loop will stop once the user enters three 'empty values'.
  # Empty values (just pressing Enter) default to "N/A"
  until stu_name == "N/A" && stu_cohort == "N/A" && stu_hobbies == "N/A"

    puts "\nEnter student #{stu_num}'s name:"
    print ">>"
    stu_name = gets.chomp
    stu_name = "N/A" if stu_name == ""

    puts "Enter #{stu_num}'s cohort month."
    print ">>"
    stu_cohort = gets.chomp
    stu_cohort = "N/A" if stu_cohort == ""

    puts "Enter #{stu_num}'s hobbies."
    print ">>"
    stu_hobbies = gets.chomp
    stu_hobbies = "N/A" if stu_hobbies == ""

    # For entries with at least one 'non-empty' input,
    # push a hash of these values into the students array
    students.push({name:stu_name, cohort:stu_cohort, hobbies:stu_hobbies}) unless (stu_name == "N/A" && stu_cohort == "N/A" && stu_hobbies == "N/A")
    stu_num += 1
  end

  # Return the students array where each entry also outputs its index value
  students.each_with_index

end

# Method to set filter settings for which names to display
# Affects the methods used in print_students
def print_header
  puts "\nTo display the students in the database, select a filter setting "
  puts "to apply:"
  puts "'NONE' or just press Enter -> display all students."
  puts "'LETTER' -> display only students whose first name begins with a specific letter"
  puts "'LENGTH' -> display only students whose names are less than a set length"
  puts "'COHORT' -> display only students of the selected cohort"
  puts "'ALL BY COHORT' -> display all students ordered by cohort"
  print ">>"

  # Return the user filter setting via the print_options variable
  print_options = gets.chomp
end

def print_students(students, print_options)
  $let_count = 0 # Keeps track of how many students are output when filters are set
  all_by_cohort = {} # Hash for ALL BY COHORT filter

  puts "\nThe students of Villain Academy"
  puts "-------------------------------\n"

  # No filter - print all names
  if print_options.upcase == "NONE" || print_options == ""
    # For each entry in the students argument (student array from above),
    # puts the student details, preceded by the index value + 1.
    students.each { |student, index|
      puts "#{index+1}. Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]}"
    }

  # Set &let_count = -1 so that the filter settings messages in print_footer
  # is not displayed
  $let_count = -1

  # Filter setting to print only specific letter names
  elsif print_options.upcase == "LETTER"
    puts "Enter the first letter of the names you want to see:"
    print ">>"
    letter = gets.chomp

    # For each entry in the students argument (student array from student_input),
    # puts the student details, preceded by the index value + 1.
    students.each { |student, index|
      if student[:name][0].upcase == letter.upcase
        puts "#{index+1}. Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]}"

        # Increase &let_count by one for each successful output
        $let_count += 1
      end
    }

  # Filter setting to only print specific length names
  elsif print_options.upcase == "LENGTH"
    puts "Enter the name length limit (integers only):"
    print ">>"
    name_length = gets.chomp.to_i

    # For each entry in the students argument (student array from student_input),
    # puts the student details, preceded by the index value + 1.
    students.each { |student, index|
      if student[:name].length <= name_length
        puts "#{index+1}. Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]}"

        # Increase &let_count by one for each successful output
        $let_count += 1
      end
    }

  # Filter setting to only print specific cohort
  elsif print_options.upcase == "COHORT"
    puts "Enter the cohort to display:"
    print ">>"
    cohort = gets.chomp

    # For each entry in the students argument (student array from student_input),
    # puts the student details, preceded by the index value + 1.
    students.each { |student, index|
      if student[:cohort] == cohort
        puts "#{index+1}. Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]}"

        # Increase &let_count by one for each successful output
        $let_count += 1
      end
    }

  # Filter setting to print all students ordered by cohort
  elsif print_options.upcase == "ALL BY COHORT"

    # For each entry in the students argument (student array from student_input),
    # check if the entry's :cohort value exists in the all_by_cohort Hash as a key.
    # If it doesn't exist, create an empty array. Then push a string containing
    # the name and hobbies of the student into that key.
    students.each { |student, index|
      if all_by_cohort[student[:cohort]] == nil
        all_by_cohort[student[:cohort]] = []
      end
      all_by_cohort[student[:cohort]].push("#{index+1}. Name: #{student[:name]}; Hobbies: #{student[:hobbies]}")
    }

    # puts the values of each cohort-key values
    all_by_cohort.each { |cohort, values|
      puts "\n COHORT #{cohort}:"
      puts values
    }

    # Set &let_count = -1 so that the filter settings messages in print_footer
    # is not displayed
    $let_count = -1

  end # of if...else... loop
end # of def

# print/puts how many students we have
def print_footer(students)
  puts students.count == 1 ? "\nIn total, we have #{students.count} great student." : "\nIn total, we have #{students.count} great students."
  if $let_count >= 0
    puts $let_count == 1 ? "Your filter settings display #{$let_count} student." : "Your filter settings display #{$let_count} students."
  end
  puts "---- END ----\n\n"
end

students = student_input
print_options = print_header
print_students(students, print_options)
print_footer(students)
