clear;
load('../results/LightenedCNN_B_lfw.mat');
image_path_ref= image_path;

% load('../python/lfw_B.mat');   
load('../python/lfw_lightened_cnn_mxnet_0166_convert.mat');   

load('lfw_pairs.mat');

neg_pair_new = zeros(2, 3000);
pos_pair_new = zeros(2, 3000);
ind_neg = 1;
ind_pos = 1;

names = {};
for i = length(image_path):-1:1
    names{i} = image_path{i}(3:end-4);
end

ind_find = [0 0];
for i  = 1:3000
    i
    % net_pair
    name1 = image_path_ref{neg_pair(1, i)}(11:end-4);
    name2 = image_path_ref{neg_pair(2, i)}(11:end-4);
    num_find = 0;
    for k = 1 : length(names)
        if strcmp(name1, names{k}) == 1 || strcmp(name2, names{k}) == 1
            num_find = num_find + 1;
            ind_find(num_find) = k;
        end
        if  num_find == 2
            neg_pair_new(:, ind_neg) = ind_find;
            ind_neg = ind_neg + 1;
            break;
        end
    end
    
    % pos_pair
    name1 = image_path_ref{pos_pair(1, i)}(11:end-4);
    name2 = image_path_ref{pos_pair(2, i)}(11:end-4);
    num_find = 0;
    for k = 1 : length(names)
        if strcmp(name1, names{k}) == 1 || strcmp(name2, names{k}) == 1
            num_find = num_find + 1;
             ind_find(num_find) = k;
        end
        if  num_find == 2
            pos_pair_new(:, ind_pos) = ind_find;
             ind_pos = ind_pos + 1;
            break;
        end
    end
    
end

pos_pair_new(:, ind_pos:end) = [];
neg_pair_new(:, ind_pos:end) = [];
pos_pair = pos_pair_new;
neg_pair = neg_pair_new;

save lfw_pairs_new.mat pos_pair  neg_pair
