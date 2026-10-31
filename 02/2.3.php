<?php declare(strict_types=1);

$checksum = 0;
while (($line = fgets(STDIN)) !== false) {
    $alloys = [];
    $pairs = explode(' ', $line);

    $parents = [];
    $children = [];

    foreach ($pairs as $pair) {
        $alloys[$pair[0]] = true;
        $alloys[$pair[2]] = true;

        if ($pair[1] == '<') {
            $parents[$pair[0]][] = $pair[2];
            $children[$pair[2]][] = $pair[0];
        }
        else {
            $parents[$pair[2]][] = $pair[0];
            $children[$pair[0]][] = $pair[2];
        }
    }

    foreach (array_keys($alloys) as $a) {
        $parents[$a] ??= [];
        $children[$a] ??= [];
        if (!$parents[$a]) {
            $root = $a;
        }
    }
    
    // Topological sort: Khan's algorithm

    $L = [];
    $S = [$root];

    while ($S) {
        $node = array_pop($S);
        $L[] = $node;
        foreach ($children[$node] as $m) {
            $parents[$m] = array_filter($parents[$m], fn ($v) => $v != $node);
            if (!$parents[$m]) {
                $S[] = $m;
            }
        }
    }

    $number = implode($L);
    $checksum += $number;
}

echo "$checksum\n";
