=begin
These notes are taken from the Ruby tutorial in Codecademy.
The projects cover pretty much everything but probably not everything.
So, be careful when a recap is needed!
=end

### 1st Lesson: Introduction
# First Project: Putting the form in Formatter
print "What's your first name? "
first_name = gets.chomp
first_name.capitalize!

print "...and your last name? "
last_name = gets.chomp
last_name.capitalize!

print "Your city? "
city = gets.chomp
city.downcase!  # It's here for example.

print "State? "
state = gets.chomp
state.upcase!

print "#{first_name} #{last_name} is from #{city.capitalize!}, #{state}."


### 2nd Lesson: Control Flow
test_1 = (true || false) || (false && true)  # should be true
test_2 = (true && (3 < 4)) && (false || (0 == 0))  # should be true
test_3 = (false || false) || !(true || false)  # should be false

is_liar = false
print "Truth has been spoken!" unless is_liar
# Outputs: "Truth has been spoken!"

# Second Project: Duffy Duckifier
puts 3.times {puts "Welcome!"}

print "Provide an input: "

user_input = gets.chomp
user_input.downcase!

if user_input.include? "s"
  user_input.gsub!(/s/, "th")
  puts user_input
elsif user_input.length == 0
  puts "Please enter a string."
else
  puts "There is no 's' character(s) in the input string."
end


### 3nd Lesson: Looping
counter = 1
until counter > 10
  puts counter
  counter += 1
end

for num in 1...21
    puts num
  end

i = 20
loop {  # loop do ... end
  i -= 1
  next if i % 2 == 1
  print "#{i}"
  break if i <= 0
}

# Third Project: Redacted!
puts "Sentence: "
text = gets.chomp.downcase
puts "Redacted word: "
redact = gets.chomp.downcase
words = text.split(" ")

words.each do |w|
  if w == redact
    print "REDACTED "
  else
    print w + " "
  end
end


### 4th Lesson: Arrays & Hashes
friends = ["Milhouse", "Ralph", "Nelson", "Otto"]
family = {
    "Homer" => "dad",
    "Marge" => "mom",
    "Lisa" => "sister",
    "Maggie" => "sister"
}
friends.each { |x| puts "Friend #{x}" }
family.each { |x, y| puts "#{x}: #{y}" }

s = [  # 2D array
    ["ham", "swiss"],
    ["turkey", "cheddar"],
    ["roast beef", "gruyere"]
]
s.each do |sub_array|
  sub_array.each { |item|
    print item, " "
  }
end

sounds = Hash.new
sounds["dog"] = "woof"
sounds["cat"] = "meow"

secret_identities = {
  "The Batman" => "Bruce Wayne",
  "Superman" => "Clark Kent",
  "Wonder Woman" => "Diana Prince",
  "Freakazoid" => "Dexter Douglas"
}
secret_identities.each do |hero_alias, real_id|
  puts "#{hero_alias}: #{real_id}"
end

# Fourth Project: Create a Histogram
puts "Text: "
text = gets.chomp
words = text.split(" ")
frequencies = Hash.new(0)
# Py: freq = dict().fromkeys(words, 0)

words.each { |w|
  frequencies[w] += 1
}

frequencies = frequencies.sort_by { |w, c| c}
frequencies.reverse!
# Py: freq = dict(sorted(freq.items(), key=lambda x: x[1], reverse=True))

frequencies.each do |w, c|
  puts w + " " + c.to_s  # or String(c)
end


### 5th Lesson: Blocks & Sorting
def array_of_10
  puts (1..10).to_a  # To array
end
array_of_10

def what_up(greeting, *friends)  # "splat arguments"
  friends.each { |friend| puts "#{greeting}, #{friend}!" }
end
what_up("What up", "Ian", "Zoe", "Zenas", "Eleanor")

book_1 = "A Wrinkle in Time"
book_2 = "A Brief History of Time"
print book_1 <=> book_2  # Output: 1. 
# This is called "Combined Comparison Operator". Outputs -1, 0, or 1.

