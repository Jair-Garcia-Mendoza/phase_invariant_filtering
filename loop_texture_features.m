%FIND TEXTURE FEATURES FOR ALL IMAGES USING LIZ'S CODE AND CALCULATE TOTAL
%TEXTURE FEATURE INDEX AS SUM OF ALL FEATURES ACCROSS THE TWO DIMENSIONS.
%% TEXTURE FEATURES BACKGROUNDS + LIZARD
im_idx  = [2;4;7;8;10;20;24;25;26;27;28;29;31;36;...
    38;39;42;43;47;49;50];
n = size(im_idx,1);
tot_features = zeros(n,1);
texture_cell = cell(n,1);
for ii = 1:n
    im_nam = sprintf('s%iliz.jpg',im_idx(ii));
    myImg = imread(im_nam);
    filter_rectify_filter_2_loop;
    texture_cell{ii,1} = totalresp;
    tot_features(ii,1) = sum(totalresp(:));
    close all
    clearvars -except tot_features texture_cell im_idx
end
%% TEXTURE FEATURES EMPTY BACKGROUNDS
im_idx  = [1;2;3;4;5;6;7;8];
n = size(im_idx,1);
tot_features = zeros(n,1);
texture_cell = cell(n,1);
for ii = 1:n
    im_nam = sprintf('background_%i.jpg',im_idx(ii));
    myImg = imread(im_nam);
    filter_rectify_filter_2_loop;
    texture_cell{ii,1} = totalresp;
    tot_features(ii,1) = sum(totalresp(:));
    close all
    clearvars -except tot_features texture_cell im_idx
end
%% CONTRAST (AS RMSE) LUMINANCE AND MIN MAX STATISTICS
im_idx  = [2;4;7;8;10;20;24;25;26;27;28;29;31;36;...
    38;39;42;43;47;49;50];
n = size(im_idx,1);
im_properties = zeros(n,4);
for jj = 1:n
    im_nam = sprintf('s%iliz.jpg',im_idx(jj));
    f = imread(im_nam);
    im_properties(jj,1) = max(f(:));
    im_properties(jj,2) = min(f(:));
    im_properties(jj,3) = sum(f(:));
    im_properties(jj,4) = (std2(f)/mean2(f));
end
display(['maximum   ','minimum   ','sum   ','RMSE   ']);
%% TEXTURE FEATURES EMPTY BACKGROUNDS
im_idx  = [1;2;3;4;5;6;7;8];
n = size(im_idx,1);
tot_features = zeros(n,1);
texture_cell = cell(n,1);
for ii = 1:n
    im_nam = sprintf('background_%i.jpg',im_idx(ii));
    myImg = imread(im_nam);
    filter_rectify_filter_2_loop;
    texture_cell{ii,1} = totalresp;
    tot_features(ii,1) = sum(totalresp(:));
    close all
    clearvars -except tot_features texture_cell im_idx
end
%% CONTRAST (AS RMSE) LUMINANCE AND MIN MAX STATISTICS FOR EMPTY BACKGROUNDS
im_idx  = [1;2;3;4;5;6;7;8];
n = size(im_idx,1);
im_properties = zeros(n,4);
for jj = 1:n
    im_nam = sprintf('background_%i.jpg',im_idx(jj));
    f = imread(im_nam);
    im_properties(jj,1) = max(f(:));
    im_properties(jj,2) = min(f(:));
    im_properties(jj,3) = sum(f(:));
    im_properties(jj,4) = (std2(f)/mean2(f));
end
display(['bck_maximum   ','bck_minimum   ','bck_sum   ','bck_RMSE   ']);