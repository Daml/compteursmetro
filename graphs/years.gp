set terminal png size 800,600
set xtic rotate by -45 scale 0
set grid
set xdata time
set timefmt "%Y-%m-%d"
set xtics format "%b %Y"

set xrange ['2020-01-01':'2020-12-31']

set datafile separator ","
set key autotitle columnhead

plot filename using 1:5 smooth sbezier t "2020", \
    '' using (timecolumn(1)+365*24*3600):5 smooth sbezier t "2019", \
    '' using (timecolumn(1)+2*365*24*3600):5 smooth sbezier lw 5 t "2018", \
    '' using (timecolumn(1)+3*365*24*3600):5 smooth sbezier lw 4 t "2017", \
    '' using (timecolumn(1)+4*365*24*3600):5 smooth sbezier lw 3 t "2016", \
    '' using (timecolumn(1)+5*365*24*3600):5 smooth sbezier lw 1 t "2015", \
    '' using (timecolumn(1)+6*365*24*3600):5 smooth sbezier lw 1 t "2014", \
    '' using (timecolumn(1)+7*365*24*3600):5 smooth sbezier lw 1 t "2013", \
    '' using (timecolumn(1)+8*365*24*3600):5 smooth sbezier lw 1 t "2012", \
    '' using (timecolumn(1)+9*365*24*3600):5 smooth sbezier lw 1 t "2011", \
    '' using (timecolumn(1)+10*365*24*3600):5 smooth sbezier lw 1 t "2010", \
    '' using (timecolumn(1)+11*365*24*3600):5 smooth sbezier lw 1 t "2009", \
    '' using (timecolumn(1)+12*365*24*3600):5 smooth sbezier t "2008", \
    '' using (timecolumn(1)+13*365*24*3600):5 smooth sbezier  t "2007"
