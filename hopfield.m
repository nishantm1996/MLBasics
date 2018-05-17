clear,clc;
N = 50; M = 3; itrmax = 999; w = zeros(N,N); 
s = [repmat([-1 1],1,N/2);repmat([1 -1],1,N/2);ones(1,N)];
x = [ones(N/2,1);-1.*ones(N/2,1)]; y = [x zeros(N,itrmax-1)];
for i=1:N
    for j=1:N
        if (j==i)
            w(i,j) = 0;
        else
            for k=1:M
                w(i,j) = w(i,j) + s(k,i)*s(k,j);
            end
        end
    end
end
for i=2:itrmax
    y(:,i) = 2.*double(w*y(:,i-1)>0)-1; %synchronous
end