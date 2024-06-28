function [g, cen_x, cen_y] = gOfX(l1, bAng1, a1, bAng2, l2, l3, l4, w2, w4, w3, w6, l5, l6, offset_w2, offset_w3)

    % taking 400 lineraly spaced points in between 0 and 360 degress
    theta_2 = linspace(0, 360, 400);
    
    theta_2 = theta_2 - bAng1;
    a = sind(theta_2);
    b = cosd(theta_2) - l1 / l2;
    c = (l1^2 + l2^2 +l3^2 - l4^2) / (2*l2*l3) - l1*cosd(theta_2) / l3;
    
    theta_3w2 = 2*atand((a-sqrt(a.^2+b.^2-c.^2)) ./ (b+c)) - offset_w2;
    
    pos_intermX = l2*cosd(theta_2 + bAng1) + w2*cosd(theta_3w2 + bAng1);
    pos_intermY = l2*sind(theta_2 + bAng1) + w2*sind(theta_3w2 + bAng1);
    l_interm = sqrt(pos_intermY.^2 + pos_intermX.^2);
    theta_interm = atand(pos_intermY ./ pos_intermX) - bAng2;
    
    a_ = sind(theta_interm);
    b_ = cosd(theta_interm) - a1*l1 ./ l_interm;
    c_ = ((a1*l1)^2 + l_interm.^2 +l5^2 - l6^2) ./ (2*l_interm*l5) - a1*l1*cosd(theta_interm) / l5;
    
    theta_5w3 = 2*atand((a_-sqrt(a_.^2+b_.^2-c_.^2)) ./ (b_+c_)) - offset_w3;
    
    pos_x = pos_intermX + w3*cosd(theta_5w3 + bAng2);
    pos_y = pos_intermY + w3*sind(theta_5w3 + bAng2);
    g = [pos_x; pos_y];
    
    % calculating the center of mass of the generated curve
    cen_x = sum(pos_x) / 400;
    cen_y = sum(pos_y) / 400;
end