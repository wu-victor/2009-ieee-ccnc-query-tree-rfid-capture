clear all;

NUM_RAND = 1000;
k = 12;
id_space = generate_id_space(k);

rand('state',0);

index = 0;
for n = 10:10:100
    n
    query_count_cum = 0;
    for reps = 1:NUM_RAND
        main 
        query_count_cum = query_count_cum + query_count;
    end % for reps
    index = index + 1;
    query_count_avg(index,1) = query_count_cum / NUM_RAND
end
