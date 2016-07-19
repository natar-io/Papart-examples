# -*- coding: utf-8 -*-

require 'jruby_art'
require 'jruby_art/app'

Processing::App::SKETCH_PATH = __FILE__
Processing::App::load_library :PapARt, :javacv, :toxiclibscore

module Papartlib
  include_package 'fr.inria.papart.procam'
end

class Sketch < Processing::App

  attr_reader :camera_tracking, :display, :papart, :moon

  def settings
    size 200, 200, Processing::App::P3D
  end

  def setup

    @useProjector = false

    if @useProjector

      @papart = PapartLib::Papart.projection(self)
      @papart.loadTouchInput()
    else
      @papart = Papartlib::Papart.seeThrough self
    end

    @moon = PaperTouch.new

    @papart.startTracking

    def draw
    end
  end
end




class PaperTouch < Papartlib::PaperScreen

  def settings
    setDrawingSize 297, 210
    loadMarkerBoard(Papartlib::Papart::markerFolder + "A3-small1.svg", 297, 210)
    setDrawOnPaper
  end

  def setup
  end

  def drawOnPaper
    setLocation(0, 0, 0)
    background 40, 200, 200
  end
end

Sketch.new unless defined? $app
