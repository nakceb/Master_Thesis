function [X_center,Y_center] = Center_of_cell(X, Y, gridsize)

X_center = (floor(X*gridsize)+0.5)/gridsize;
Y_center = (floor(Y*gridsize)+0.5)/gridsize;
end