%==========================================================================
% Author: Carl Larsson
% Description: A* get all neighboring nodes of current node
% Date: 2024-04-25

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function neighbors = get_neighboring_nodes(current_node)

    % Horizontal, vertical and diagonal
    moves = [0, 1; 0, -1; 1, 0; -1, 0; 1, 1; 1, -1; -1, 1; -1, -1];
    % Performs element wise addition of current_node with each row in
    % moves
    neighbors = bsxfun(@plus, current_node, moves);

end