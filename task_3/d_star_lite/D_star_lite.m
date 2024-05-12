%==========================================================================
% Author: Carl Larsson
% Description: Performs D* lite algorithm
% Date: 2024-04-30

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [path, push, pop] = D_star_lite(map, start_position, goal_position)
    %% Init
    % Used for keeping track of the number of pushes and pops 
    push = 0;
    pop = 0;

    % 
    s_last = start_position;
    current_position = start_position;

    % Initialize D* lite
    [U, g, rhs, k_m] = initialize_D_star(map, start_position, goal_position);

    % 
    [U, push, pop] = shortest_path(U, start_position, g, rhs, k_m, push, pop);

    %%
    while(current_position ~= goal_position)
        % There is no known path to goal
        if(rhs(current_position) == inf)
            path = [];
            return
        end


    end

end