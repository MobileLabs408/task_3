%==========================================================================
% Author: Carl Larsson
% Description: D* lite heuristic, is also used for cost, thus in this
% implementation, h = c
% Date: 2024-04-30

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function heuristic = D_star_heuristic(source_position, target_position)

    % Euclidean distance
    heuristic = norm(source_position - target_position);
    
end