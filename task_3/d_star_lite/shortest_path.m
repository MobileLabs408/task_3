%==========================================================================
% Author: Carl Larsson
% Description: Computes shortest path
% Date: 2024-05-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [U, push, pop] = shortest_path(U, start_position, goal_position, g, rhs, k_m, created_map, push, pop)
    %% Init
    % Get map dimensions
    [map_rows, map_columns] = size(created_map);

    % Find top key and top node (lowest value key/priority)
    [min_idx, min_k1, min_k2] = find_min_idx(U);
    top_key = [min_k1, min_k2];
    % Get start key
    start_key = calculate_key(start_position, start_position, g, rhs, k_m);
    
    %% Continue until start node is locally consistent
    while(key_less(top_key, start_key) || (rhs(start_position(1), start_position(2)) > g(start_position(1), start_position(2))))
        % Pop top node (lowest value key)
        node = U(min_idx);
        pop = pop + 1;

        % Old key
        k_old = top_key;
        % Key that it should have had
        k_new = calculate_key(start_position, node.position, g, rhs, k_m);
        
        %% Only update nodes with improved cost estimate
        if(key_less(k_old, k_new))
            % Update node value in U by replacing
            updated_node = struct('position', node.position,'k1', k_new(1), 'k2', k_new(2));
            U(min_idx) = updated_node;
        
        %% Update if a shorter path might have been found
        elseif(g(node.position(1), node.position(2)) > rhs(node.position(1), node.position(2)))
            % Fix g value
            g(node.position(1), node.position(2)) = rhs(node.position(1), node.position(2));
            % Remove node from U
            U(min_idx) = [];

            % Update all predecessors (neighbors)
            preds = get_neighboring_nodes(node.position);
            for s = 1:size(preds, 1)
                % Skip if neighbor is outside map boundaries or an obstacle
                if any(preds(s,:) < 1) || (preds(s,1) > map_rows) || (preds(s,2) > map_columns) || (created_map(preds(s,1), preds(s,2)) == inf)
                    continue;
                end

                % Do not update goal node
                if(preds(s,1) ~= goal_position(1) || preds(s,2) ~= goal_position(2))
                    % Update rhs if better path has been found
                    % note that in this implementation c = h
                    rhs(preds(s,1), preds(s,2)) = min(rhs(preds(s,1), preds(s,2)), D_star_heuristic(preds(s,:), node.position) + g(node.position(1), node.position(2)));
                end

                % Update vertex
                [U, push] = update_vertex(U, start_position, preds(s,:), g, rhs, k_m, push);
            end

        %% Update and check to ensure optimality
        else
            % Set cost to reach this node to inf to treat it as if we do
            % not know the cost of reaching this node and thus it requires
            % to be updated
            g_old = g(node.position(1), node.position(2));
            g(node.position(1), node.position(2)) = inf;

            % Update all predecessors aswell as current (u)
            preds_u = get_neighboring_nodes(node.position);
            preds_u = [preds_u; node.position];
            for s = 1:size(preds_u, 1)
                % Skip if neighbor is outside map boundaries or an obstacle
                if any(preds_u(s,:) < 1) || (preds_u(s,1) > map_rows) || (preds_u(s,2) > map_columns) || (created_map(preds_u(s,1), preds_u(s,2)) == inf)
                    continue;
                end

                % If rhs is not consistent?
                % Note that in this implementation, c = h
                if(rhs(preds_u(s,1), preds_u(s,2)) == D_star_heuristic(preds_u(s,:), node.position) + g_old)
                    % Unless goal node
                    if(preds_u(s,1) ~= goal_position(1) || preds_u(s,2) ~= goal_position(2))
                        % Find successors to s
                        succs = get_neighboring_nodes(preds_u(s,:));
                        
                        % Find the one which minimizes cost
                        [min_idx, min_val] = min_cost_neighbor(succs, preds_u(s,:));

                        % Update rhs value with min cost
                        rhs(preds_u(s,1), preds_u(s,2)) = min_val;                        
                    end

                    % Update vertex
                    [U, push] = update_vertex(U, start_position, preds_u(s,:), g, rhs, k_m, push);
                end
            end
        end

        %% Recompute values for next while loop

        % Find top key and top node (lowest value key/priority)
        [min_idx, min_k1, min_k2] = find_min_idx(U);
        top_key = [min_k1, min_k2];
        % Get start key
        start_key = calculate_key(start_position, start_position, g, rhs, k_m);
    end
end