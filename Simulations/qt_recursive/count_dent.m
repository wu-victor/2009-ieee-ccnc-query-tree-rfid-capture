% Calculate how many descendents the current node in the query tree has.
% Count yourself as a descendent.
function [dent_count, black_count] = count_dent(prefix)

global ids;

len = length(prefix);

done = false;
index = 0;
matches = 0;

if (len == 0) % Root node.
    matches = 2;  % Assume collision.
    done = true; % Skip checking.
end

while (~done)
    index = index + 1;
    if ( all(prefix == ids(index,1:len)) ) % Prefix match.
        matches = matches + 1;
        match_index = index;
    end
    if ( (matches == 2) || (index == length(ids(:,1))) ) 
        done = true;
    end
end % while

if (matches == 0) % No response.  White leaf.
    dent_count = 1;
    black_count = 0;
    return;
elseif (matches == 1) % One response.  Black leaf.
    %disp('Black leaf found.  Tag id is');
    %ids(match_index,:)
    dent_count = 1;
    black_count = 1;
    return;
else % Multiple responses.  Collision.  Make recursive call.
    [left_dent_count, left_black_count] = count_dent([prefix 0]);
    [right_dent_count, right_black_count] = count_dent([prefix 1]);
    dent_count = 1 + left_dent_count + right_dent_count;
    black_count = left_black_count + right_black_count;
    return;
end
