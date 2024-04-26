%==========================================================================
% Author: Carl Larsson
% Description: Performs A* in known environment
% Date: 2024-04-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function path = A_star(map, start_position, goal_position)
    % Define movement cost
    vertical_horizontal_cost = 1;
    diagonal_cost = sqrt(2);

    % Start node
    % g is cost-so-far, h is heuristic, and f is estimated-total-cost which is f = g+h
    start_node = struct('position', start_position, 'g', 0, 'f', A_star_heuristic(start_position, goal_position), 'parent', []);

    % Initialize open and closed lists
    % Nodes that are yet to be explored (expanded)
    open_list = [start_node];
    % Nodes we have expanded
    closed_list = [];

    % Get dimensions of map
    [map_rows, map_columns] = size(map);

    % A*
    % Continue while we have unexplored nodes
    while ~isempty(open_list)
        % Find unexplored (unexpanded) node with lowest estimate total cost (f)
        [~, current_node_idx] = min([open_list.f]);
        current_node = open_list(current_node_idx);

        % Move current node to closed list
        closed_list = [closed_list; current_node.position];

        % Check if goal is reached
        if isequal(current_node.position, goal_position)
            % Reconstruct path from start to goal
            temp_path = [];
            % Continously step back into parent node, starting at goal node
            while ~isempty(current_node)
                % Inserting in this order will result with start at top and
                % goal at bottom
                temp_path = [current_node.position; temp_path];
                current_node = current_node.parent;
            end
            path = temp_path;
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

            % Skip if neighbor is outside map boundaries or an obstacle
            if any(neighbor_pos < 1) || (neighbor_pos(1) > map_rows) || (neighbor_pos(2) > map_columns) || (map(neighbor_pos(1), neighbor_pos(2)) == inf)
                continue;
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
    error('No path found');

end