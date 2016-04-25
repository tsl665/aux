function [ m, n, A ] = fortReadMat( fname, matType )
%FORTREADMAT Summary of this function goes here
%   Detailed explanation goes here

lpn = 11;
lnxt = lpn+2;


fid = fopen(fname);
tline = fgetl(fid);
m = str2num(tline);
tline = fgetl(fid);
n = str2num(tline);

A = zeros(m,n);

if (matType == 'D')

    k = 0;

    while ischar(tline)
        tline = fgetl(fid);
        p1 = 3;
        while p1 < length(tline)
            k = k + 1;
%            j = mod(k-1, n)+1;
%            i = floor((k-1)/n)+1;
            i = mod(k-1, m)+1;
            j = floor((k-1)/m)+1;
            p2 = min(p1+lpn, length(tline));
            A(i,j) = str2double(tline(p1:p2));
            p1 = p1 + lnxt;
        end
    end
    
elseif (matType == 'Z')
    
    k = 0;

    while ischar(tline)
        tline = fgetl(fid);
        p1 = 3;
        while p1 < length(tline)
            k = k + 1;
            p2 = min(p1+lpn, length(tline));
            if mod(k, 2) == 1
                re = str2double(tline(p1:p2));
            else
                k2 = k/2;
%                j = mod(k2-1, n)+1;
%                i = floor((k2-1)/n)+1;
                i = mod(k2-1, m)+1;
                j = floor((k2-1)/m)+1;
                p2 = min(p1+lpn, length(tline));
                im = str2double(tline(p1:p2));
                A(i,j) = re + sqrt(-1)*im;
            end
            p1 = p1 + lnxt;
        end
    end
end

fclose(fid);
        
    



end

