% Calculate probabilistically whether to grow tree or not.

% l is the length of the current prefix.
% gamma is a user defined parameter.
% k is the length of the tag id.
function grow = grow_tree(l, k, gamma)

if (l == k)
    grow = 0;
    return;
end

if (gamma == 0)
    grow = 0;
    return;
end

if (gamma == 1)
    grow = 1;
    return;
end

p1 = 1 - l/k;
p2 = gamma;

f1 = abs( (p1-0.5) / ( (p1-1)*p1 ) );
f2 = abs( (p2-0.5) / ( (p2-1)*p2 ) );

p = (f1 / (f1+f2))*p1 + (f2 / (f1+f2))*p2;
flip = rand;
if (flip <= p)
    grow = 1;
else
    grow = 0;
end
return;
