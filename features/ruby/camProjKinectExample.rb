# -*- coding: utf-8 -*-

require 'jruby_art'
require 'jruby_art/app'

# java_signature
require 'jruby/core_ext'

if not defined? Processing::App::SKETCH_PATH 
  Processing::App::SKETCH_PATH = __FILE__  
  Processing::App::load_library :PapARt, :javacv, :toxiclibscore, :SVGExtended
end
  
module Papartlib
  include_package 'fr.inria.papart.procam'
  include_package 'fr.inria.papart.procam.camera'
  include_package 'fr.inria.papart.multitouch'
  include_package 'fr.inria.papart.utils'
  include_package 'import tech.lity.rea.svgextended'
  # TUIO
end

class Sketch < Processing::App

  attr_reader :camera_tracking, :display, :papart, :moon

  def settings
    fullScreen Processing::App::P3D
#    size 200, 200, Processing::App::P3D
  end

  def setup

    @debug = true

    if @debug
      @papart = Papartlib::Papart.new(self)
      @papart.initDebug
#      @papart.loadTouchInputTUIO
    else 
      
      @papart = Papartlib::Papart.projection(self)
      @papart.loadTouchInput()
    end
    
    @paper = PaperTouch.new
    @papart.startTracking if not @debug
  end

  def draw
  end
end


class PaperTouch < Papartlib::PaperScreen

  def settings
    setDrawingSize 297, 210
    loadMarkerBoard(Papartlib::Papart::markerFolder + "A4-default.svg", 297, 210)

    setDrawOnPaper
  end

  def setup
  end

  def drawOnPaper
    # @r = 100
    setLocation(0, 0, 0)
    background 10

  end

end

Sketch.new unless defined? $app
