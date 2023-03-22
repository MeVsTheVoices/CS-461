CORRECT_ARRANGEMENT =[[0, 1, 2],[3, 4, 5],[6, 7, 8]]

def isAt(wantedArrangement, value):
    isAtRow = 0
    isAtColumn = 0
    found = False
    for i, iItem in enumerate(wantedArrangement):
        for j, jItem in enumerate(iItem):
            if value == jItem:
                isAtRow = i
                isAtColumn = j
                found = True
                return isAtRow, isAtColumn
    if not found:
        return -1, -1
    
def swapArrangement(arrangement, wantedRow, wantedColumn):
    newArrangement = arrangement
    zeroIsAtRow, zeroIsAtColumn = isAt(arrangement, 0)
    saved = arrangement[wantedRow][wantedColumn]
    newArrangement[wantedRow][wantedColumn] = 0
    newArrangement[zeroIsAtRow][zeroIsAtColumn] = saved
    return newArrangement

def adjacentToZero(arrangement):
    zeroIsAtRow, zeroIsAtColumn = isAt(arrangement, 0)
    values = []
    if zeroIsAtRow < 2:
        values.append(arrangement[zeroIsAtRow+1][zeroIsAtColumn])
    if zeroIsAtRow > 0:
        values.append(arrangement[zeroIsAtRow-1][zeroIsAtColumn])
    if zeroIsAtColumn < 2:
        values.append(arrangement[zeroIsAtRow][zeroIsAtColumn+1])
    if zeroIsAtColumn > 0:
        values.append(arrangement[zeroIsAtRow][zeroIsAtColumn-1])
    return values

def distanceForOne(wantedArrangement, arrangement, row, column):
    wantedIsAtRow, wantedIsAtColumn = isAt(wantedArrangement, arrangement[row][column])
    return abs(wantedIsAtRow - row) + abs(wantedIsAtColumn - column)

def distanceForAll(wantedArrangement, arrangement):
    sum = 0
    for i, iItem in enumerate(arrangement):
        for j, jItem in enumerate(iItem):
            sum = sum + distanceForOne(wantedArrangement, arrangement, i, j)
    return sum

def generateAll(arrangement):
    isAtRow, isAtColumn = isAt(arrangement, 0)

    valuesAdjacentToZero = adjacentToZero(arrangement)
    newArrangements = []
    for i in valuesAdjacentToZero:
        isAtRow, isAtColumn = isAt(arrangement, i)
        newArrangements.append(swapArrangement(arrangement, isAtRow, isAtColumn))
    return newArrangements

def prettyPrint(wanted, arrangement):
    permutations = generateAll(arrangement)
    for i, iItem in enumerate(permutations):
        print("#", i, ":", distanceForAll(wanted, iItem))
        print(iItem)

def keepAtIt(wanted, arrangement):
    explored = []
    newArrangement = arrangement
    while wanted != newArrangement:
        permutations = generateAll(newArrangement)
        print(permutations)
        permutations.sort(key = lambda x: distanceForAll(wanted, x), reverse = True)
        permutations[:] = [x for x in permutations if x not in explored]
        if (len(permutations) <= 0):
            print("up a creek")
            return
        newArrangement = permutations[0]
        explored.append(newArrangement)