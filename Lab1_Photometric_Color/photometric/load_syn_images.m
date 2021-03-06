function [ image_stack, scriptV, V ] = load_syn_images( image_dir, channel )
%LOAD_SYN_IMAGES read from directory image_dir all files with extension png
%   image_dir: path to the image directory
%   nchannel: the image channel to be loaded, default = 1
%
%   image_stack: all images stacked along the 3rd channel
%   scriptV: light directions

files = dir(fullfile(image_dir, '*.png'));
nfiles = length(files);

if nargin == 1
    channel = 1;
end

image_stack = 0;
V = 0;
Z = 0.5;

for i = 1:nfiles
    
    % for 1 channel greyscale
    if channel == 1
        % read input image
        im = imread(fullfile(image_dir, files(i).name));
        im = im(:, :, channel);
        
        % stack at third dimension
        if image_stack == 0
            [h, w] = size(im);
            fprintf('Image size (HxW): %dx%d\n', h, w);
            image_stack = zeros(h, w, nfiles, 'uint8');
            V = zeros(nfiles, 3, 'double');
        end

        image_stack(:, :, i) = im;
    end
    
    % for RGB images image_stack is h x w x 3 x 5
    if channel == 3
        % read input image
        im = imread(fullfile(image_dir, files(i).name));
        im = im(:, :, :);

        % stack at fourth dimension
        if image_stack == 0
            [h, w, c] = size(im); % height, width, channels
            fprintf('Image size (HxW): %dx%dx%d\n', h, w, c);
            image_stack = zeros(h, w, c, nfiles, 'uint8');
            V = zeros(nfiles, 3, 'double');
        end

        image_stack(:, :, :, i) = im;
    end
    
    % read light direction from image name
    name = files(i).name(8:end);
    m = strfind(name,'_')-1;
    X = str2double(name(1:m));
    n = strfind(name,'.png')-1;
    Y = str2double(name(m+2:n));
    V(i, :) = [-X, Y, Z];
end

% normalization
min_val = double(min(image_stack(:)));
max_val = double(max(image_stack(:)));
image_stack = (double(image_stack) - min_val) / (max_val - min_val);

normV = sqrt(sum(V.^2, 2));
scriptV = bsxfun(@rdivide, V, normV);
%disp(V);
end

