set terminal png size 800,600
set xtic rotate by -45 scale 0
set grid
set xdata time
set timefmt "%Y-%m-%d"
set xtics format "%d/%m"

set xrange ['2020-10-01':'2020-12-31']

set datafile separator ","
set key autotitle columnhead

plot filename using 1:5 with lines lw 3, \
    '' using 1:6 with lines, \
    '' using 1:7 with lines
