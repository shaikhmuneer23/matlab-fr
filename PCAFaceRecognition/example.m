% A sample script, which shows the usage of functions, included in
% PCA-based face recognition system (Eigenface method)
%
% See also: CREATEDATABASE, EIGENFACECORE, RECOGNITION

% Original version by Amir Hossein Omidvarnia, October 2007
%                     Email: aomidvar@ece.ut.ac.ir                  

clear all
clc
close all

% You can customize and fix initial directory paths
%TrainDatabasePath = uigetdir('D:\Program Files\MATLAB\R2006a\work', 'Select training database path' );
%TestDatabasePath = uigetdir('D:\Program Files\MATLAB\R2006a\work', 'Select test database path');
TrainDatabasePath = ('C:\Users\Arduino\Documents\MATLAB\PCA Face Recognition\TrainDatabase');
TestDatabasePath =  ('C:\Users\Arduino\Documents\MATLAB\PCA Face Recognition\TestDatabase');


%prompt = {'Enter test image name (a number between 1 to 10):'};
%dlg_title = 'Input of PCA-Based Face Recognition System';
%num_lines= 1;
%def = {'1'};

for img = 1 : 11;
%TestImage  = inputdlg(prompt,dlg_title,num_lines,def);
%TestImage = strcat(TestDatabasePath,'\',char(TestImage),'.jpg');
TestImage = strcat(TestDatabasePath,'\',num2str(img),'.jpg');
im = imread(TestImage);

T = CreateDatabase(TrainDatabasePath);
[m, A, Eigenfaces] = EigenfaceCore(T);
OutputName = Recognition(TestImage, m, A, Eigenfaces);

SelectedImage = strcat(TrainDatabasePath,'\',OutputName);
SelectedImage = imread(SelectedImage);

figure((img))
subplot(2,1,1);
imshow(im)
title('Test Image');
subplot(2,1,2);
imshow(SelectedImage);
title('Equivalent Image');
end

str = strcat('Matched image is :  ',OutputName);
disp(str)
