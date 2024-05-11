%==========================================================================
% Author: Carl Larsson
% Description: Computes shortest path
% Date: 2024-05-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function  shortest_path(U, start_position, g, rhs, k_m)

    % Find Top key and Top node
    [min_idx, min_k1, min_k2] = find_min_idx(U);
    top_key = [min_k1, min_k2];
    % Get start key
    start_key = calculate_key(start_position, start_position, g, rhs, k_m);
    
    % Continue until start node is locally consistent
    while(key_less(top_key, start_key) || (rhs(start_position(1), start_position(2)) > g(start_position(1), start_position(2))))
        % Pop top node
        node = U(min_idx);
        pop = pop + 1;
        % Old key
        k_old = top_key;
        % Key that it should have had
        k_new = calculate_key(start_position, node.position, g, rhs, k_m);
        
        % 
        if(k_old < k_new)
            % Update node value in U
            updated_node = struct('position', node.position,'k1', k_new(1), 'k2', k_new(2));
            U(min_idx) = updated_node;
        
        % 
        elseif(g(node.position) > rhs(node.position))
            % Remove node from U
            g(node.position) = rhs(node.position);
            U(min_idx) = [];

            % Update all predecessors (neighbors)
            preds = get_neighboring_nodes(node.position);
            for s = 1:size(preds, 1)
                % Do not update goal node
                if(preds(s,:) ~= goal_position)
                    %
                    rhs(preds(s,:)) = min(rhs(preds(s,:)), D_star_heuristic(preds(s,:), node.position) + g(node.position));
                    [U,push] = update_vertex(U,start_position,preds(s,:),g,rhs,k_m,push);
                end
            end

        %
        else
            g_old = g(node.position);
            g(node.position) = inf;

            % Update all predecessors aswell as current
            preds_u = get_neighboring_nodes(node.position);
            preds_u = [preds_u; node.position];
            for s = 1:size(preds, 1)
                if(rhs(preds_u(s,:)) == D_star_heuristic(preds(s,:), node.position) + g_old)
                    % Unless goal node
                    if(preds(s,:) ~= goal_position)
                        % Find successors to s
                        succs = get_neighboring_nodes(preds(s,:));
                        min_val = inf;
                        min_idx = -1;
                        for s_prim = 1:length(succs)
                            val = D_star_heuristic(preds(s,:), succs(s_prim, :)) + g(succs(s_prim,:));
                            if(val < min_val)
                                min_val = val;
                                min_idx = s_prim;
                            end
                        end
                        rhs(preds(s,:)) = min_val;
                    end

                    [U, push] = update_vertex(U, start_position, preds(s,:), g, rhs, k_m, push);
                end

            end

        end

    end

end