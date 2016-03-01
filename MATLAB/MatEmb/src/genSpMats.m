function [ mats ] = genSpMats( matType, rowSize, colSize, nMats )
%MATEMBED_SPECIALMATS Summary of this function goes here
%   Detailed explanation goes here

if length(rowSize) == 1
    opt.uniRowSize = 1;
elseif length(rowSize) == nMats
    opt.uniRowSize = 0;
else
    error('Sizes of rows of blocks has to be consistant with number of matrix blocks!')
end

if length(colSize) == 1
    opt.uniColSize = 1;
elseif length(colSize) == nMats
    opt.uniColSize = 0;
else
    error('Sizes of columns of blocks has to be consistant with number of matrix blocks!')
end

if iscellstr({matType})
    if strcmp(matType, 'rand')
        fGenMat = @(n,m) sparse(rand(n,m));
    elseif strcmp(matType, 'eye')
        fGenMat = @(n,m) speye(n,m);
    elseif strcmp(matType, 'ones')
        fGenMat = @(n,m) ones(n,m);
    else
        error('Invalid special matrix type!');
    end
else
    error('Special matrix type must be a string!');
end
for k = 1:nMats
    if opt.uniRowSize == 1
        curRowSize = rowSize;
    else
        curRowSize = rowSize(k);
    end
    
    if opt.uniColSize == 1
        curColSize = colSize;
    else
        curColSize = colSize(k);
    end
    
    mats{k} = fGenMat(curRowSize,curColSize);
end





end

