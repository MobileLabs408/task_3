%==========================================================================
% Author: Carl Larsson
% Description: Update vertex (node)
% Date: 2024-05-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [U, push, pop] = update_vertex(U, current_position, position, g, rhs, k_m)
    
    % Used for keeping track of the number of pushes and pops (local)
    push = 0;
    pop = 0;
    
    % Create node
    k = calculate_key(current_position, position, g, rhs, k_m);
    node = struct('position', position,'k1', k(1), 'k2', k(2));

    % Wrong g value and node is in U, update value in U
    if((g(node.position(2), node.position(1)) ~= rhs(node.position(2), node.position(1))) && (any(arrayfun(@(x) isequal(x.position, node.position), U))))
        % Update by replacing
        U(find(arrayfun(@(x) isequal(x.position, node.position), U), 1)) = node;

    % Wrong g value but node is not in U, insert node
    elseif((g(node.position(2), node.position(1)) ~= rhs(node.position(2), node.position(1))) && (~any(arrayfun(@(x) isequal(x.position, node.position), U))))
        % Push node
        U = [U; node];
        push = push + 1;

    % Correct g value and node is in U, remove node from U
    elseif(g(node.position(2), node.position(1)) == rhs(node.position(2), node.position(1)) && (any(arrayfun(@(x) isequal(x.position, node.position), U))))
        % remove node
        U(find(arrayfun(@(x) isequal(x.position, node.position), U), 1)) = [];
        pop = pop + 1;
    end

end