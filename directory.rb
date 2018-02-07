students = ["Dr. Hannibal Lecter",
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex Delarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"]

# puts a list of all the students
def print_header
  puts "The students of Villain Academy"
  puts "-------------------------------"
end

def print(stu_names)
  stu_names.each { |name| puts name }
end

# print/puts how many students we have
def print_footer(names)
  puts "Overall we have #{names.count} great students."
end

print_header
print(students)
print_footer(students)
