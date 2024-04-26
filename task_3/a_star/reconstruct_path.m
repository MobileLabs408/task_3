%==========================================================================
% Author: Carl Larsson
% Description: Reconstruct path taken from start to current node (possibly goal)
% Date: 2024-04-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function path = reconstruct_path(current_node)

    % Reconstruct path from start node to current node
    temp_path = [];
    % Continously step back into parent node, starting at current node
    while ~isempty(current_node)
        % Inserting in this order will result with start node at top and
        % current node at bottom
        temp_path = [current_node.position; temp_path];
        current_node = current_node.parent;
    end
    path = temp_path;

end