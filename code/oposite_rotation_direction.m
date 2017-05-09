function [ bool ] = oposite_rotation_direction(  )
global theta

Q = unwrap(theta);
w = diff(Q);
if Q >=0
    bool = 1;
else
    bool=0;
end

end

