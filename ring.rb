require 'opencv'
include OpenCV

window = OpenCV::GUI::Window.new "face detect"
capture = OpenCV::CvCapture.open
detector = OpenCV::CvHaarClassifierCascade::load "./haarcascade_frontalface_default.xml"

loop do
  image = capture.query
  image = image.resize OpenCV::CvSize.new 640, 360
  detector.detect_objects(image).each do |rect|
    # puts "detect!! : #{rect.top_left}, #{rect.top_right}, #{rect.bottom_left}, #{rect.bottom_right}"
    # image.rectangle! rect.top_left, rect.bottom_right, :color => OpenCV::CvColor::Red

    image.set_roi(rect)
    # (0..((image.rows * image.cols)-1)).each_slice(image.rows/6) do |j|
    #   p j
    #   tmp = image[j[0]]
    #   j.each do |i|
    #     image[i]=tmp
    #   end
    # end

    image2 = image.smooth(:median,25,49)
    (image.rows * image.cols).times do |j|
      image[j] = image2[j]
    end


    
   



    image.reset_roi
  end
  window.show image
  break if OpenCV::GUI::wait_key(100)
end
