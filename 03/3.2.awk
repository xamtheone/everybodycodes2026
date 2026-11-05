{
    gsub(/ISO-/, "", $1)
    l = length($2)
    s = 0
    for (i = 1; i <= l; i++) {
        # reverse both parts
        left = ""
        for (j = length($1); j > 0; j--) {
            left = left substr($1, j, 1)
        }
        
        right = ""
        for (j = length($2); j > 0; j--) {
            right = right substr($2, j, 1)
        }
        
        a = substr(right, i, 1)
        b = substr(left, (i - 1) % length($1) + 1, 1)

        t += a * b ** (i - 1)
    }
}
END {print t}