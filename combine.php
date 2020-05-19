<?php

$sources = array_splice($argv, 1);

$min = date("Y-m-d");
$max = "1900-01-01";

$keys = [];
$data = [];

foreach ($sources as $filepath) {
    $fp = fopen($filepath, 'r');
    $key = explode('.', basename($filepath))[0];
    $keys[] = $key;
    $data[$key] = [];

    while (false != ($d = fgetcsv($fp, 0, "\t"))) {
        $data[$key][$d[0]] = $d[1];
        $min = min($min, $d[0]);
        $max = max($max, $d[0]);
    }

    fclose($fp);
}

$dt = date_create_from_format('!Y-m-d', $min);
$stop = date_create_from_format('!Y-m-d', $max);


$out = fopen('php://stdout', 'w');

fputcsv($out, array_merge(array('date', 'dow', 'holiday'), $keys), "\t");

while ($dt <= $stop) {
    $day = $dt->format('Y-m-d');

    $exp = array(
        $day, // date
        $dt->format('N'), // ISO Day of week 1 (monday)-7
        null, // Reserved for future : holidays
    );

    foreach ($keys as $key) {
        if (array_key_exists($day, $data[$key])) {
            $exp[] = $data[$key][$day];
        } else {
            $exp[] = '';
        }
    }

    fputcsv($out, $exp, "\t");
    $dt->modify('+1 day');
}

fclose($out);

/**/
