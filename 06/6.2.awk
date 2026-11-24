BEGIN {FS=":"}
$1 != "NULL" {
    split($2, ingredients, ",")
    for (v in ingredients) {
        map[ingredients[v]][$1] = 1
        if (ingredients[v] == "NULL") {
            Q[$1] = 1
            visited[$1] = 1
        }
    }
}
END {
    while (length(Q)) {
        for (item in Q) {
            if (item in map) {
                for (ing in map[item]) {
                    if (ing in visited) continue
                    visited[ing] = 1
                    Q[ing] = 1
                }
            }
            delete Q[item]
        }
    }

    print length(visited)
}