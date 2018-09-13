function UCIQE=UCIQE(rgb_in)
%Calculate UCIQE (Underwater Colour Image Quality Evaluation).
%
%Usage
%     UCIQE_value = UCIQE(RGB_Image)
%  The implemented algorithm is based on the paper of M. Yang et al.:
%  An Underwater Color Image Quality Evaluation Metric.
%
% Implemented by Z. J. Wang, UAV Lab, National University of Singapore
% Sept. 2018


rgb = double(rgb_in);
R = rgb(:,:,1);
G = rgb(:,:,2);
B = rgb(:,:,3);
mx=max(rgb,[],3);% max of the 3 colors
mn=min(rgb,[],3);% min of the 3 colors

alpha = 0.01 * (mn ./ mx);
gamma = 3;
Q = exp(alpha .* gamma);
% calculate Chroma
lab = rgb2lab(rgb);
a = lab(:,:,2);
b = lab(:,:,3);
Chroma = sqrt(a^2 + b^2);
VarianceChroma = var(reshape(Chroma(:,:),[],1));

% calculate saturation
hsv = rgb2hsv(rgb);
Saturation = hsv(:,:,2);
MeanSaturation = mean(reshape(Saturation(:,:),[],1));

% calculate luminance
Luminance = ((Q.*mx)+(1-Q).*mn)/2;

ContrastLuminance = max(reshape(Luminance(:,:),[],1)) - min(reshape(Luminance(:,:),[],1));

UCIQE = 0.4680 * VarianceChroma + 0.2745 * ContrastLuminance + 0.2576 * MeanSaturation;
