%this relies on the Image Processing Toolbox, and Kovesi's log-gabor code. 
clear all;

%parameters -- can play with these if you like
nScales = 4;   % <<<<<<< CHANGE NUMBER OF SPATIAL SCALES EXAMINED
nOris = 6;     % <<<<<<< CHANGE FINENESS OF ORIENTATION SAMPLING

%second-stage filter, mid-size gaussian blob. You can play with this. 
%fspecial('gaussian', size, sigma). 
blob = fspecial('gaussian',8,4); 
% figure(5); imagesc(blob);

%import an image
% myImg = imread(imgetfile());
myImg = imread('AOI_2.tif');
% myImg = imread('empty_bck_liz24.tif');
%process image
if length(size(myImg)) > 2
    myImg = double(rgb2gray(myImg));
else
    myImg = double(myImg);
end
%this is where you will want to apply a gaussian to taper the edges,
%contrast normalize, scale etc. 

figure(1); imagesc(myImg); colormap(gray); axis image; axis off;
title('Source Image');

% (1) filter image
resp = gaborconvolve(myImg, nScales, nOris, ...
                            3,1.6,0.75,0,0); 
                        %feel free to experiment with other parameters and
                        %output options
counter = 1;                        
for io = 1:nOris
   for is = 1:nScales
       thisresp = real(resp{is, io}); 
       %replace the call to 'real' with a call to 'imag' for other half of phase pair
       
       figure(2); subplot(nOris, nScales, counter); imagesc(thisresp); axis image; axis off;
       colormap('gray');
       
       % (2) rectify in some way
            % absolute value: simplest possible, always first step, add
             % other nonlinearities as desired.
            % square law: reflects fourier energy, classic approach
            % compressive: reflects cortical normalization processes
                                 % CHANGE
       thisresp = abs(thisresp); % <<<<<< you can add a nonlinearity like .^2, .^0.5, etc.            
       figure(3); subplot(nOris, nScales, counter); imagesc(thisresp); axis image; axis off;
       colormap('gray');

       %typically, these steps are combined so that you get a
       %phase-invariant response like so:
       % thisresp = abs(real(resp{is, io}))+ abs(imag(resp{is, io}));
      
       
       % (3) filter with lower spatial frequency filters
                % it's faster to downsample and filter with something
                % smaller than to use a bigger filter, hence the imresize.
       pad = 20;
       nextresp = conv2(padarray(thisresp, [pad pad]),blob, 'valid');
       nextresp = nextresp(pad:end-pad, pad:end-pad);
       resp2{is, io} = nextresp;
       figure(4); subplot(nOris, nScales, counter); imagesc(nextresp); axis image; axis off;
       colormap('gray');
       
       if exist('totalresp')
           totalresp = totalresp + nextresp;
       else
           totalresp = nextresp;
       end
       
       counter = counter + 1;
   end
end

totalresp = totalresp/counter;
figure(6); imagesc(totalresp);axis image; axis off;

%totalresp is your "output" from the system, and you can decide how you
%want to evaluate the results
                        

