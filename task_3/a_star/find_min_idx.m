%==========================================================================
% Author: Carl Larsson
% Description: Find index for node with lowest f value, if multiple, then
% lowest h value (h = f-g)
% Date: 2024-05-02

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function min_idx = find_min_idx(open_list)
    min_f = Inf;
    min_h = Inf;
    min_idx = -1;

    for idx = 1:length(open_list)
        node = open_list(idx);
        if node.f < min_f || (node.f == min_f && (node.f - node.g) < min_h)
            min_f = node.f;
            min_h = node.f - node.g;
            min_idx = idx;
        end
    end
end