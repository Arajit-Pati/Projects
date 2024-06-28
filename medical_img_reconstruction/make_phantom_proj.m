function [img, R, theta] = make_phantom_proj(pix)
    img = phantom(pix);
    
    step_theta = input('Enter step incremental theta: ');
    theta = 0: step_theta: 180 - step_theta;
    
    [R, idx] = radon(img, theta);
end
