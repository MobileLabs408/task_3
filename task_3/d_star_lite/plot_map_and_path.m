%==========================================================================
% Author: Carl Larsson
% Description: Plots map and path taken through it
% Date: 2024-04-26

% This software is licensed under the MIT License
% Refer to the LICENSE file for details
%==========================================================================

function plot_map_and_path(map, start, goal, path)

    % Necessary for plotting the way the task does
    grid=zeros(size(map,1));
    surf(grid')
    fig=gcf;
    fig.Position=[10 10 500 500];
    colormap(gray)
    view(2)
    hold on

    % Plot the walls and obstacles of the map
    for i = 1:size(map, 1)
        for j = 1:size(map, 2)
            if map(i, j) == inf
                plot(i, j, 's', 'LineWidth', 1, 'MarkerFaceColor', 'w', 'color', 'w', 'MarkerSize', 5);
            end
        end
    end

    % Plot the initial and goal position
    plot(start(1), start(2), 's', 'MarkerFaceColor', 'b', 'MarkerSize', 10, 'color', 'b');
    plot(goal(1), goal(2), 's', 'MarkerFaceColor', 'y', 'MarkerSize', 10, 'color', 'y');
    
    % Plot the path
    if ~isempty(path)
        plot(path(:, 1), path(:, 2), 'r', 'LineWidth', 2);
    end

    % Fix title and axis
    title('Map')
    axis equal
    axis([1, size(map, 1), 1, size(map, 2)]);

    hold off

end