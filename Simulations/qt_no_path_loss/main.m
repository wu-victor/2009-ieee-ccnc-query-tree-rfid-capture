% Main program.

global ids;

generate_ids(n,id_space);

% Not necessary.  But here to maintain concurrent random state.
[x_vals, y_vals, dist_vals] = generate_points(1, n); 

% Initialize query prefix queue, and vector of query lengths.
Q = [0 ; 1];
Q(1:2, 2:k) = -ones(2,k-1);
Q_lens = [1 ; 1];
ptr = 0;

% Indices of tag ids that are unsinged so far.
unsinged_indices = (1:n)';

done_sing = false;
while (~done_sing)
    ptr = ptr + 1;

    % Extract query prefix from Q, and compare it to the unsinged tag ids. 
    prefix = Q(ptr,1:Q_lens(ptr));
    match_indices = [];
    for lcv = 1:length(unsinged_indices)
        if ( all(prefix == ids( unsinged_indices(lcv) , 1:length(prefix) ) ) ) % Prefix match.
            match_indices = [match_indices ; lcv];
        end
    end % for lcv
    
    % Make changes according to which ids where matched.
    if (length(match_indices) == 0) % No matches.  White leaf.
        % Do nothing.
    elseif (length(match_indices) == 1) % Black leaf.
        %disp('Black leaf.  Tag id is')
        %ids(unsinged_indices(match_indices(1)),:)
        %unsinged_indices(match_indices(1),:) = [];
    else % Grey node.
        height = length(Q_lens);
        Q(height+1:height+2 , :) = -ones(2,k);
        Q(height+1,1:length(prefix)+1) = [prefix 0];
        Q(height+2,1:length(prefix)+1) = [prefix 1];
        Q_lens(height+1,1) = length(prefix)+1;
        Q_lens(height+2,1) = length(prefix)+1;
    end
    
    if (ptr == length(Q_lens)) % No more query prefixes.
        done_sing = true;
    end    
end % while (~done_sing)
%if (length(unsinged_indices) > 0)
%    disp('Error.  Did not singulate all tags.');
%end
query_count = ptr;