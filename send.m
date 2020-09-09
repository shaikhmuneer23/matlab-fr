function send(camImg)
%% Copyright 2012 The MathWorks, Inc.

TrainDatabasePath = ('C:\Users\Arduino\Dropbox\CameraSync\Multimedia\PCAFaceRecognition\TrainDatabase2');
TestDatabasePath =  ('C:\Users\Arduino\Dropbox\CameraSync\Multimedia\PCAFaceRecognition\TestDatabase');
%ApparentTrainDatabase = ('C:\Users\Arduino\Documents\MATLAB\Computer Vision Examples\PCA Face Recognition\ApparentTrainDatabase\');
mainDir = ('C:\Users\Arduino\Dropbox\CameraSync\Multimedia\');
mainDirPCA = ('C:\Users\Arduino\Dropbox\CameraSync\Multimedia\PCAFaceRecognition\');


%Delete the previous images from TestDatabase
cd(TestDatabasePath);
delete *.jpg

cd(mainDir);

% Create a detector object (defualt MODEL is FrontalFace)
faceDetector = vision.CascadeObjectDetector;   
%faceDetector.ScaleFactor = 2.1;

% Read input image (Grayscale or RGB)
I = imread(camImg);
disp('Image read successfully')
disp(' ')

% Detect faces returns M-by-4 matrix
% Eachrow of the output matrix,
% contains afour-element vector, [x y width height], that specifies in pixels,the upper-left corner and size of a bounding box. 
bbox = step(faceDetector, I); 
dim = size(bbox);
no_of_faces = dim(1,1);
disp(strcat('Detected --',num2str(no_of_faces),' faces'));
disp(' ')

% Create a shape inserter object to draw bounding boxes around detections
%shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[255 255 0]); 

% Draw boxes around detected faces and display results              
%I_faces = step(shapeInserter, I, int32(bbox));    
%figure, imshow(I_faces), title('Detected faces');  

IFaces = insertObjectAnnotation(I, 'rectangle', bbox, 'Face');   
%figure, imshow(IFaces), title('Detected faces');
cd(TestDatabasePath);
filenamebox = camImg;
imwrite(IFaces,filenamebox);
cd(mainDir);

for i = 1 : no_of_faces
    Icrop = imcrop(I,bbox(i,:));
    Icrop = imresize(Icrop, [250 250]);
    filename = [num2str(i) '.jpg'];
    cd(TestDatabasePath);
    imwrite(Icrop,filename);
end

disp('Cropped Images... ')
disp(' ')

%prompt = {'Enter test image name (a number between 1 to 10):'};
%dlg_title = 'Input of PCA-Based Face Recognition System';
%num_lines= 1;
%def = {'1'};

disp('Recognizing faces...')
disp(' ')
for img = 1 : no_of_faces;
    cd (mainDirPCA);
%TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
%TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.jpg');
TestImage = strcat(TestDatabasePath,'\',num2str(img),'.jpg');
im = imread(TestImage);

T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = EigenfaceCore(T);

disp(strcat('Recognized Face ',num2str(img)))

OutputName = Recognition(TestImage, m, A, Eigenfaces);

SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
SelectedImage = imread(SelectedImage);
 cd(TestDatabasePath);
imwrite(SelectedImage, strcat('Face',num2str(img),'.jpg'));

%figure((img))
%subplot(2,1,1);
%imshow(im)
%title('Test Image');
%subplot(2,1,2);
%imshow(SelectedImage);
%title('Equivalent Image');

end

disp('-----------------------------------');
disp('DONE !')
disp('Return to the application and retrieve results ')
%str = strcat('Matched image is :  ',OutputName);
%disp(str)
cd(mainDir);
