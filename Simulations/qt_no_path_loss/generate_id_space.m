function id_space = generate_id_space(k)

id_space = zeros(2^k,k);
for col = 1:1:k
    pattern = [zeros(2^(col-1),1) ; ones(2^(col-1),1)];
    reps = (2^k) / length(pattern);
    vertical = [];
    for index = 1:1:reps
        vertical = [vertical ; pattern];
    end
    id_space(:,k+1-col) = vertical;
end % for col