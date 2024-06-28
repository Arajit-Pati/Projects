function back_projection(sinogram, theta)
    % Back Projection of Sinogram
    
    % Define parameters
    num_ang = length(theta); % Number of projection angles
    num_dect = size(sinogram, 1); % Number of detectors
    imageSize = floor(num_dect / sqrt(2)); % Size of the reconstructed image
    iwidth = imageSize / 2;

    % Initialize the reconstructed image
    reconstructedImage = zeros(imageSize);
    
    [posX, posY] = meshgrid((1:imageSize) - iwidth);
    % Back projection
    for t = 1:num_ang
        projection = sinogram(:, t);
        pos = posX * sind(theta(t)) + posY * cosd(theta(t)) + floor(num_dect/2);
        % Interpolate projection to match image size
        interpolatedProjection = interp1(1:num_dect, projection, pos, "linear");
        % Add the interpolated projection to the reconstructed image
        reconstructedImage = reconstructedImage + interpolatedProjection';
    end
    
    % Display the results
    figure;
    imshow(flip(reconstructedImage, 1), []);
    title('Back Projected Image');
end
