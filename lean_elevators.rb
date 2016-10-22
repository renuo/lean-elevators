$LOAD_PATH << File.expand_path('lib')

require 'building'
require 'elevator'
require 'floor'
require 'panel'
require 'person'

require_relative 'deciders/random'

random_elevator_one = Elevator.new(Deciders::Random)
random_elevator_two = Elevator.new(Deciders::Random)

building = Building.new([random_elevator_one, random_elevator_two])

10_000.times do
  building.populate_floors
  building.tick

  sleep(1)

  system('clear')
  puts building.to_s
end