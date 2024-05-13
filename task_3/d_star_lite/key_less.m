%==========================================================================
% Author: Carl Larsson
% Description: Comparison between two keys to see if the first is less than
% the second (STRICTLY LESS!)
% Date: 2024-05-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function first_is_less = key_less(first_key, second_key)
    
    % Key comparison according to:
    % k < k' if
    % k1 < k'1
    % OR
    % k1 = k'1 AND k2 < k'2
    if (first_key(1) < second_key(1)) || ((first_key(1) == second_key(1)) && (first_key(2) < second_key(2)))
        first_is_less = true;
    else
        first_is_less = false;
    end

end