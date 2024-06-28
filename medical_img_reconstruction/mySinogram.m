function mySinogram(P, R, theta)
    figure(1);
    imshow(P);
    title('Phantom');
    
    idx = 1:size(R, 1);
    figure(2);
    imagesc(theta, idx, R);
    colormap('hot');
    colorbar;
    xlabel('theta');
    ylabel('# dectectors');
end
