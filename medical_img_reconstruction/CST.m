function CST(img, sg, theta)
    N = size(sg, 1);
    num_theta = length(theta);

    f_trans = fftshift(fft2(img));
    mag_spect = abs(f_trans);

    %plot
    figure();
    subplot(1,2,1);
    imshow(log(mag_spect+1), []);
    title('2D-fft of image:');

    f_trans_sg = zeros(N, num_theta);
    for i = 1: num_theta
        f_trans_sg(:, i) = fftshift(fft(sg(:, i)));
    end

    n_img = size(img, 1);
    k_space = zeros(n_img, n_img);
    for u = 1:n_img
        for v = 1:n_img
            % Compute the radial frequency corresponding to the point (u, v)
            omega = i_tan((u - n_img/2 - 1), (v - n_img/2 - 1));
            rad = ceil(sqrt((u - n_img/2 - 1)^2 + (v - n_img/2 - 1)^2));
            if (v - n_img/2 - 1) < 0
                rad = -rad;
            end

            % Interpolate the Fourier coefficients to compute the 2D Fourier transform
            k_space(u, v) = interp1(theta, f_trans_sg(floor(N/2) - rad, :), omega, 'nearest', 'extrap');
        end
    end

    mag_spect_tnt = abs(k_space);

    subplot(1,2,2);
    imshow(log(mag_spect_tnt+1), []);
    title('central slice theorem applied');

    rec_img = real(ifftshift(ifft2(k_space')));
    figure();
    imshow(rec_img, []);
    title('reconstructed-image');
end
