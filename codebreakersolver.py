import itertools
import numpy as np

def solve(board, hits, busts):
    possible_solutions = np.array(list(itertools.permutations(range(1, 10))))
    mat = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
    
    for i in range(6):
        if i < 3:
            cols = mat[i, :]
        else:
            cols = mat[:, i - 3]
        
        board_vals = board[np.array(cols) - 1]  # Convert to zero-based indexing
        
        if hits[i] == 0:
            mask = np.ones(len(possible_solutions), dtype=bool)
            for j in range(3):
                mask &= possible_solutions[:, cols[j] - 1] != board_vals[j]
            
            possible_solutions = possible_solutions[mask]
            
            misplaced_counts = np.array([np.sum(np.isin(row[cols - 1], board_vals)) for row in possible_solutions])
            possible_solutions = possible_solutions[misplaced_counts == busts[i]]
        
        elif hits[i] in {1, 2, 3}:
            valid_rows = np.sum(possible_solutions[:, cols - 1] == board_vals, axis=1) == hits[i]
            possible_solutions = possible_solutions[valid_rows]
    
    print("done")
    return possible_solutions

# Inputs
board1 = np.array([1, 2, 3, 4, 5, 6, 7, 8, 9])
hits1  = [1, 0, 0, 0, 1, 0]
busts1 = [0, 1, 0, 2, 1, 2]

board2 = np.array([7, 2, 8, 5, 3, 9, 4, 1, 6])
hits2  = [1, 0, 1, 0, 2, 0]
busts2 = [0, 1, 1, 2, 0, 1]

sol1 = solve(board1, hits1, busts1)
sol2 = solve(board2, hits2, busts2)

matching_rows = [row for row in sol1 if any(np.array_equal(row, r) for r in sol2)]

if any(np.array_equal(row, np.array([4, 2, 9, 7, 8, 5, 6, 1, 3])) for row in matching_rows):
    print('still valid, congratulations')
else:
    print('you fcuking failure')



matching_rows = [row for row in sol1 if any(np.array_equal(row, r) for r in sol2)]

# Print the matching rows
if matching_rows:
    print("Matching rows:")
    for row in matching_rows:
        print(row)
else:
    print("No matching rows found.")


    print(matching_rows)
    
