require 'clipper'
require 'pry'

a = [[0, 0], [0, 100], [100, 100], [100, 0]]
b = [[-5, 50], [200, 50], [100, 5]]

c = Clipper::Clipper.new

c.add_subject_polygon(a)
c.add_clip_polygon(b)
p c.union :non_zero, :non_zero
