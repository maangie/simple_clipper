require "gnuplot"
require 'clipper'
require 'pry'

def gnuplot_array(clipper_array)
  res = [
    clipper_array.map { |data| data[0] },
    clipper_array.map { |data| data[1] }
  ]

  res[0].push clipper_array.first[0]
  res[1].push clipper_array.first[1]
  res
end

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
    plot.xrange '[-10:210]'
    plot.yrange '[-10:110]'
    a = [[0, 0], [0, 100], [100, 100], [100, 0]]
    b = [[-5, 50], [200, 50], [100, 5]]

    plot.data << Gnuplot::DataSet.new(gnuplot_array(a)) do |ds|
      ds.with = "lines"
    end

    plot.data << Gnuplot::DataSet.new(gnuplot_array(b)) do |ds|
      ds.with = "lines"
    end

    clipper = Clipper::Clipper.new
    clipper.add_subject_polygon(a)
    clipper.add_clip_polygon(b)    
    c = clipper.union(:non_zero, :non_zero)[0]
    
    plot.data << Gnuplot::DataSet.new(gnuplot_array(c)) do |ds|
      ds.with = "lines"
      ds.linewidth = 4
    end
  end
end
