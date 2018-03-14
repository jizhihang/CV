% Demo script that executes all code and generates the required images for
% Section 2 - Image Stitching.

%% Load images and find best transformation.
image1 = rgb2gray(im2double(imread('left.jpg')));
image2 = rgb2gray(im2double(imread('right.jpg')));

matchingKeypoints = keypoint_matching(image1, image2);

N = 9
P = 3
verbose_mode = 0
[transform_params, transform_matrix] = ransac(image2, image1, N, P, verbose_mode)

%% Calculate coordinates of corners.
[c, r] = size(image2)

% Corner coordinates as homogenous vectors, transposed to get column
% vectors.
corners = [1,1,1; 1,c,1; r,c,1; r,1,1]'
corners_t = round(transform_matrix * corners)
corners_t = corners_t(1:2, :)

hor_shift = min(corners_t(1,:));
ver_shift = min(corners_t(2,:));

% Find most extreme dimensions
left = min(hor_shift, 1))
right = max(max(corners_t(1,:), size(image1, 2)))
top = min(min(ver_shift, 1))
bottom = max(max(corners_t(2,:), size(image1, 1)))

% Initialize stiched image with the correct dimensions.
stitched = zeros(abs(top) + abs(bottom) - 1, abs(left) + abs(right) - 1);

% Transform the second image
im2_t = transform_image(image2, transform_params);

% Translate to the right spot
% im2_t = imtranslate(im2_t, [212, 38], 'OutputView','full');
figure()
imshow(image1)
figure()
imshow(im2_t)
figure()
imshow(stitched)


