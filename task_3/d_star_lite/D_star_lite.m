%==========================================================================
% Author: Carl Larsson
% Description: Performs D* lite algorithm
% Date: 2024-04-30

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [path, push, pop, created_map] = D_star_lite(map, start_position, goal_position, dynamic_environment)
    %% Init
    % Get map dimensions
    [map_rows, map_columns] = size(map);

    % Used for keeping track of changes in map and what needs to be updated
    changed_nodes = [];
    changes = false;

    % Used for estimated heuristic distance
    last_change_position = start_position;
    % Movement goes from start position to goal position, but search is 
    % performed from goal position to start_position
    current_position = start_position;
    % Track path taken by robot
    path = [];
    path = [path; current_position];

    % Initialize D* lite
    [U, created_map, g, rhs, k_m, push, pop] = initialize_D_star(map, start_position, goal_position, dynamic_environment);

    % Update and compute shortest path
    [U, g, rhs, temp_push, temp_pop] = shortest_path(U, start_position, goal_position, g, rhs, k_m, created_map);
    push = push + temp_push;
    pop = pop + temp_pop;

    %% Main loop, continue until goal is reached
    % Note that this concerns movement, not search, movement is from start
    % to goal, search is from goal to start in D* lite, see shortest_path
    while(current_position(2) ~= goal_position(2) || current_position(1) ~= goal_position(1))
        % There is no known path to goal
        if(rhs(current_position(2), current_position(1)) == inf)
            path = [];
            disp("No path found")
            return
        end

        % Move to neighbor with lowest cost
        succs = get_neighboring_nodes(current_position);
        [min_idx, ~] = min_cost_neighbor(succs, current_position, created_map, g);
        current_position = succs(min_idx,:);
        % Add current position to path
        path = [path; current_position];

        %% Scan graph for changes
        neighbors = get_neighboring_nodes(current_position);
        % Check all neighbors if they are undiscovered walls, if they are
        % then update created map with new info
        for i = 1:size(neighbors, 1)
            % Skip if neighbor is outside map boundaries
            if any(neighbors(i,:) < 1) || (neighbors(i,2) > map_rows) || (neighbors(i,1) > map_columns)
                continue;
            end

            % Maps can only differ in the case of obstacles (inf value)
            if(created_map(neighbors(i,2), neighbors(i,1)) ~= map(neighbors(i,2), neighbors(i,1)))
                % Add new info to created map
                created_map(neighbors(i,2), neighbors(i,1)) = inf;
                % This node is untraversable by D* lite algorithm, infinite
                % cost
                rhs(neighbors(i,2), neighbors(i,1)) = inf;
                % Save nodes which have changed so surrounding (affected)
                % nodes can be updated
                changed_nodes = [changed_nodes; neighbors(i,:)];
                % Mark that a change has occured (flag)
                changes = true;
            end
        end

        %% If map had changes (new info has been obtained)
        if(changes == true)
            % Current node should also be seen as changed????
            changed_nodes = [changed_nodes; current_position];

            % Update heuristic estimate distance from start to goal
            k_m = k_m + D_star_heuristic(last_change_position, current_position);
            last_change_position = current_position;

            % Update all changed nodes (and their neighbors)
            for s = 1:size(changed_nodes, 1)
                % Changed node and neighbors
                changed_node_and_neighbors = get_neighboring_nodes(changed_nodes(s,:));
                changed_node_and_neighbors = [changed_nodes(s,:); changed_node_and_neighbors];
                for s_prim = 1:size(changed_node_and_neighbors, 1)
                    % Update node
                    [U, temp_push, temp_pop] = update_vertex(U, current_position, changed_node_and_neighbors(s_prim,:), g, rhs, k_m);
                    push = push + temp_push;
                    pop = pop + temp_pop;
                end
            end

            % Update and compute shortest path
            [U, g, rhs, temp_push, temp_pop] = shortest_path(U, current_position, goal_position, g, rhs, k_m, created_map);
            push = push + temp_push;
            pop = pop + temp_pop;

            % Empty list after all changed nodes have been updated
            changed_nodes = [];
            % Reset changes flag
            changes = false;
        end
    end

end