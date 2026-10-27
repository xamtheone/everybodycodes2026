BEGIN { RS = "," }
{
    a = ($1 + 1) ** 0.5
    b = int(a)
    if (a > b) b++
    if (b % 2 == 0) b++
    b = b * b - 1
    if (b < 8) b = 8
    c += b - $1
}
END { print c }