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

black_count = 0;
done_sing = false;
while (~done_sing)
    ptr = ptr + 1;

    % Extract query prefix from Q, and compare it to all tag ids. 
    prefix = Q(ptr,1:Q_lens(ptr));
    len = length(prefix);
    
    done = false;
    match_indices = [];
    for lcv = 1:length(ids(:,1))
        if ( all(prefix == ids(lcv,1:len)) ) % Prefix match.
            match_indices = [match_indices lcv];
        end
    end 
    
    % Make changes according to which ids where matched.
    if (length(match_indices) == 0) % No matches.  White leaf.
        % Do nothing.
   
    elseif (length(match_indices) == 1) % SIR will higher than SIR_req <= 1.  Assume black leaf.
        black_count = black_count + 1;
        
    else % Nonempty slot.  Check SIRs.
        SIR = [];
        for lcv = 1:length(match_indices)
            mask = ones(1,length(match_indices));
            mask(1,lcv) = 0;
            numer = ( 1/dist_vals(match_indices(lcv),1)^4 ); 
            denom = mask * ( 1 ./ dist_vals(match_indices,1).^4 );
            SIR(lcv,1) = numer/denom;
        end % for lcv
        [max_SIR, max_index] = max(SIR); 
        
        if (max_SIR(1) >= SIR_req) % Capture effect.  Assume black leaf.
            black_count = black_count + 1;
        else % Assume grey node.  Grow tree.        
            height = length(Q_lens);
            Q(height+1:height+2 , :) = -ones(2,k);
            Q(height+1,1:length(prefix)+1) = [prefix 0];
            Q(height+2,1:length(prefix)+1) = [prefix 1];
            Q_lens(height+1,1) = length(prefix)+1;
            Q_lens(height+2,1) = length(prefix)+1;
        end
    end
    
    if (ptr == length(Q_lens)) % No more query prefixes.
        done_sing = true;
    end    
end % while (~done_sing)
%if (length(unsinged_indices) > 0)
%    disp('Error.  Did not singulate all tags.');
%end

query_count = ptr;
missed_count_rate = (n - black_count) / n;