%==========================================================================
% Author: Carl Larsson
% Description: A* heuristic (Euclidean distance)
% Date: 2024-04-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function heuristic = A_star_heuristic(current_position, goal_position)

    heuristic = norm(current_position-goal_position);

end