clear,clc;
N = 10; itrmax = 1e3; theta = N/2; eta = 1; %eta = 1 => basic perceptron
w = [double(rand(1,N) > 0.5); zeros(itrmax-1,N)]; x = double(rand(itrmax,N) > 0.5); y = zeros(1,itrmax);
d = x(:,1)';
for i=1:itrmax 
    y(i) = double(w(i,:)*x(i,:)' - theta > 0);
%     if (y(i) == d(i))
%         w(i+1,:) = w(i,:);
%     else if (y(i) < d(i))
%             w(i+1,:) = w(i,:) + [x(i,1) eta.*x(i,2:end)];
%         else
%             w(i+1,:) = w(i,:) - [x(i,1) eta.*x(i,2:end)];
%         end
%     end
    dlt = d(i)-y(i);
    w(i+1,:) = w(i,:) + dlt.*eta.*x(i,:); %widrow-hoff delta rule => adaline
end
plot(abs(d-y));
