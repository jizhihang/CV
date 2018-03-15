% Demo script that executes all code and generates the required images for
% Section 2 - Image Stitching.

%% Load images and find best transformation.
image1 = rgb2gray(im2double(imread('left.jpg')));
image2 = rgb2gray(im2double(imread('right.jpg')));

matchingKeypoints = keypoint_matching(image1, image2);

N = 9
P = 3
verbose_mode = 0
[transform_params, transform_matrix, inlier_matches] = ransac(image2, image1, N, P, verbose_mode)
% inlier_matches holds the coordinates of the matches that are considered
% inliers under the transformation by <transform_matrix>.

%% Calculate coordinates of corners.
[r, c] = size(image2);

% Corner coordinates as homogenous vectors, transposed to get column
% vectors.
corners = [1,1,1; 1,c,1; r,c,1; r,1,1]';
corners_t = round(transform_matrix * corners);
% Remove unit row
corners_t = corners_t(1:2, :)

% corners_t(1,:) holds the row values for the four corners. The smallest of
% those is the shift in row, and thus horizontal?
hor_shift = min(corners_t(1,:));
% corners_t(1,:) holds the row values for the four corners. The smallest of
% those is the shift in row, and thus horizontal?
ver_shift = min(corners_t(2,:))

% Find most extreme dimensions
% left = min(min(hor_shift, 1))
% right = max(max(corners_t(1,:), size(image1, 2)))
% top = min(min(ver_shift, 1))
% bottom = max(max(corners_t(2,:), size(image1, 1)))

% Transform the second image
im2_t = transform_image(image2, transform_params);

% In order to know how to translate image2 onto image1 we need to know the
% translation of a matchpoint. To that end we first need to know what the
% matchpoint of im1 (x,y) is in the transformed image2 (so the transformed
% (u,v).


stitched = overlay_images(image1, im2_t,ver_shift+5,hor_shift);


% Translate to the right spot
% im2_t = imtranslate(im2_t, [212, 38], 'OutputView','full');
% figure()
% imshow(image1)
% figure()
% imshow(im2_t)
%figure();
imshow(stitched);


