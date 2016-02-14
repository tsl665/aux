function [ varargout ] = matEmbed( rowInd, colInd, spMats )
%MATEMBED Summary of this function goes here
%   Detailed explanation goes here

% Compute Starting Indices of Blocks

for k = 1:max(rowInd)
    % Find a block with row index k, and compute its number of rows
    inds = find(rowInd == k);
    if length(inds) == 0
        fprintf('Error! Do not exists ...');
        return;
    end
    kk = inds(1);
    [rowBlockSize(k), ~] = size(spMats{kk});
    iBlockStarts(k) = sum(rowBlockSize(1:k-1))+1;
end


for k = 1:max(colInd)
    % Find a block with column index k, and compute its number of columns
    inds = find(colInd == k);
    if length(inds) == 0
        fprintf('Error! Do not exists ...');
        return;
    end
    kk = inds(1);
    [~ ,colBlockSize(k)] = size(spMats{kk});
    jBlockStarts(k) = sum(colBlockSize(1:k-1))+1;
end

I = []; J = []; Val = [];
for k = 1:length(spMats)
    [ I, J, Val ] = embed( I, J, Val, spMats{k}, iBlockStarts(rowInd(k)), jBlockStarts(colInd(k)) );
end

if nargout == 1
    varargout{1} = sparse(I,J,Val);
elseif nargout == 3
    [Api, sortIdx] = sortrows([J',I']);

    varargout{1} = [0;cumsum(accumarray(Api(:,1),1))]; %Ap
    varargout{2} = Api(:,2) - 1; %Ai
    varargout{3} = Val(sortIdx)'; %Ax
end

end