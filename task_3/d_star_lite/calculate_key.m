%==========================================================================
% Author: Carl Larsson
% Description: Calculates key for a position, not current_position 
% unless position = current_position
% Date: 2024-04-30

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function k = calculate_key(current_position, position, g, rhs, k_m)

    % Calculate key for a position (not current_position unless
    % position = current_position).
    % first element (k1) can be seen as total cost to start node.
    % second element (k2) can be seen as cost of reaching this node from begining node.
    k = [min(g(position(2), position(1)), rhs(position(2), position(1))) + D_star_heuristic(current_position, position) + k_m,...
         min(g(position(2), position(1)), rhs(position(2), position(1)))];

end