%==========================================================================
% Author: Carl Larsson
% Description: Get neighboring positions (possible successors) of a
% position
% Date: 2024-04-25

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function neighbors = get_neighboring_nodes(position)

    % Horizontal, vertical and diagonal
    moves = [0, 1; 0, -1; 1, 0; -1, 0; 1, 1; 1, -1; -1, 1; -1, -1];
    % Performs element wise addition of current_node with each row in
    % moves
    neighbors = bsxfun(@plus, position, moves);

end