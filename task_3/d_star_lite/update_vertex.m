%==========================================================================
% Author: Carl Larsson
% Description: Update vertex (node)
% Date: 2024-05-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [U, push] = update_vertex(U, start_position, position, g, rhs, k_m, push)
    
    k = calculate_key(start_position, position, g, rhs, k_m);
    % Node
    node = struct('position', position,'k1', k(1), 'k2', k(2));

    % If node is in U but has wrong g value, update value in U
    if(g(node.position) ~= rhs(node.position)) && (any(arrayfun(@(x) isequal(x.position, node.position), U)))
        U(find(arrayfun(@(x) isequal(x.position, node.position), U), 1)) = node;

    % Wrong g value but node is not int U, insert it
    elseif(g(node.position) ~= rhs(node.position)) && (~any(arrayfun(@(x) isequal(x.position, node.position), U)))
        U = [U; node];
        push = push + 1;

    % Correct g value, remove node from U
    elseif(g(node.position) == rhs(node.position))
        U(find(arrayfun(@(x) isequal(x.position, node.position), U), 1)) = [];
    end

end