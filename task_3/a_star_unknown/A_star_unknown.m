%==========================================================================
% Author: Carl Larsson
% Description: Modified A* used for UNKNOWN environments
% Date: 2024-04-25

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [path, obstacle_position, current_position, push, pop] = A_star_unknown(map, created_map, start_position, goal_position)
    % used keeping track of the number of pushes and pops 
    push = 0;
    pop = 0;

    % Define movement cost
    vertical_horizontal_cost = 1;
    diagonal_cost = sqrt(2);

    % Start node
    % g is cost-so-far, h is heuristic, and f is estimated-total-cost which is f = g+h
    start_node = struct('position', start_position, 'g', 0, 'f', A_star_heuristic(start_position, goal_position), 'parent', []);

    % Initialize open and closed lists
    % Nodes that are yet to be explored (expanded)
    open_list = [start_node];
    % Push start node
    push = push + 1;
    % Nodes we have expanded
    closed_list = [];

    % Get dimensions of map
    [map_rows, map_columns] = size(map);

    % A*
    % Continue while we have unexplored nodes
    while ~isempty(open_list)
        % Find unexplored (unexpanded) node with lowest estimate total cost (f)
        [~, current_node_idx] = min([open_list.f]);
        % Pop
        current_node = open_list(current_node_idx);
        current_position = current_node.position;
        pop = pop + 1;

        % Move current node to closed list
        closed_list = [closed_list; current_node.position];

        % Check if goal is reached
        if isequal(current_node.position, goal_position)
            % If we have reached goal, we still need to set value of
            % obstacle_position, so we set it to NaN so it can easily be
            % checked
            obstacle_position = NaN;
            path = reconstruct_path(current_node);
            return;
        end
        
        % Get neighboring nodes of current node
        neighbors = get_neighboring_nodes(current_node.position);

        % Check all neighboring nodes
        for i = 1:size(neighbors, 1)
            neighbor_pos = neighbors(i, :);
            
            % Skip if neighbor is already in closed list
            if any(ismember(closed_list, neighbor_pos, 'rows'))
                continue;
            end

            % If we encounter edge of maze or obstacles
            if any(neighbor_pos < 1) || (neighbor_pos(1) > map_rows) || (neighbor_pos(2) > map_columns) || (map(neighbor_pos(1), neighbor_pos(2)) == inf)
                % We are aware of the obstacle according to our created map, 
                % so we continue as usual by skipping it
                if (created_map(neighbor_pos(1), neighbor_pos(2)) == inf)
                    continue;
                % If neighbor is outside map boundaries or an obstacle
                % which we are unaware of (haven't seen before) and is not
                % on our map
                % return so map can be updated with this new information
                else
                    % Mark the neighbor as an obstacle and return it so that
                    % map can be updated with this new information
                    obstacle_position = neighbor_pos;
                    % Return path so far
                    path = reconstruct_path(current_node);
                    return;
                end
            end
            
            % Determine movement cost
            % If neighbor is change in both x and y, then we have moved diagonally
            if abs(neighbor_pos(1) - current_node.position(1)) == 1 && abs(neighbor_pos(2) - current_node.position(2)) == 1
                % g is cost-so-far
                neighbor_g = current_node.g + diagonal_cost;
            else
                % g is cost-so-far
                neighbor_g = current_node.g + vertical_horizontal_cost;
            end
            
            % Estimated total cost f = g + h
            neighbor_f = neighbor_g + A_star_heuristic(neighbor_pos, goal_position);
            
            % Create neighbor node
            neighbor_node = struct('position', neighbor_pos, 'g', neighbor_g, 'f', neighbor_f, 'parent', current_node);

            % If neighbor is not in open list, add it
            if ~any(arrayfun(@(x) isequal(x, neighbor_node), open_list))
                open_list = [open_list; neighbor_node];
                % Push
                push = push + 1;
            % Else if it has lower f value, we have found a better path so
            % we update
            elseif any(arrayfun(@(x) isequal(x, neighbor_node), open_list)) && open_list(find(arrayfun(@(x) isequal(x, neighbor_node), open_list), 1)).f > neighbor_node.f
                open_list(find(arrayfun(@(x) isequal(x, neighbor_node), open_list), 1)) = neighbor_node;
            end
                
            % Add neighbor to closed list
            closed_list = [closed_list; neighbor_pos];

        end

        % Remove current node from open list
        open_list(current_node_idx) = [];

    end
    
    % If no path is found
    disp("No path found.")
    path = [];

end