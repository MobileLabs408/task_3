%==========================================================================
% Author: Carl Larsson
% Description: Reconstruct path taken from start to current node (possibly goal)
% Date: 2024-04-26

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function path = reconstruct_path(current_node)

    % Reconstruct path from start node to current node
    path = [];
    % Continously step back into parent node, starting at current node
    while ~isempty(current_node)
        % Inserting in this order will result with start node at top and
        % current node at bottom
        path = [current_node.position; path];
        current_node = current_node.parent;
    end

end