books = [
  "Charlie and the Chocolate Factory",
  "War and Peace",
  "Utopia",
  "A Brief History of Time",
  "A Wrinkle in Time"
]
# To sort our books in ascending order, in-place
puts "Ascending order:"
books.sort! { |firstBook, secondBook| firstBook <=> secondBook }  # Loop block is unnecessary.
puts books
# Sort your books in descending order, in-place below
puts "\nDescending order:"
books.sort! do |firstBook, secondBook| secondBook <=> firstBook end
print books

# Fifth Project: Ordering Your Library
def sorter(arr, rev=false)
  unless rev
    return arr.sort!
  else
    return arr.sort.reverse!
  end
end

numbers = [3,7,2,5]
puts sorter(numbers, true)


### 6th Lesson: Hashes & Symbols
puts "string".object_id  # 16346560
puts "string".object_id  # 16346360
puts "string".class      # String
puts :symbol.object_id   # 802268
puts :symbol.object_id   # 802268
puts :symbol.class       # Symbol
# Why symbols?
# They’re immutable, meaning they can’t be changed once they’re created,
# Only one copy of any symbol exists at a given time, so they save memory,
# Symbol-as-keys are faster than strings-as-keys because of the above two reasons.

:some_symbol.to_s  # ==> "some_symbol"
"some_string".to_sym  # ==> :some_string
"some_string".intern  # ==> :some_string

strings = ["HTML", "CSS", "JavaScript", "Python", "Ruby"]
symbols = []
strings.each do |s|
  symbols.push(s.to_sym)
end
puts symbols  # [:HTML, :CSS, :JavaScript, :Python, :Ruby]

movies = {
  the_matrix: "Made in 1999"  # the key is still a symbol
}
puts movies  # {:the_matrix=>"Made in 1999"}

# Performance of String and Symbol
require 'benchmark'
string_AZ = Hash[("a".."z").to_a.zip((1..26).to_a)]
symbol_AZ = Hash[(:a..:z).to_a.zip((1..26).to_a)]
string_time = Benchmark.realtime do
  10_000_000.times { string_AZ["r"] }
end
symbol_time = Benchmark.realtime do
  10_000_000.times { symbol_AZ[:r] }
end
puts "String time: #{string_time} seconds."  # String time: 7.074 seconds.
puts "Symbol time: #{symbol_time} seconds."  # Symbol time: 4.989 seconds.

movie_ratings = {
  memento: 3,
  the_matrix: 5,
  truman_show: 4,
}
good_movies = movie_ratings.select { |k, v| v > 3}
puts good_movies  # {:the_matrix=>5, :truman_show=>4}

good_movies.each_key do |k| puts k end
good_movies.each_value do |v| puts v end

# Sixth Project: A Night At The Movies
movies = {fight_club: 5}
puts "What would you like to do?"
puts "-- Type 'add' to add a movie."
puts "-- Type 'update' to update a movie."
puts "-- Type 'display' to display all movies."
puts "-- Type 'delete' to delete a movie."

choice = gets.chomp
case choice
  when "add"
    puts "Movie name:"
    title = gets.chomp.to_sym
    if movies[title].nil?
      puts "Rating value:"
      rating = gets.chomp.to_i
      movies[title] = rating
      puts "The movie '#{title}' is added."
    else
      puts "The movie has already added to the database."
    end
  when "update"
    puts "Please provide the movie name to be updated:"
    title = gets.chomp.to_sym
    if movies[title].nil?
      puts "The movie is not in the database. Please add it first."
    else
      puts "New rating value:"
      updated_rating = gets.chomp.to_i
      movies[title] = updated_rating
      puts "The rating of the movie has been updated."
      puts movies
    end
  when "display"
    movies.each { |m, r| puts "#{m}: #{r}"}
  when "delete"
    puts "Which movie you would like to delete:"
    title = gets.chomp.to_sym
    if movies[title].nil?
      puts "No such movie exist in the database. Try again."
    else
      movies.delete(title)
      puts "The movie has been deleted from the database."
    end
  else
    puts "Error!"
end


### 7th Lesson: Refactoring
puts 3 < 4 ? "The condition is true." : "The condition is false."

puts "Hello there!"
greeting = gets.chomp
case greeting
  when "English" then puts "Hello!"
  when "French" then puts "Bonjour!"
  when "German" then puts "Guten Tag!"
  when "Finnish" then puts "Haloo!"
  else puts "I don't know that language!"
