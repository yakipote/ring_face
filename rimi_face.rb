#!/usr/bin/env ruby
require 'opencv'
include OpenCV

window = OpenCV::GUI::Window.new "face detect"
capture = OpenCV::CvCapture.open
detector = OpenCV::CvHaarClassifierCascade::load "./haarcascade_frontalface_default.xml"
rimi = IplImage::load('rimi.jpg')
loop do
  image = capture.query
  image = image.resize OpenCV::CvSize.new 640, 360
  detector.detect_objects(image).each do |rect|
    # puts "detect!! : #{rect.top_left}, #{rect.top_right}, #{rect.bottom_left}, #{rect.bottom_right}"
    # image.rectangle! rect.top_left, rect.bottom_right, :color => OpenCV::CvColor::Red


	resize_rimi = rimi.resize(rect)
    image.set_roi(rect)
    p "image#{image}"
    p "resize_rimi#{resize_rimi}"
    (image.rows * image.cols).times do |j|
    	 image[j] = resize_rimi[j]

    end
    image.reset_roi
  end
  window.show image
  break if OpenCV::GUI::wait_key(100)
end
