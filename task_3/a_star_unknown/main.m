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

maze = load("../mazes/Maze.mat");

%--------------------------------------------------------------------------
%% Path planing
%--------------------------------------------------------------------------

tic;
[path, created_map, push, pop] = A_star_unknown(maze.Maze.map, maze.Maze.start, maze.Maze.goal);
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