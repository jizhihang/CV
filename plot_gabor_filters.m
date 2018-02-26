function plot_gabor_filters()
%[gabor filter, filter_title] = createGabor( sigma, theta, lambda, psi, gamma )
% We have to visualize theta, sigma and gamma
%   - ARGUMENTS
%     sigma      Standard deviation of Gaussian envelope.
%     theta      Orientation of the Gaussian envelope. Takes arguments in
%                the range [0, pi/2).
%     lambda     The wavelength for the carriers. The central frequency 
%                (w_c) of the carrier signals.
%     psi        Phase offset for the carrier signal, sin(w_c . t + psi).
%     gamma      Controls the aspect ratio of the Gaussian envelope
i=0
for sigma= [0.1,1,10]
            i = i + 1;
            
            [gaborComplex, gaborTitle] = createGabor(sigma, 0, 2, 0, 1);
            gaborReal = gaborComplex(:,:,1);
            gaborImaginary = gaborComplex(:,:,2);
            subplot(3,6,i), imshow(gaborReal,[]);
            i = i + 1;
            title(gaborTitle)
            subplot(3,6,i), imshow(gaborImaginary, []);
            
end
for theta=[0,pi/8,pi/4]
    i = i + 1;
    [gaborComplex, gaborTitle] = createGabor(sigma, theta, 2, 0, gamma);
    gaborReal = gaborComplex(:,:,1);
    gaborImaginary = gaborComplex(:,:,2);
    subplot(3,6,i), imshow(gaborReal,[]);
    i = i + 1;
    title(gaborTitle)
    subplot(3,6,i), imshow(gaborImaginary, []);
end

for gamma=[0.5,1,2]
    i = i + 1;
    [gaborComplex, gaborTitle] = createGabor(sigma, theta, 2, 0, gamma);
    gaborReal = gaborComplex(:,:,1);
    gaborImaginary = gaborComplex(:,:,2);
    subplot(3,6,i), imshow(gaborReal,[]);
    i = i + 1;
    title(gaborTitle)
    subplot(3,6,i), imshow(gaborImaginary, []);
end