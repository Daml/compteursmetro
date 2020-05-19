<?php

$data = json_decode(file_get_contents('php://stdin'));
$out = fopen('php://stdout', 'w+');

foreach ($data as $idx => $val) {
    if (! is_array($val)) {
        error_log('Hum ??', print_r($val, true));
    } else {
        $dt = date_create_from_format('!m/d/Y', $val[0]);
        fputcsv($out, array($dt->format('Y-m-d'), (int)$val[1]), "\t");
    }
}

fclose($out);

/**/
