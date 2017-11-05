#!/usr/bin/env ruby

class Dungeon
  attr_accessor :player

  def initialize(player)
    @player = player #player may change the state of the dungeon in some way.
    @rooms ={} #equive to @rooms= Hash.new, empty hash
  end

  def add_room(reference, name, description, connections)
    @rooms[reference] = Room.new(reference, name, description, connections)
  end

end


Player= Struct.new(:name, :location) #Struct is a class has attributes & stores data. Parameters are optional.

Room= Struct.new(:reference, :name, :description, :connections) #creates a Room class


me = Player.new("Sarah")
my_dungeon= Dungeon.new(me)
puts my_dungeon.player.name

my_dungeon.add_room(:largecave, "Large Cave", "a large cavernous cave", {:west => :smallcave})

my_dungeon.add_room(:smallcave, "Small Cave", "a small cavernous cave", {:east => :largecave})
