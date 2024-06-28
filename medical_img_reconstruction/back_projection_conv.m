function back_projection_conv(sinogram, theta, filter)
    % Back Projection of Sinogram
    
    % Define parameters
    num_ang = length(theta); % Number of projection angles
    num_dect = size(sinogram, 1); % Number of detectors
    dect_by2 = floor(num_dect / 2);
    imageSize = floor(num_dect / sqrt(2)); % Size of the reconstructed image
    iwidth = imageSize / 2;

    % Initialize the reconstructed image
    reconstructedImage = zeros(imageSize);
    
    [posX, posY] = meshgrid((1:imageSize) - iwidth);

    % Compute the Ram-Lak filter
    gx = [0:dect_by2, dect_by2 - 1:-1:1];
    if mod(num_dect, 2) ~= 0
        gx = [gx, 0];
    end
    
    ramlak = 2 * gx / num_dect;
    
    switch filter
        case 'ramlak' % Use Ramlak filter
            H = ramlak;
        case 'hamming' % Use Hamming filter
            hamming = 0.54 - 0.46 * cos(2 * pi * (0:num_dect-1) / num_dect);
            H = [hamming(dect_by2:num_dect), hamming(1:dect_by2-1)] .* ramlak;
        otherwise
            fprintf('Unavailable filter.');
            exit;
    end
    
    % Compute inverse Fourier transformation of filter
    c_filt = real(ifftshift(ifft(H)));
    sg_conv = convn(sinogram, c_filt', 'same');

    % Back projection
    for t = 1:num_ang
        projection = sg_conv(:, t);
        pos = posX * sind(theta(t)) + posY * cosd(theta(t)) + dect_by2;
        % Interpolate projection to match image size
        interpolatedProjection = interp1(1:num_dect, projection, pos, 'linear');
        % Add the interpolated projection to the reconstructed image
        reconstructedImage = reconstructedImage + interpolatedProjection';
    end

    % Display the results
    figure;
    imshow(flip(reconstructedImage, 1), []);
    title('Back Projected Image');
end
