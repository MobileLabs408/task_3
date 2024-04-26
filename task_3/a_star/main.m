%==========================================================================
% Author: Carl Larsson
% Description: Main file for path planing
% Date: 2024-04-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

%--------------------------------------------------------------------------
%% Clean up

close all
clear
clc

%--------------------------------------------------------------------------
%% Load data
%--------------------------------------------------------------------------

maze = load("../Maze.mat");

%--------------------------------------------------------------------------
%% Path planing
%--------------------------------------------------------------------------

path = A_star(maze.Maze.map, maze.Maze.start, maze.Maze.goal);

%--------------------------------------------------------------------------
%% Plot resulting path
%--------------------------------------------------------------------------

plot_map_and_path(maze.Maze.map, maze.Maze.start, maze.Maze.goal, path);

%--------------------------------------------------------------------------