% data_load =load('C:\Users\fiste1\Google Drive\Thesis Project\Matlab och kod\Main program\Kalman_Lars\pictures\dag_2_map.mat');
% %map_copy = map;
% %mat = occupancyMatrix(map_copy);
global IM



Occu_map = robotics.OccupancyGrid(IM);
Occu_map.FreeThreshold = 0.51;
Occu_map.OccupiedThreshold = 0.6;
IM_bin = occupancyMatrix(Occu_map, 'ternary');

%IM = imopen(mat_load,strel('disk', 10));

for i=0:1:179
    IM = imdilate(IM,strel('line',10,i));
    IM = imerode(IM,strel('line',10,i));
end
IM = imclose(IM,strel('disk', 20));
IM_bin = imclose(IM_bin,strel('disk',5));
for i=0:1:179
    IM_bin = imdilate(IM_bin,strel('line',10,i));
    IM_bin = imerode(IM_bin,strel('line',10,i));
end

% figure
% imshow(IM)

occupancymap = robotics.OccupancyGrid(IM);
figure
 show(occupancymap)
occupancymap.FreeThreshold = 0.64;
occupancymap.OccupiedThreshold = 0.65;

binmat = occupancyMatrix(occupancymap, 'ternary'); 
binaryMap = robotics.BinaryOccupancyGrid(binmat);
figure
show(binaryMap)

binaryMap = robotics.BinaryOccupancyGrid(IM_bin);
figure
show(binaryMap)