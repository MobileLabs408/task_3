%==========================================================================
% Author: Carl Larsson
% Description: Performs D* lite algorithm
% Date: 2024-04-30

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [path, push, pop] = D_star_lite(map, start_position, goal_position)
    % Used for keeping track of the number of pushes and pops 
    push = 0;
    pop = 0;

    % Initialize D* lite
    initialize_D_star();


end