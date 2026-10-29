<?php declare(strict_types=1);

$checksum = 0;
while (($line = fgets(STDIN)) !== false) {
    $alloys = [];
    $orders = [];
    $pairs = explode(' ', $line);

    foreach ($pairs as $pair) {
        $alloys[$pair[0]] = true;
        $alloys[$pair[2]] = true;
        $orders[$pair[0]][$pair[2]] = $pair[1]; 
    }

    $alloys = array_keys($alloys);

    usort($alloys, function ($a, $b) use ($orders) {
        if (isset($orders[$a][$b])) {
            return $orders[$a][$b] == '<' ? 1 : -1;
        }

        return $orders[$b][$a] == '<' ? -1 : 1;
    });

    $checksum += implode('', $alloys);
}

echo "$checksum\n";
