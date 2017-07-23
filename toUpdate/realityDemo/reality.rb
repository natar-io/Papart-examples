# -*- coding: utf-8 -*-


## Linux drivers Blueman
## Bluetooth remote https://weblog.sh/~maarten/unified-remote-with-bluetooth-on-arch-4JFboT57g
## sudo modprobe btusb
## sudo blueman-applet
## son avec pavucontrol

require 'jruby_art'
require 'jruby_art/app'

# java_signature
require 'jruby/core_ext'

Processing::App::SKETCH_PATH = __FILE__
Processing::App::load_library :PapARt, :javacv, :toxiclibscore, :skatolo, :video, :SVGExtended

module Papartlib
  include_package 'fr.inria.papart.procam'
  include_package 'fr.inria.papart.procam.camera'
  include_package 'fr.inria.papart.multitouch'
  include_package 'fr.inria.papart.utils'
  include_package 'import tech.lity.rea.svgextended'
end

module Processing
  include_package 'processing.opengl'
  include_package 'processing.video'
  include_package 'processing.video.Movie'
  include_package 'org.gstreamer.elements'
end


require_relative 'lego'
require_relative 'info'
# require_relative 'house'
# require_relative 'video'
# require_relative 'houseControl'

class Sketch < Processing::App

  attr_reader :papart, :paper_screen
  attr_accessor :save_house_location, :load_house_location, :move_house_location
  attr_reader :lego_house, :garden

  java_signature 'void movieEvent(processing.video.Movie)'
  def movieEvent(movie)
    movie.read
    p "Movie Event !"
  end

  def settings
    @use_projector = true
    fullScreen(P3D) if @use_projector
    size(300, 300, P3D) if not @use_projector
  end

  def setup
      @papart = Papartlib::Papart.projection(self)
      @papart.loadTouchInput()

    #   @lego_house = LegoHouse.new
    #   @house_control = HouseControl.new
    # @garden = Garden.new
    @info_demo = InfoDemo.new
    @papart.startTracking

    # @projector = @papart.getDisplay
    # @projector.manualMode
  end

  def draw
#     noCursor
#     noStroke

    # background 0
#     imageMode Processing::PConstants::CENTER
  end

  def key_pressed (arg = nil)
    # @move_house_location = true if key == 'm'
  end
end


Sketch.new unless defined? $app
