# Start webserver ./bin/server
# Start pry

$:.unshift(File.join("..", "lib")); require "presentation";

include Presentation::Live

start(:title => "my presentation")

t "hello"

v "../test/media/test.mp4"

a "../test/media/test.wav"

pdf!
