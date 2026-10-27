BEGIN { RS = "," }
{
    a = ($1 + 1) ** 0.5
    b = int(a)
    if (a > b) b += 1
    c += b * b - 1 - $1
}
END { print c }