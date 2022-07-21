% Generate n unqiue uniformly distributed binary ids, each with length k.
function generate_ids(n, id_space)

global ids;

k = length(id_space(1,:));

% Check to see if there is enough bits for n unique ids.
if (2^k < n)
    ids = -1;
    return;
end

perm = randperm(2^k);
indices = perm(1:n)';
ids = id_space(indices,:);