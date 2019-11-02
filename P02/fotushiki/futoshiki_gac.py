import queue

size = 0
def DWO(values, compare, x, y, num):
    constraints = [[False for _ in range(size)] for _ in range(2)]
    GACQueue = queue.Queue()
    # 0 means row, 1 means column
    GACQueue.put((0, x))
    GACQueue.put((1, y))
    constraints[0][x] = True
    constraints[1][y] = True
    while (not GACQueue.empty()):
        index, n = GACQueue.get()
        constraints[index][n] = False
        for a in range(size):
            if (index == 0):
                x, y = n, a
            else:
                x, y = a, n
            temp = list(values[x][y])
            for now in temp:
                if (check(values, compare, index, n, x, y, now) == False):
                    values[x][y] = [value for value in values[x][y] if value != now]
                    if (not values[x][y]):
                        return True
                    else:
                        GACQueue.put((index, n))
                        constraints[index][n] = True
                        if (constraints[1 - index][a] == False):
                            GACQueue.put((1 - index, a))
                            constraints[1 - index][a] = True

    return False


def compare_fail(values, compare, x, y, now):
    small, large = compare
    if ((x, y) in small):
        for a, b in small[(x, y)]:
            for value in values[a][b]:
                if (now < value):
                    return False
        return True
    if ((x, y) in large):
        for a, b in large[(x, y)]:
            for value in values[a][b]:
                if (now > value):
                    return False
        return True
    return False


def dfs(values, compare, index, n, now, visited):
    if now == size:
        return True
    if (index == 0):
        x, y = n, now
    else:
        x, y = now, n

    for value in values[x][y]:
        if (visited[value - 1] or compare_fail(values, compare, x, y, value)):
            continue
        visited[value - 1] = True
        if (dfs(values, compare, index, n, now + 1, visited)):
            return True
        visited[value - 1] = False

    return False


def read(string):
    global size
    chess_board = []
    small, large = {}, {}
    f=open(string)
    line = f.readline().strip('\n')
    size = int(line)
    print(size)
    for _ in range(size):
        line = f.readline().strip('\n')
        if line == '':
            continue
        nums = [int(num) for num in line.rstrip().split(' ')]

        chess_board.append(nums)
    for i in chess_board:
        print(i)

    lines = f.readlines()
    for line in lines:
        line = line.strip('\n')
        if line == '':
            continue
        a, b, c, d = [int(num) for num in line.rstrip().split(' ')]
        left, right = (a, b), (c, d)
        if (left in small):
            small[left].append(right)
        else:
            small[left] = [right]
        if (right in large):
            large[right].append(left)
        else:
               large[right] = [left]

    compare = (small, large)
    return chess_board, compare


def check(values, compare, index, n, x, y, value):
    visited = [False for _ in range(size)]
    before = list(values[x][y])
    values[x][y] = [value]
    flag = dfs(values, compare, index, n, 0, visited)
    values[x][y] = before
    return flag



def copy_temp(a):
    b = []
    for row in a:
        temp_row = []
        for col in row:
            temp = list(col)
            temp_row.append(temp)
        b.append(temp_row)

    return b


def initial(chess_board, compare):
    values = []
    assign = [[False for _ in range(size)] for _ in range(size)]
    for row in chess_board:
        value_row = []
        for index in row:
            if (index == 0):
                value = [a for a in range(1, size + 1)]
                value_row.append(value)
            else:
                value_row.append([index])

        values.append(value_row)

    for a in range(size):
        for b in range(size):
            if (chess_board[a][b] != 0):
                assign[a][b] = True
                DWO(values, compare, a, b, chess_board[a][b])
    return (values, assign)


def assginment(values, assign):
    Min = 999
    x, y = -1, -1
    for a in range(size):
        for b in range(size):
            l = len(values[a][b])
            if (assign[a][b] == False and l < Min):
                Min = l
                x = a
                y = b

    return (x, y)


def printf(chess_board):
    for row in chess_board:
        for index in row:
            print(str(index), end=' ')
        print('')


def GAC(values, compare, assign, chess_board):
    (x, y) = assginment(values, assign)
    if ((x, y) == (-1, -1)):
        return True

    assign[x][y] = True
    members = list(values[x][y])
    for num in members:
        chess_board[x][y] = num
        temp_values = copy_temp(values)
        values[x][y] = [num]
        if (DWO(values, compare, x, y, num) == False):
            flag = GAC(values, compare, assign, chess_board)
            if (flag):
                return True

        values = copy_temp(temp_values)

    assign[x][y] = False
    return False


def run(string):
    chess_board, compare = read(string)
    values, assign = initial(chess_board, compare)
    dd = GAC(values, compare, assign, chess_board)
    if (dd):
        printf(chess_board)


if __name__=='__main__':
    # string = './case1.txt'
    # string = './case2.txt'
    # string = './case3.txt'
    # string = './case4.txt'
    string = './case5.txt'
    run(string)

