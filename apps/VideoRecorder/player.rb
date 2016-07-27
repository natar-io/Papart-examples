#!/bin/ruby

require 'fileutils'
# First argument is starting number

name = "capture"
output_name = "playing/capture000000.jpg"

# start with zero, to take from input arguments
id = ARGV[0].to_i
device = "/dev/video0"


## Start Gstreamer
pid = Process.fork do
  `gst-launch-0.10 multifilesrc location=playing/capture%06d.jpg start-index=0 stop-index=0 loop=true caps="image/jpeg,framerate=\(fraction\)1/1" ! jpegdec ! ffmpegcolorspace ! videorate ! v4l2sink device=/dev/video0`
end

file_name = name + id.to_s.rjust(6, "0") + ".jpg"
p file_name
p FileTest.exists? file_name


## update with the latest picture
while true do
  if FileTest.exists? file_name
    p "Putting image: " +  id.to_s
    FileUtils.cp file_name, output_name

    id = id +1
    file_name = name + id.to_s.rjust(6, "0") + ".jpg"
  end

  sleep 1
end





## Notes...

# Working !
# gst-launch-0.10 multifilesrc location=capture%06d.jpg start-index=0 stop-index=100 loop=true caps="image/jpeg,framerate=\(fraction\)1/1" ! jpegdec ! ffmpegcolorspace ! videorate ! v4l2sink device=/dev/video0
