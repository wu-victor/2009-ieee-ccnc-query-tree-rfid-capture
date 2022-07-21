% Generate n points uniformly distributed in a disk.
function [x_vals, y_vals, dist_vals] = generate_points(radius, n)

done = false;
index = 0;
while (~done)
    x = 2*radius * rand(1,1) - radius;
    y = 2*radius * rand(1,1) - radius;
    if ( sqrt(x^2 + y^2) <= radius )
        index = index + 1;
        x_vals(index,1) = x;
        y_vals(index,1) = y;
        dist_vals(index,1) = sqrt(x^2 + y^2);
    end
    if (index == n)
        done = true;
    end
end

% % Make a circle.
% theta = (0:0.01:2*pi)';
% circle_x = radius * cos(theta);
% circle_y = radius * sin(theta);
% 
% plot(x_vals,y_vals,'bo', circle_x, circle_y, 'go')