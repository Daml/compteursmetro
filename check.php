<?php

// for I in $(find series -type f -name "daily.csv"); do php check.php < $I; done

$in = fopen("php://stdin", "r");

$header = fgetcsv($in);
$width = count($header);

$date = null;
$delta = new DateInterval('P1D');

while ($line = fgetcsv($in)) {
    if (is_null($date)) {
        $date = date_create_from_format("Y-m-d", $line[0]);
    }

    if (count($line) != $width) {
        throw new Exception("Invalid CSV width");
    }

    if ($line[0] != $date->format('Y-m-d')) {
        throw new Exception("Invalid date sequence");
    }

    if ($line[1] != $date->format('W')) {
        throw new Exception("Invalid week sequence");
    }

    if ($line[2] != $date->format('N')) {
        throw new Exception("Invalid dow sequence");
    }

    if ($line[4] != $line[5] + $line[6]) {
        throw new Exception("Total <> In+Out");
    }

    if ($line[4] != array_sum(array_slice($line, 7))) {
        throw new Exception("Total <> Pratiques");
    }

    $date = $date->add($delta);
}
