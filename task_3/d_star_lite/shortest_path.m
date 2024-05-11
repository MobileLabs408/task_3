%==========================================================================
% Author: Carl Larsson
% Description: Computes shortest path
% Date: 2024-05-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function  shortest_path(U, start_position, g, rhs, k_m)

    [min_idx, min_k1, min_k2] = find_min_idx(U);
    top_key = [min_k1, min_k2];
    start_key = calculate_key(start_position, start_position, g, rhs, k_m);
    while(key_less(top_key, start_key) || (rhs(start_position(1), start_position(2)) > g(start_position(1), start_position(2))))
       node = U(min_idx); 
       k_old = top_key;
       k_new = calculate_key(start_position, node.position, g, rhs, k_m);
       if


    end

end