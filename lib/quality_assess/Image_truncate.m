function  Image_truncate(image_ref, image_data, location)
%%####
close all
%%####
figure, 
subplot(1,3,1); showRGB(image_ref, image_data{1}, location); title('EXP')
%
subplot(1,3,2); showRGB(image_ref, image_data{2}, location); title('LRTCFPan')
%
subplot(1,3,3); showRGB(image_ref, image_ref, location); title('Ground-Truth')
%
end