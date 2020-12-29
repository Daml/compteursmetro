<?php

$in = fopen("php://stdin", "r");
$out = fopen("php://stdout", "w");

$current = null;
$cnt = 0;
$sum = 0;

$header = fgetcsv($in);
while ($line = fgetcsv($in)) {
    if ($line[3] > 0) {
        continue;
    }

    $year = substr($line[0], 0, 4);
    if ($current != $year) {
        if ($current) {
            fputcsv($out, [$current, $cnt, $sum]);
        }
        $current = $year;
        $cnt = $sum = 0;
    }

    $cnt += 1;
    $sum += $line[4];
}

fputcsv($out, [$year, $cnt, $sum]);
