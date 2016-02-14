clear

addpath ../src/

% Setup size of Matrices
n = 10;
n1 = 18;
n2 = 12;
n3 = 15;

% Setup Inputs
rowInd = [1,1,2,2,3,3,4,4];
colInd = [1,2,2,3,3,4,4,1];
spMats{1} = sparse(rand(n3,n));
spMats{2} = -speye(n3);
spMats{3} = sparse(rand(n2,n3));
spMats{4} = -speye(n2);
spMats{5} = sparse(rand(n1,n2));
spMats{6} = -speye(n1);
spMats{7} = sparse(rand(n,n1));
spMats{8} = speye(n);

% True solution
A = full(spMats{8}+spMats{7}*spMats{5}*spMats{3}*spMats{1});
b = ones(n,1);
xtrue = A\b;

% Solve using sparse embedding
[ E ] = matEmbed( rowInd, colInd, spMats );
bsparse = sparse([zeros(n1+n2+n3,1);b]);
xsparse = E\bsparse;
x = full(xsparse(1:n));

% Relative error
relerr = norm(xtrue - x)/norm(xtrue)