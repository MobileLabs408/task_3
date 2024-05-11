%==========================================================================
% Author: Carl Larsson
% Description: Find smallest key in queue, return value and index
% Date: 2024-05-02

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function [min_idx, min_k1, min_k2] = find_min_idx(U)

    % k1 is total cost to start
    min_k1 = Inf;
    % k2 is cost of reaching this node from begining node
    min_k2 = Inf;
    min_idx = -1;

    % Key comparison according to:
    % k <= k' if
    % k1 < k'1
    % OR
    % k1 = k'1 AND k2 <= k'2
    for idx = 1:length(U)
        node = U(idx);
        if key_less_or_eq([node.k1, node.k2], [min_k1, min_k2])
            min_k1 = node.k1;
            min_k2 = node.k2;
            min_idx = idx;
        end
    end

end