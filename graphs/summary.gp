set terminal png size 800,600
set xtic rotate by -45 scale 0
set grid
set xdata time
set timefmt "%Y"
set xtics format "%Y"
set datafile separator ","

plot \
    'data/100000562.summary.csv' using 1:($3/$2) with lines lw 2 t "100000562", \
    'data/100000563.summary.csv' using 1:($3/$2) with lines lw 2 t "100000563", \
    'data/100000564.summary.csv' using 1:($3/$2) with lines lw 2 t "100000564", \
    'data/100000565.summary.csv' using 1:($3/$2) with lines lw 2 t "100000565", \
    'data/100000566.summary.csv' using 1:($3/$2) with lines lw 2 t "100000566", \
    'data/100047091.summary.csv' using 1:($3/$2) with lines lw 2 t "100047091", \
    'data/100049059.summary.csv' using 1:($3/$2) with lines lw 2 t "100049059", \
    'data/100051043.summary.csv' using 1:($3/$2) with lines lw 2 t "100051043", \
    'data/100051044.summary.csv' using 1:($3/$2) with lines lw 2 t "100051044", \
    'data/100055803.summary.csv' using 1:($3/$2) with lines lw 2 t "100055803", \
    'data/100057387.summary.csv' using 1:($3/$2) with lines lw 2 t "100057387", \
    'data/100057388.summary.csv' using 1:($3/$2) with lines lw 2 t "100057388", \
    'data/100057814.summary.csv' using 1:($3/$2) with lines lw 2 t "100057814", \
    'data/100058593.summary.csv' using 1:($3/$2) with lines lw 2 t "100065252", \
