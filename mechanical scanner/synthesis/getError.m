function error = getError(param)
    [g, cen_x, cen_y] = gOfX(param(1), param(2), param(3), param(4), param(5), param(6), param(7), param(8), param(9), param(10), param(11), param(12), param(13), param(14), param(15));
    
    % taking 400 lineraly spaced points in between 0 and 360 degress
    theta = linspace(0, 360, 400);

    % desired curve(ellipse) points calculated using the obtained centre of 
    % mass point in the gOfX function 
    x_act = real(cen_x) + 2 * cosd(theta);
    y_act = real(cen_y) + 5.5 * sind(theta);

    % contructing a matrix of 400 desired equation points
    g_act = [x_act; y_act];

    % calculating the maximum root mean squared error between the generated
    % and desired curves for the 400 points
    error = max(rmse(g, g_act, 2));
end