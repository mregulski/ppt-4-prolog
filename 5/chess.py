import random
def board(size):
    scaleX = 6
    scaleY = scaleX//2+1
    queens = [random.randrange(size)+1 for x in range(size)]
    queens = [1, 5, 8, 6, 3, 7, 2, 4]
    board = ""
    for row in range(size*scaleY+1):
        col = 0
        while col < size*scaleX+1:
            if row % scaleY == 0 and col % scaleX == 0:
                print('+', end='')
            elif row % scaleY == 0:
                print('-', end='')
            elif col % scaleX == 0:
                print('|', end='')
            else:   # inside a square
                rowN = size - row // scaleY
                colN = col // scaleX + 1
                square_num = size * rowN + colN - size
                # print(col, end ='')

                if(rowN == queens[colN-1] and row % 2 == 0):
                    if(rowN % 2 == colN % 2):
                        print("\x1b[0;40m \x1b[0;30;43m Q \x1b[0;40m \x1b[0m", end='')
                    else:
                        print("\x1b[0;47m \x1b[0;30;43m Q \x1b[0;47m \x1b[0m", end='')
                else:
                    if(rowN % 2 == colN % 2):
                        print("\x1b[0;40m", " "*5, "\x1b[0m", end='', sep='')
                    else:
                        print("\x1b[0;47m", " "*5, "\x1b[0m", end='', sep='')
                col += scaleX-2
                # if(size % 2 == 0):
                #     if(rowN % 2 == 1):
                #         if(square_num % 2 == 1):
                #             print(":{n::^{width}d}:".format(n=square_num, width=scaleX-3), end='')
                #         else:
                #             print(" {n: ^{width}d} ".format(n=square_num, width=scaleX-3), end='')
                #     else:
                #         if(square_num % 2 == 0):
                #             print(":{n::^{width}d}:".format(n=square_num, width=scaleX-3), end='')
                #         else:
                #             print(" {n: ^{width}d} ".format(n=square_num, width=scaleX-3), end='')
                # else:
                #     if(square_num % 2 == 1):
                #         print(":{n::^{width}d}:".format(n=square_num, width=scaleX-3), end='')
                #     else:
                #         print(" {n: ^{width}d} ".format(n=square_num, width=scaleX-3), end='')
                # col += 5
            col += 1
        print("\n", end='')
    print("queens:",queens)
    print(board)

import sys
board(int(sys.argv[1]))
