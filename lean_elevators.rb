$LOAD_PATH << File.expand_path('lib')

require 'building'
require 'elevator'
require 'floor'
require 'panel'
require 'person'

require_relative 'deciders/random'
require_relative 'deciders/first_come_first_serve'

random_elevator_one = Elevator.new(Deciders::Random)
random_elevator_two = Elevator.new(Deciders::FirstComeFirstServe)

building = Building.new([random_elevator_one, random_elevator_two])

100_000.times do
  building.populate_floors
  building.tick

  sleep(1)

  system('clear')
  puts building.to_s
  puts
  puts "random: #{random_elevator_one.statistics}"
  puts "fcfs:   #{random_elevator_two.statistics}"
end