function matchpoints = findMatches(im1, im2)
    % Convert the images to single format
    im1 = im2single(im1);
    im2 = im2single(im2);
     
    % Find matches
    [fa, da] = vl_sift(im1);
    [fb, db] = vl_sift(im2);
    [matches, ~] = vl_ubcmatch(da, db);
     
    % Return the matching points
    xy = [fa(1,matches(1,:))', fa(2,matches(1,:))'];
    XY = [fb(1,matches(2,:))', fb(2,matches(2,:))'];  
    matchpoints = [xy, XY];
end