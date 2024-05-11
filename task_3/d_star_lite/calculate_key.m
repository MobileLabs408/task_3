%==========================================================================
% Author: Carl Larsson
% Description: Calculates key for a position
% Date: 2024-04-30

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function k = calculate_key(start_position, position, g, rhs, k_m)

    % Calculate key (index) for a position.
    % first element (k1) can be seen as total cost to start node.
    % second element (k2) can be seen as cost of reaching this node from begining node.
    k = [min(g(position(1), position(2)), rhs(position(1), position(2))) + D_star_heuristic(start_position, position) + k_m, 
         min(g(position(1), position(2)), rhs(position(1), position(2)))];

end