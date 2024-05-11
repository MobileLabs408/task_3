%==========================================================================
% Author: Carl Larsson
% Description: Comparison between two keys to see if the first is less than
% or equal to second
% Date: 2024-05-11

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function first_is_less_or_eq = key_less_or_eq(first_key, second_key)
    
    % Key comparison according to:
    % k <= k' if
    % k1 < k'1
    % or
    % k1 = k'1 && k2 <= k'2
    if (first_key(1) < second_key(1)) || ((first_key(1) == second_key(1)) && (first_key(2) <= second_key(2)))
        first_is_less_or_eq = true;
    else
        first_is_less_or_eq = false;
    end

end