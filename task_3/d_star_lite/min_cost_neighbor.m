%==========================================================================
% Author: Carl Larsson
% Description: Finds min and argmin of c(s,s') + g(s'), aka finds neighbor
% with lowest cost. Note that in this implementation, h = c
% Date: 2024-05-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [min_idx, min_val] = min_cost_neighbor(neighbors, position)

    min_idx = -1;
    min_val = inf;
    % Check all neighbors, find the one which minimizes cost
    for s_prim = 1:length(neighbors)
        % Skip if neighbor is outside map boundaries or an obstacle
        if any(neighbors(s_prim,:) < 1) || (neighbors(s_prim,1) > map_rows) || (neighbors(s_prim,2) > map_columns) || (constructed_map(neighbors(s_prim,1), neighbors(s_prim,2)) == inf)
            continue;
        end

        % Cost
        val = D_star_heuristic(position, neighbors(s_prim, :)) + g(neighbors(s_prim,:));
        % If we find one with even lower cost
        if(val < min_val)
            % Update value and index
            min_idx = s_prim;
            min_val = val;
        end
    end

end