end
# Conditional Assignment:
favorite_book = nil
puts favorite_book
favorite_book ||= "Cat's Cradle"
puts favorite_book
favorite_book ||= "Why's (Poignant) Guide to Ruby"
puts favorite_book
favorite_book = "Why's (Poignant) Guide to Ruby"
puts favorite_book
# Outputs:
#  (nothing)
# Cat's Cradle
# Cat's Cradle
# Why's (Poignant) Guide to Ruby

# Implicit Return
def multiple_of_three(n)
  n % 3 == 0 ? "Yep!" : "Nope!"  # "return" is deleted!
end
puts multiple_of_three(5)  # Ruby’s methods will return the result of the last evaluated expression.

# Short-circuit evaluation
def a
  puts "A was evaluated!"
  return true
end
def b
  puts "B was also evaluated!"
  return true
end
puts a || b
puts "------"
puts a && b
# Outputs: (This also holds for 'false && ...')
# A was evaluated!
# true
# ------
# A was evaluated!
# B was also evaluated!
# true

"L".upto("P") {|l| print l + " "}  # L M N O P
print "\n"
10.downto(3) {|n| print n, " "}  # 10 9 8 7 6 5 4 3 

[1, 2, 3].respond_to?(:push)  # true
[1, 2, 3].respond_to?(:to_sym)  # false
age = 26
puts age.respond_to?(:next)  # true
puts age.next  # 27

# concatenation operator
alphabet = ["a", "b", "c"]
alphabet << "d"  # alphabet.push("d")

caption = "A giraffe surrounded by "
caption << "weezards!"  # caption += "weezards!"

# Seventh Project: The Refactor Factory
require 'prime'
def first_n_primes(n)  # "return"s and condition blocks are simplified
    "n must be an integer." unless n.is_a? Integer
    "n must be greater than 0." if n <= 0
    Prime.first n
end
puts first_n_primes(10)


### 8th Lesson: Blocks, Procs, And Lambdas
fibs = [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]
doubled_fibs = fibs.collect {|i| i*2}  # .collect! for inplace
puts doubled_fibs  # [2, 2, 4, 6, 10, 16, 26, 42, 68, 110]
# yield:
def yield_name(name)
  puts "In the method! Let's yield."
  yield#("Jack")
  puts "In between the yields!"
  yield(name)
  puts "Block complete! Back in the method."
end
yield_name("Mert") do |n| puts "I am #{n}." end
# Outputs:
# In the method! Let's yield.
# I am .
# In between the yields!
# I am Mert.
# Block complete! Back in the method.

# Procs
floats = [1.2, 3.45, 0.91, 7.727, 11.42, 482.911]
round_down = Proc.new {|f| f.floor}
round_up = Proc.new do |f| f.ceil end
over_7 = Proc.new {|n| n >= 7}
ints = floats.collect(&round_down)
print ints, "\n"  # [1, 3, 0, 7, 11, 482]
print floats.map!(&round_up)    # [2, 4, 1, 8, 12, 483]
print floats.select(&over_7)  # [8, 12, 483]  # Note that the array is rounded up on the previous line.
# Note: The & is used to convert the cube proc into a block (since .collect!
# and .map! normally take a block). PS: collect & map are the same.
hi = Proc.new {puts "Hello!"}
hi.call
# You can also convert symbols to procs using '&'
numbers_array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
strings_array = numbers_array.map(&:to_s)
# lambda
def lambda_demo(a_lambda)
  puts "I'm the method!"
  a_lambda.call
