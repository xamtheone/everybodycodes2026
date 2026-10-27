BEGIN { RS = "," }
{
    a = ($1 + 4) / 4
    b = int(a)
    if (a > b) b += 1
    t = b
    b = b * 4 - 4
    if (b < 8) b = 8
    c += b - $1
}
END { print c }
