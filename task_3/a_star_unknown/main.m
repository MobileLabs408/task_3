%==========================================================================
% Author: Carl Larsson
% Description: Main file for A* for UNKNOWN environments
% Date: 2024-04-25

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

%--------------------------------------------------------------------------
%% Clean up
%--------------------------------------------------------------------------

close all
clear
clc

%--------------------------------------------------------------------------
%% Load data
%--------------------------------------------------------------------------

maze = load("../mazes/Maze3.mat");

%--------------------------------------------------------------------------
%% Path planing
%--------------------------------------------------------------------------

obstacle_position = 0;
[map_rows, map_columns] = size(maze.Maze.map);
% Initially we think map is just free space
created_map = zeros(map_rows,map_columns);
path = [];
push = 0;
pop = 0;
% Our current position in the begining is the start position
current_position = maze.Maze.start;

tic;
% NaN is only returned when goal has been reached
while ~isnan(obstacle_position)
    [temp_path, obstacle_position, new_position, temp_push, temp_pop] = A_star_unknown(maze.Maze.map, created_map, current_position, maze.Maze.goal);
    % Set current_position to the new position we have moved to and are
    % gonna start planing from next itteration
    current_position = new_position;
    % Unless we returned because we found goal, and thus returned because 
    % we found a new obstacle that we need to update the map with, then
    % update map with new obstacle information
    if ~isnan(obstacle_position)
        created_map(obstacle_position(1), obstacle_position(2)) = inf;
    end
    % Path is empty if A* can't find a path to goal
    if isempty(temp_path)
        break;
    else
        % Combine path from all individual runs (since we return each time we need to reschedule)
        path = [path; temp_path];
    end
    push = push + temp_push;
    pop = pop + temp_pop;
end
execution_time = toc;

%--------------------------------------------------------------------------
%% Plot resulting path
%--------------------------------------------------------------------------

plot_map_and_path(created_map, maze.Maze.start, maze.Maze.goal, path);

%--------------------------------------------------------------------------
%% Print execution time, pushes and pops
%--------------------------------------------------------------------------

disp(['Execution time: ', num2str(execution_time), ' (s)'])
disp(['Number of pushes to open list: ', num2str(push)])
disp(['Number of pops to open list: ', num2str(pop)])

%--------------------------------------------------------------------------