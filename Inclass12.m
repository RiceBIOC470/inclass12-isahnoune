%Inclass 12. 

% Continue with the set of images you used for inclass 11, the same time 
% point (t = 30)

I = imread('ExampleImage.tif');
imshow(I)

file1 = 'ExampleImage.tif';
reader = bfGetReader(file1);


iplane = reader.getIndex(1-1, 1-1,30-1) + 1;
iplane2 = reader.getIndex(1-1, 2-1, 30-1) + 1;
image = bfGetPlane(reader,iplane);
image2 = bfGetPlane(reader,iplane2);

imshow(image)
imshow(image2)

% 1. Use the channel that marks the cell nuclei. Produce an appropriately
% smoothed image with the background subtracted. 

image2_sm = imfilter(image2, fspecial('gaussian',4,2));
image2_bg = imopen(image2_sm, strel('disk',100));
image2_smbg = imsubtract(image2_sm, image2_bg);
imshow(imadjust(image2_smbg));

% 2. threshold this image to get a mask that marks the cell nuclei. 

image2_mask = image2_smbg > 100;
imshow(image2_mask)

% 3. Use any morphological operations you like to improve this mask (i.e.
% no holes in nuclei, no tiny fragments etc.)

image2_change = imopen(image2_mask, strel('disk',11));
imshow(image2_change)

% 4. Use the mask together with the images to find the mean intensity for
% each cell nucleus in each of the two channels. Make a plot where each data point 
% represents one nucleus and these two values are plotted against each other

meanintensity1 = regionprops(image2_change,image, 'MeanIntensity');
meanintensity2 = regionprops(image2_change,image2, 'MeanIntensity');

mi1 = struct2dataset(meanintensity1);
mi2 = struct2dataset(meanintensity2);
plot(mi1,mi2,'.'); 
xlabel('Channel 1 Mean Intensity');
ylabel('Channel 2 Mean Intensity');
