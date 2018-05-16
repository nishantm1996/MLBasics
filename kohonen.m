clear,clc;
N = 4; itrmax = 1e3; eta = repmat(linspace(0.999,0,itrmax/4),1,4); d = zeros(itrmax,N); w = zeros(itrmax,N,N); 
w1 = repmat([0 0 0.1 0.3],itrmax,1)./norm([0 0 0.1 0.3]); w2 = repmat([0.1 0.5 0.1 0.5],itrmax,1)./norm([0.1 0.5 0.1 0.5]);
w3 = repmat([0.5 0.1 0.5 0.1],itrmax,1)./norm([0.5 0.1 0.5 0.1]); w4 = repmat([0.9 0.9 0.9 0.1],itrmax,1)./norm([0.9 0.9 0.9 0.1]);
w(:,:,1) = w1; w(:,:,2) = w2; w(:,:,3) = w3; w(:,:,4) = w4;
x = [repmat([0 0 0 1],itrmax/4,1);repmat([0 1 0 1],itrmax/4,1);repmat([1 0 1 0],itrmax/4,1);repmat([1 1 1 1],itrmax/4,1)]; 
dmin = 1e3.*ones(itrmax,1); jmin = 1e3.*ones(itrmax,1); 
for i=1:itrmax     
    w(i,:,1) = w(i,:,1)./norm(w(i,:,1)); w(i,:,2) = w(i,:,2)./norm(w(i,:,2));
    w(i,:,3) = w(i,:,3)./norm(w(i,:,3)); w(i,:,4) = w(i,:,4)./norm(w(i,:,4));    
    w1(i,:) = w(i,:,1); w2(i,:) = w(i,:,2); w3(i,:) = w(i,:,3); w4(i,:) = w(i,:,4); 
    for j=1:N
        d(i,j) = norm(x(i,:)-w(i,:,j))^2;
        if (d(i,j)<dmin(i))
            dmin(i) = d(i,j); jmin(i) = j;
        end
    end
    if (jmin(i) == 1)
        w(i+1,:,1) = w(i,:,1) + eta(i)*(x(i,:)-w(i,:,1));
        w(i+1,:,2) = w(i,:,2); w(i+1,:,3) = w(i,:,3); w(i+1,:,4) = w(i,:,4);        
    end
    if (jmin(i) == 2)
        w(i+1,:,2) = w(i,:,2) + eta(i)*(x(i,:)-w(i,:,2));
        w(i+1,:,1) = w(i,:,1); w(i+1,:,3) = w(i,:,3); w(i+1,:,4) = w(i,:,4);
    end
    if (jmin(i) == 3)
        w(i+1,:,3) = w(i,:,3) + eta(i)*(x(i,:)-w(i,:,3));
        w(i+1,:,1) = w(i,:,1); w(i+1,:,2) = w(i,:,2); w(i+1,:,4) = w(i,:,4);
    end
    if (jmin(i) == 4)
        w(i+1,:,4) = w(i,:,4) + eta(i)*(x(i,:)-w(i,:,4));
        w(i+1,:,1) = w(i,:,1); w(i+1,:,2) = w(i,:,2); w(i+1,:,3) = w(i,:,3); 
    end
end

