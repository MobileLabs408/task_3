%==========================================================================
% Author: Carl Larsson
% Description: A* heuristic (Euclidean distance)
% Date: 2024-04-25

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function heuristic = A_star_heuristic(current_position, goal_position)

    % Euclidean distance
    heuristic = norm(current_position-goal_position);
    
    % Having heuristic = 0 makes A* = Djisktra
    %heuristic = 0;

end