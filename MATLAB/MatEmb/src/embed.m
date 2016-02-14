function [ I, J, V ] = embed( I, J, V, S, iBlock, jBlock )
%EMBED Summary of this function goes here
%   Detailed explanation goes here

[Is, Js, Vs] = find(S);
n = length(I);
ns = length(Is);
I(n+1:n+ns) = Is + iBlock - 1;
J(n+1:n+ns) = Js + jBlock - 1;
V(n+1:n+ns) = Vs;

end

