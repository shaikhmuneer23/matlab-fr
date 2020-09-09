%% Copyright 2012 The MathWorks, Inc.
% Create a detector object (defualt MODEL is FrontalFace)
faceDetector = vision.CascadeObjectDetector;   
%faceDetector.ScaleFactor = 2.1;

% Read input image (Grayscale or RGB)
I = imread('GroupPic.jpg');

% Detect faces returns M-by-4 matrix
% Eachrow of the output matrix,
% contains afour-element vector, [x y width height], that specifies in pixels,the upper-left corner and size of a bounding box. 
bbox = step(faceDetector, I); 
dim = size(bbox);
no_of_faces = dim(1,1);

% Create a shape inserter object to draw bounding boxes around detections
%shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 255 0]); 

% Draw boxes around detected faces and display results              
%I_faces = step(shapeInserter, I, int32(bbox));    
%figure, imshow(I_faces), title('Detected faces');  

IFaces = insertObjectAnnotation(I, 'rectangle', bbox, 'Face');   
figure, imshow(IFaces), title('Detected faces');

for i = 1 : no_of_faces
    Icrop = imcrop(I,bbox(i,:));
    Icrop = imresize(Icrop, [250 250]);
    filename = ['Face' num2str(i) '.jpg'];
    cd('C:\Users\Arduino\Documents\MATLAB\Computer Vision Examples\TestDatabase\');
    imwrite(Icrop,filename);
end
cd('C:\Users\Arduino\Documents\MATLAB\Computer Vision Examples\');