% Main program.
clear all;

NUM_RAND = 1000;
k = 12;

global ids;

k = 12;
id_space = generate_id_space(k);

rand('state', 0);

index = 0;
for n = 10:10:100
    n
    
    dent_count_cum = 0; 
    for reps = 1:NUM_RAND
        
        generate_ids(n, id_space);
        [dent_count, black_count] = count_dent([]);
        
        if (black_count ~= n)
            disp('Error.  Did not singulate all tags.');
        end
        
        dent_count_cum = dent_count_cum + dent_count;
        
    end % for reps
    index = index + 1;
    dent_count_avg(index,1) = dent_count_cum / NUM_RAND
    
    
end % for n
