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

    % Get map dimensions
    [map_rows, map_columns] = size(map);

    % Created map (robots internal map)
    % Known
    created_map = map;
    % Unknown
    %created_map = zeros(map_rows,map_columns);

    % 
    last_change_position = start_position;
    current_position = start_position;
    path = [];
    path = [path;current_position];

    % Initialize D* lite
    [U, g, rhs, k_m] = initialize_D_star(created_map, start_position, goal_position);

    % Update and compute shortest path
    [U, push, pop] = shortest_path(U, start_position, g, rhs, k_m, push, pop);

    %% Main loop, continue until goal is reached
    % Note that this concerns movement, not search, movement is from start
    % to goal, search is from goal to start, see shortest_path
    while(current_position ~= goal_position)
        % There is no known path to goal
        if(rhs(current_position) == inf)
            path = [];
            return
        end

        succs = get_neighboring_nodes(current_position);
        % Move to neighbor with lowest cost
        [min_idx, min_val] = min_cost_neighbor(succs, current_position);
        current_position = succs(min_idx,:);
        path = [path;current_position];

        % Scan graph for changes
        neighbors = get_neighboring_nodes(current_position);
        % Check all neighbors if they are undiscovered walls, if they are
        % then update created map with new info
        for i = 1:size(neighbors, 1)
            if(created_map(neighbors(i,:)) ~= map(neighbors(i,:)))
                created_map(neighbors(i,:)) = inf;
                changes = true;
                changed_nodes = [changed_nodes; neighbors(i,:)];
            end
        end

        % If graph had new changes
        if(changes == true)
            changes = false;
            % Update heuristic estimate distance from start to goal
            k_m = k_m + D_star_heuristic(last_change_position, current_position);
            last_change_position = current_position;

            % Update all changed nodes (and their neighbors)
            for s = 1:size(changed_nodes, 1)
                % Changed node and neighbors
                changed_node_and_neighbors = get_neighboring_nodes(changed_nodes(s,:));
                changed_node_and_neighbors = [changed_node_and_neighbors; changed_nodes(s,:)];
                for s_prim = 1:size(changed_node_and_neighbors,1)
                    % Update node
                    [U, push] = update_vertex(U, start_position, changed_node_and_neighbors(s_prim,:), g, rhs, k_m, push);
                end
            end
            % Empty list after all changed nodes have been updated
            changed_nodes = [];

            % Update and compute shortest path
            [U, push, pop] = shortest_path(U, start_position, g, rhs, k_m, push, pop);
        end
    end

end