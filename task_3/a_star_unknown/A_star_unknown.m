%==========================================================================
% Author: Carl Larsson
% Description: A* used for UNKNOWN environments, itterativly runs a
% modified version of A*, each time new infromation is gathered, update map
% Date: 2024-04-27

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [path, created_map, push, pop] = A_star_unknown(map, start_position, goal_position)
    % Initially we think map is just free space
    % We assume that we know the size of the map space and its boundaries
    [map_rows, map_columns] = size(map);
    created_map = zeros(map_rows,map_columns);
    % Our current position in the begining is the start position
    current_position = start_position;
    % Temporary value to just start the while loop
    obstacle_position = 0; 
    path = [];
    push = 0;
    pop = 0;
    
    % NaN is only returned when goal has been reached
    while ~isnan(obstacle_position)
        % Itterativly run the modified A*, each time starting from current
        % position (in the beginning its start position), always with goal
        % goal_position, reschedule each time new information is gained
        % and itterativly update map with the new information we gained
        [temp_path, obstacle_position, new_position, temp_push, temp_pop] = modified_A_star(map, created_map, current_position, goal_position);
        % Set current_position to the new position we have moved to and are
        % gonna start planing from next itteration
        current_position = new_position;
        % Unless we returned because we found goal, then we returned because 
        % we found a new obstacle and we need to update the map regarding it
        if ~isnan(obstacle_position)
            created_map(obstacle_position(1), obstacle_position(2)) = inf;
        end
        % Path is empty if A* can't find a path to goal
        if isempty(temp_path)
            break;
        else
            % Combine path from all itterations to gain path from start to
            % goal
            path = [path; temp_path];
        end
        push = push + temp_push;
        pop = pop + temp_pop;
    end
end