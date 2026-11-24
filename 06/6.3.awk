BEGIN {FS=":"}
{
    split($2, ingredients, ",")
    for (v in ingredients) {
        map[ingredients[v]][$1] = 1
        if (ingredients[v] == "NULLv1") {
            nv1[$1] = 1
        }
        else if (ingredients[v] == "NULLv2") {
            nv2[$1] = 1
        }
        else if (ingredients[v] == "NULLv3") {
            nv3[$1] = 1
        }
    }
}
END {
    split("", from_v1)
    find(nv1, map, from_v1)
    split("", from_v2)
    find(nv2, map, from_v2)
    split("", from_v3)
    find(nv3, map, from_v3)

    for (v in from_v1) {
        if (v in from_v2 || v in from_v3) {
            result[v] = 1
        }
    }
    for (v in from_v2) {
        if (v in from_v3) {
            result[v] = 1
        }
    }

    print length(result)
}

function find(Q, map, visited,
    item,
    ing) {
    for (item in Q) {
        visited[item] = 1
    }

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
}