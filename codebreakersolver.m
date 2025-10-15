%% Codebreaker Solver
close all
clear
clc

tic
% Input
board1 = [8 6 5 4 2 7 9 1 3]; % Starts at the top left
hits1  = [0 0 0 0 0 0]; % Row then column (123, 123)
busts1 = [1 1 2 1 0 0];

board2 = [6 5 8 9 7 2 4 3 1]; % 1 at top right
hits2  = [1 1 1 0 1 2]; % Row then column (123, 123)
busts2 = [0 0 2 2 2 0];

sol1 = solve(board1,hits1,busts1);
sol2 = solve(board2,hits2,busts2);

[isMatch, idx] = ismember(sol1, sol2, 'rows');

salt1 = sol1(randi(length(sol1(:,1))),:)

% Extract matching rows
matchingRows = sol1(isMatch, :)




function solution = solve(board, hits, busts)

% Generates 362880x9 double
possible_solutions = perms(1:9);
mat = [1 2 3; 4 5 6; 7 8 9];
for i = 1:6
    if i <= 3
        % Case of row
        cols = mat(i,:);
    else
        % Case of column
        cols = mat(:,i-3);
    end
    board_vals = board(cols); % The actual numbers in the board for that row/col
    if hits(i) == 0
        for j = 1:3
            possible_solutions(possible_solutions(:, cols(j)) == board_vals(j), :) = [];
        end
        % Count misplaced numbers
        misplaced_counts = sum(ismember(possible_solutions(:, cols), board_vals), 2);

        % Filter possible_solutions where the count of misplaced numbers matches busts(i)
        possible_solutions = possible_solutions(misplaced_counts == busts(i), :);
    elseif hits(i) == 1
        valid_rows = sum(possible_solutions(:, cols) == board(cols), 2) == 1;
        possible_solutions = possible_solutions(valid_rows, :);
    elseif hits(i) == 2
        valid_rows = sum(possible_solutions(:, cols) == board(cols), 2) == 2;
        possible_solutions = possible_solutions(valid_rows, :);
    elseif hits(i) == 3
        valid_rows = all(possible_solutions(:, cols) == board(cols), 2);
        possible_solutions = possible_solutions(valid_rows, :);
    end
end

solution = possible_solutions;

disp('done')

end
toc

% Code check
% if matchingRows == [4 2 9 7 8 5 6 1 3]
%     disp('still valid, congratulations');
% else
%     disp('it has failed')
% end
