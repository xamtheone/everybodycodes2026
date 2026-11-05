{
    gsub(/ISO-/, "", $1)
    a = 0;
    for (i = 1; i <= length($1); i++) {
        a += substr($2, i, 1) * substr($1, i, 1) ** (length($1) - i)
    }

    b += a
}
END {print b}