end
lambda_demo(lambda { puts "I'm the lambda!" })
# I'm the method!
# I'm the lambda!
# Lambda vs Proc: A lambda is just like a proc, only it cares about the number
# of arguments it gets and it returns to its calling method rather than returning immediately.
def batman_ironman_proc
  victor = Proc.new { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end
puts batman_ironman_proc
def batman_ironman_lambda
  victor = lambda { return "Batman will win!" }
  victor.call
  "Iron Man will win!"
end
puts batman_ironman_lambda
# Batman will win!
# Iron Man will win!


### 9th Lesson: OOP 1
class Computer
  $manufacturer = "Mango Computer, Inc."
  @@files = {hello: "Hello, world!"}
  def initialize(username, password)
    @username = username
    @password = password
  end
  def current_user
    @username
  end
  def self.display_files
    @@files
  end
end
# Make a new Computer instance:
hal = Computer.new("Dave", 12345)
puts "Current user: #{hal.current_user}"  # Current user: Dave
# @username belongs to the hal instance.
puts "Manufacturer: #{$manufacturer}"  # Manufacturer: Mango Computer, Inc.
# $manufacturer is global! We can get it directly.
puts "Files: #{Computer.display_files}"  # Files: {:hello=>"Hello, world!"}
# @@files belongs to the Computer class.

# Inheritance syntax
class BaseClass; end
class DerivedClass < BaseClass; end
# super
class Message
  @@messages_sent = 0
  def initialize(from, to)
    @from = from
    @to = to
    @@messages_sent += 1
  end
end
my_message = Message.new("f", "t")
class Email < Message
  def initialize(from, to)
    super
  end
end

# Nineth Project: Virtual Computer
class Machine
  @@users = {}
  def initialize(username, password)
    @username = username
    @password = password
    @@users[username] = password
    @files = {}
  end
  def create(filename)
    time = Time.now
    @files[filename] = time
    puts "#{filename} was created by #{@username} at #{time}."
  end
  def Machine.get_users
    @@users
  end
end
my_machine = Machine.new("eric", 01234)
your_machine = Machine.new("you", 56789)
my_machine.create("groceries.txt")
your_machine.create("todo.txt")
puts "Users: #{Machine.get_users}"
# groceries.txt was created by eric at 2022-02-23 13:46:19 +0000.
# todo.txt was created by you at 2022-02-23 13:46:19 +0000.
# Users: {"eric"=>668, "you"=>56789}


### 10th Lesson: OOP 2
class Asd
  public  # or private
  def name
    @name
  end
  def job=(new_job)  # convention. "hey, this method sets a value!"
    @job = new_job
  end
end
# attr_ for get/set
class Person
  attr_reader :name
  attr_accessor :job  # reader + writer = accessor
  # attr_writer :job
  def initialize(name, job)
    @name = name
    @job = job
  end
end
# Module: You can think of a module as a toolbox that contains a set methods and constants.
# You can think of modules as being very much like classes,
# only modules can’t create instances and can’t have subclasses.
# They’re just used to store things!
module Circle
  PI = 3.141592653589793  
  def Circle.area(radius)
    PI * radius**2
  end  
end
# '::' scope resolution operator
puts Math::PI

require "date"
puts Date.today
# "include" for Modules
class Angle
  include Math  # we want to use Math::cos but we don’t want to type Math::
  attr_accessor :radians
  def initialize(radians)
    @radians = radians
  end
  def cosine
    cos(@radians)
  end
end
acute = Angle.new(1)
puts acute.cosine  # 0.5403023058681398
# "extend": This means that class itself can use the methods, as opposed to instances of the class.
# ThePresent has a .now method that we'll extend to TheHereAnd
module ThePresent
  def now
    puts "It's #{Time.new.hour > 12 ? Time.new.hour - 12 + 3 :\
    Time.new.hour + 3}:#{Time.new.min} #{Time.new.hour > 12 ? 'PM' : 'AM'} (GMT+3)."
  end
end
class TheHereAnd
  extend ThePresent
end
TheHereAnd.now

# Tenth Project: Banking on Ruby
class Account
  attr_reader :name
  attr_reader :balance
  def initialize(name, balance=100)
    @name = name; @balance = balance; end
  private
  def pin
    @pin = 1234
  end
  private
  def pin_error
    "Access denied: incorrect PIN."
  end
  public
  def display_balance(pin_number)
    puts pin_number == pin ? "Balance: $#{balance}." : pin_error
  end
  public
  def withdraw(pin_number, amount)
    @balance -= amount
    if pin_number == pin
      puts "Withdrew #{amount}. New balance: $#{@balance}."
    else
      puts pin_error
    end
  end
end

my_account = Account.new("Mert", 12_770_000)
my_account.display_balance(1234)
my_account.withdraw(1234, 70000)
my_account.display_balance(1234)
my_account.withdraw(4321, 500)