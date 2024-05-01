%==========================================================================
% Author: Carl Larsson
% Description: A* heuristic
% Date: 2024-04-25

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function heuristic = A_star_heuristic(current_position, goal_position)

    % Euclidean distance
    %heuristic = norm(current_position-goal_position);
    
    % Having heuristic = 0 makes A* = Dijkstra
    %heuristic = 0;

    % Diagonal distance
    D = 1;
    D2 = 1;
    dx = abs(current_position(1) - goal_position(1));
    dy = abs(current_position(2) - goal_position(2));
    heuristic = D*(dx + dy) + (D2 - 2*D) * min(dx, dy);

end