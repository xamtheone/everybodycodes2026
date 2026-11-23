input = open(0).read().splitlines()

H = len(input)
W = len(input[0])

grid = [[c for c in row] for row in input]

startx = W // 2
starty = H // 2

grid[starty][startx] = '#'

dirs = (
    (0, -1),
    (1, -1),
    (1, 0),
    (1, 1),
    (0, 1),
    (-1, 1),
    (-1, 0),
    (-1, -1),
)

tree_dirs = (
    (0, -1),
    (1, -1),
    (1, 0),
    (1, 1),
    (0, 1),
    (-1, 1),
    (-1, 0),
    (-1, -1),

    (0, -2),
    (1, -2),
    (2, -1),
    (2, 0),
    (2, 1),
    (1, 2),
    (0, 2),
    (-1, 2),
    (-2, 1),
    (-2, 0),
    (-2, -1),
    (-1, -2),
)

# 1. Fill land
border_cells = []

for x, y in dirs:
    dx = startx + x
    dy = starty + y
    border_cells.append((dx, dy))

while border_cells:
    future_border_cells = set()
    for cell_x, cell_y in border_cells:
        if grid[cell_y][cell_x] == '#':
            continue

        marked_neighbors = 0
        cells = []

        for x, y in dirs:
            dx = cell_x + x
            dy = cell_y + y

            if dx < 0 or dx >= W or dy < 0 or dy >= H:
                continue

            if grid[dy][dx] != '#':
                cells.append((dx, dy))

            if grid[dy][dx] in ('1', '#'):
                marked_neighbors += 1

        if marked_neighbors >= 5:
            grid[cell_y][cell_x] = '#'
            future_border_cells.update(cells)

    border_cells = future_border_cells

# 2.1 Fill sand phase 1
border_cells = []

new_grid = [[c for c in row] for row in grid]

for cell_y in range(H):
    for cell_x in range(W):
        if grid[cell_y][cell_x] == '#':
            for x, y in dirs:
                dx = cell_x + x
                dy = cell_y + y

                if dx < 0 or dx >= W or dy < 0 or dy >= H or grid[dy][dx] != '#':
                    new_grid[cell_y][cell_x] = '='
                    break

grid = new_grid

# 2.2 Fill sand (init land search)
for cell_y in range(H):
    for cell_x in range(W):
        if grid[cell_y][cell_x] == '#':
            for x, y in dirs:
                dx = cell_x + x
                dy = cell_y + y

                if dx < 0 or dx >= W or dy < 0 or dy >= H or grid[dy][dx] == '=':
                    border_cells.append((cell_x, cell_y))
                    break

# Fill sand phase 2 until done
while border_cells:
    future_border_cells = set()
    for cell_x, cell_y in border_cells:
        marked_neighbors = 0
        cells = []
        for x, y in dirs:
            dx = cell_x + x
            dy = cell_y + y

            if dx < 0 or dx >= W or dy < 0 or dy >= H:
                marked_neighbors += 1
                continue

            if grid[dy][dx] != '#':
                marked_neighbors += 1
            else:
                cells.append((dx, dy))

        if marked_neighbors >= 5:
            grid[cell_y][cell_x] = '='
            future_border_cells.update(cells)

    border_cells = future_border_cells

# 3.1 Fill trees phase 1
while True:
    changed = False
    for cell_y in range(H):
        for cell_x in range(W):
            if grid[cell_y][cell_x] == '#':
                marked_neighbors = 0

                for x, y in tree_dirs:
                    dx = cell_x + x
                    dy = cell_y + y

                    if dx < 0 or dx >= W or dy < 0 or dy >= H:
                        break

                    if grid[dy][dx] in ('#', '@'):
                        marked_neighbors += 1

                if marked_neighbors == 20:
                    grid[cell_y][cell_x] = '@'
                    changed = True

    if not changed:
        break

# 3.2 Fill trees phase 2
for _ in range(2):
    new_grid = [[c for c in row] for row in grid]

    for cell_y in range(H):
        for cell_x in range(W):
            if grid[cell_y][cell_x] == '#':
                marked_neighbors = 0
                has_sand = False
                for x, y in dirs:
                    dx = cell_x + x
                    dy = cell_y + y

                    if dx < 0 or dx >= W or dy < 0 or dy >= H:
                        continue

                    if grid[dy][dx] == '=':
                        has_sand = True
                        break

                    if grid[dy][dx] == '@':
                        marked_neighbors += 1

                if not has_sand and marked_neighbors >= 4:
                    new_grid[cell_y][cell_x] = '@'

    grid = new_grid

# Count trees
trees = 0
for row in grid:
    for c in row:
        if c == '@':
            trees += 1
print(trees)