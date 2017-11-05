#!/usr/bin/env ruby

class Dungeon
  attr_accessor :player

  def initialize(player)
    @player = player #player may change the state of the dungeon in some way.
    @rooms ={} #equive to @rooms= Hash.new, empty hash
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms[reference]
  end

  def find_room_in_direction(direction)
    find_room_in_dungeon(@player.location).connections[direction]
  end

  def go(direction)
    puts "You go " + direction.to_s + "and come to a..."
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  def add_room(reference, name, description, connections)
    @rooms[reference] = Room.new(reference, name, description, connections)
  end

end

class Player
  attr_accessor :name, :location 

  def initialize(name)
    @name = name
  end
end

class Room
  attr_accessor :reference, :name, :description, :connections

  def initialize(reference, name, description, connections)
    @reference = reference
    @name = name
    @description = description
    @connections = connections
  end

  def full_description
    @name +"\nYou are in " + @description
  end
end


player = Player.new("Sarah")
my_dungeon= Dungeon.new(player)


#Adding rooms to the dungeon
my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", {:west => :smallcave})

my_dungeon.add_room(:smallcave, "Small Cave", "a small, claustrophobic cave", {:east => :largecave})

#Start dungeon by placing the player in the large cave
my_dungeon.start(:largecave)
direction= ""
until direction == "exit"
puts "Which direction would you like to go? Options: north, south, east, west- or, type 'exit' if you want to quit the game"
direction= gets.chomp.downcase.to_sym
my_dungeon.go(direction)
end
