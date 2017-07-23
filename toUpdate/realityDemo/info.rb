require 'skatolo'

class InfoDemo < Papartlib::PaperTouchScreen

 ## For skatolo
  def create_method(name, &block)
    self.class.send(:define_method, name, &block)

    puts "CreateMethod called"
  end
  
  def settings
    setDrawingSize 300, 200
    loadMarkerBoard($app.sketchPath + "/markers/info.svg", 200, 200)
#    setDrawAroundPaper
  end

  def setup
    init_gui
  end

  def init_gui

    setTouchOffset 0, 30
    
    if @skatolo == nil
      @skatolo = Skatolo.new $app, self
      @skatolo.getMousePointer.disable
      @skatolo.setAutoDraw false
    end

    @b1 = @skatolo.addHoverToggle("produits")
            .setPosition(18.4, drawingSize.y - 119.3 - 30)
            .setSize(45, 30)
    @b1.setImages($app.loadImage($app.sketchPath + "/boutons/produit-d.png"),
                  $app.loadImage($app.sketchPath + "/boutons/hover.png"),
                  $app.loadImage($app.sketchPath + "/boutons/produit-a.png"))
                  
    @b2 = @skatolo.addHoverToggle("services")
            .setPosition(239.7, drawingSize.y - 119.3 - 30)
            .setSize(45 , 30)
    @b2.setImages($app.loadImage($app.sketchPath + "/boutons/services-d.png"),
                  $app.loadImage($app.sketchPath + "/boutons/hover.png"),
                  $app.loadImage($app.sketchPath + "/boutons/services-a.png"))

  end

  def produits(is_activated)
    puts "Produits activated " + is_activated.to_s
  end

  def services(is_activated)
    puts "services activated " + is_activated.to_s
  end
    
  
  def drawOnPaper
    background 0

    noStroke
    colorMode Processing::PConstants::HSB, 360, 100, 100
    c = $app.millis / 100.0 % 360
    fill c, 50, 50
    ellipse_mode Processing::PConstants::CORNER

    ellipse 93.5, drawingSize.y - 119.22 - 81.1  - 2 , 79.8, 81.1
#     init_gui

    ellipse_mode Processing::PConstants::CENTER
    drawTouch
    # fill 0, 200, 0
    # rect 0, 0, drawingSize.x, drawingSize.y


    Papartlib::SkatoloLink.updateTouch touchList, @skatolo
    @skatolo.draw getGraphics

    #    image @movie, 0, 0, 30, 30
    # imageMode Processing::PConstants::CENTER
    # translate drawingSize.x/2, drawingSize.y/2
    # rotateX Processing::PConstants::PI
  end
end
