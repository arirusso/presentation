#!/usr/bin/env ruby
$:.unshift(File.join("..", "lib"))

require "presentation"

c = Presentation.new(:title => "my pres")

c.text("hello")

c.text("another slide")

c.create_pdf
