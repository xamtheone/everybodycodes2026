BEGIN {FS=":"}
{
    split($2, ingredients, ",")
    for (v in ingredients) {
        map[$1][ingredients[v]] = 1
    }
}
END {
    split("", visited)
    Q["NULL"] = 1

    while (length(Q)) {
        for (item in Q) {
            if (item in map) {
                for (ing in map[item]) {
                    if (ing == "NULL" || ing in visited) continue
                    visited[ing] = 1
                    Q[ing] = 1
                }
            }
            delete Q[item]
        }
    }

    print length(visited)
}