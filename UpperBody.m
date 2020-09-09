%Create a detector object
bodyDetector = vision.CascadeObjectDetector('UpperBody'); 
bodyDetector.MinSize = [120 100];
bodyDetector.ScaleFactor = 1.05;

%Read input image and detect upper body.
I2 = imread('MWsample_full.png');
bboxBody = step(bodyDetector, I2);

%Annotate detected upper bodies.
IBody = insertObjectAnnotation(I2, 'rectangle',bboxBody,'Upper Body');
figure, imshow(IBody), title('Detected upper bodies');