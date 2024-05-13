%==========================================================================
% Author: Carl Larsson
% Description: Initializes D* lite
% Date: 2024-04-30

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [U, g, rhs, k_m, push, pop] = initialize_D_star(created_map, start_position, goal_position)
    
    % Used for keeping track of the number of pushes and pops 
    push = 0;
    pop = 0;

    % Get dimensions of map
    [map_rows, map_columns] = size(created_map);

    % Open list, Priority queue
    U = [];

    % Estimate heuristic distance for start to goal
    % 0 because rhs = 0 for goal
    k_m = 0;

    % Initialize g and rhs values
    % g is cost of reaching this state from begining node
    g = Inf(map_rows, map_columns);
    % The rhs-values are one-step lookahead values
    rhs = Inf(map_rows, map_columns);
    % rhs for goal is then naturally 0
    rhs(goal_position(1), goal_position(2)) = 0;

    % Insert goal node into priority queue
    k = calculate_key(start_position, goal_position, g, rhs, k_m);
    goal_node = struct('position', goal_position,'k1', k(1), 'k2', k(2));
    U = [U; goal_node];

end