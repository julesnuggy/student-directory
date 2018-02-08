#!usr/bin/env ruby

# Global variable declarations
$students = [] # Array which will contain the data
$let_count = 0 # Keeps track of how many students are output when filters are set
$stu_num = 1 # Number displayed during user input to keep track of inputs

# This allows the user to input values to variables and allowing them to
# exit the program at any time by typing "EXIT"
def gets_break
  print ">>" # This is just to make it clearer when/where they're inputting
  gets_var = gets.chomp
  if gets_var.upcase == "EXIT"
    abort("---- PROGRAM ABORTED ----")
  else
    gets_var
  end
end

# Ask user to input student details to create a "database" (array of hashes)
def student_input
  puts "\nPlease enter the requested student details."
  puts "To stop, provide a blank entry by pressing Enter for all options."
  puts "-------------------------------------------------------------\n"

  stu_name = stu_cohort = stu_hobbies = "" # Decalre variables

  # The loop will stop once the user enters three 'empty values'.
  # Empty values (just pressing Enter) default to "N/A"
  until stu_name == "N/A" && stu_cohort == "N/A" && stu_hobbies == "N/A"

    puts "\nEnter student #{$stu_num}'s name:"
    stu_name = gets_break
    stu_name = "N/A" if stu_name == ""
    break if stu_name == "EXIT"

    puts "Enter #{$stu_num}'s cohort month."
    stu_cohort = gets_break
    stu_cohort = "N/A" if stu_cohort == ""


    puts "Enter #{$stu_num}'s hobbies."
    stu_hobbies = gets_break
    stu_hobbies = "N/A" if stu_hobbies == ""

    # For entries with at least one 'non-empty' input,
    # push a hash of these values into the students array
    unless (stu_name == "N/A" && stu_cohort == "N/A" && stu_hobbies == "N/A")
      $students.push({name:stu_name, cohort:stu_cohort, hobbies:stu_hobbies})
      $stu_num += 1
    end
  end

  # Return the students array where each entry also outputs its index value
  #$students.each_with_index

end

# Method to set filter settings for which names to display
# Affects the methods used in print_directory
def print_directory_options
  puts "\nSelect which (sub)set of students you'd like to see:"
  puts "--ALL -> display all students."
  puts "--LETTER -> display only students whose first name begins with a specific letter"
  puts "--LENGTH -> display only students whose names are less than a set length"
  puts "--COHORT -> display only students of the selected cohort"
  puts "--ALL BY COHORT -> display all students ordered by cohort"

  # Return the user filter setting via the print_options variable
  print_options = gets_break
end

def print_directory(print_options)
  all_by_cohort = {} # Hash for ALL BY COHORT filter

  puts "\n-------------------------------"
  puts "The students of Villain Academy:"


  # No filter - print all names
  case print_options.upcase
  when "ALL"
    # For each entry in the students argument (student array from above),
    # puts the student details, preceded by the index value + 1.
    $students.each { |student, index|
      puts "Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]}"
    }

    # Set &let_count = -1 so that the filter settings messages in print_footer
    # is not displayed
    $let_count = -1

    # Filter setting to print only specific letter names
    when "LETTER"
      puts "Enter the first letter of the names you want to see:"
      letter = gets_break

      # For each entry in the students argument (student array from student_input),
      # puts the student details, preceded by the index value + 1.
      $students.each { |student, index|
        if student[:name][0].upcase == letter.upcase
          puts "Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]}"

          # Increase &let_count by one for each successful output
          $let_count += 1
        end # of if
      }

    # Filter setting to only print specific length names
    when "LENGTH"
      puts "Enter the name length limit (integers only):"
      name_length = gets_break.to_i

      # For each entry in the students argument (student array from student_input),
      # puts the student details, preceded by the index value + 1.
      $students.each { |student, index|
        if student[:name].length <= name_length
          puts "Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]}"

          # Increase &let_count by one for each successful output
          $let_count += 1
        end # of if
      }

    # Filter setting to only print specific cohort
    when "COHORT"
      puts "Enter the cohort to display:"
      cohort = gets_break

      # For each entry in the students argument (student array from student_input),
      # puts the student details, preceded by the index value + 1.
      $students.each { |student, index|
        if student[:cohort] == cohort
          puts "Name: #{student[:name]}; Cohort: #{student[:cohort]}; Hobbies: #{student[:hobbies]}"

          # Increase &let_count by one for each successful output
          $let_count += 1
        end # of if
      }

    # Filter setting to print all students ordered by cohort
    when "ALL BY COHORT"

      # For each entry in the students argument (student array from student_input),
      # check if the entry's :cohort value exists in the all_by_cohort Hash as a key.
      # If it doesn't exist, create an empty array. Then push a string containing
      # the name and hobbies of the student into that key.
      $students.each { |student, index|
        if all_by_cohort[student[:cohort]] == nil
          all_by_cohort[student[:cohort]] = []
        end # of if
        all_by_cohort[student[:cohort]].push("Name: #{student[:name]}; Hobbies: #{student[:hobbies]}")
      }

      # puts the values of each cohort-key values
      all_by_cohort.each { |cohort, values|
        puts "\n COHORT #{cohort}:"
        puts values
      }

      # Set &let_count = -1 so that the filter settings messages in print_footer
      # is not displayed
      $let_count = -1
    else
      puts "Please enter a valid option."

    end # of case

      # puts how many students there are in the directory
      # For relevant filter options, show how many return from the search
      puts $students.count == 1 ? "\nIn total, we have #{$students.count} great student." : "\nIn total, we have #{$students.count} great students."
      if $let_count >= 0
        puts $let_count == 1 ? "Your filter settings display #{$let_count} student." : "Your filter settings display #{$let_count} students."
      end # of if

      puts "---- END ----\n\n"

end # of def

def delete_entry

end

# This makes the directory interactive by allowing the user to decide what
# they want to do with the directory.
def interactive_entry
  puts "Welcome to the Villain Academy Student Directory!"
  puts "Here, you can add, view, delete and amend the directory."
  puts "If you'd like to quit this program, just type 'EXIT' at any point"
  puts "where you can provide an input."

  user_input = ""
  while user_input.upcase != "EXIT"
    puts "\nEnter an action from the following options:"
    puts "--ADD -> Add new entries to the directory"
    puts "--VIEW -> View the directory"
    puts "--REMOVE -> Remove entries from the directory"
    puts "--AMEND -> Amend an existing entry in the directory"
    puts "--EXIT -> Exit the program"

    user_input = gets_break

    case user_input.upcase
      when "ADD"
        student_input

      when "VIEW"
        print_options = print_directory_options
        print_directory(print_options)

      when "REMOVE"

      when "AMEND"

      else
        puts "Please enter a valid option."
      # EXIT case handled by gets_break already
    end # of case
  end # of while
end # of def

# This allows the user to input values to variables and allowing them to
# exit the program at any time by typing "EXIT"

interactive_entry
