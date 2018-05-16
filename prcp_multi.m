clear,clc;
itrmax = 1e3; theta1 = 1.5; theta2 = 0.5; eta = linspace(0.999,0,itrmax); 
k = [15.*ones(1,itrmax/2) 50.*ones(1,itrmax/2)]; alpha = 0.2;
r1 = 1 + 0.5*randn; r2 = 1 + 0.5*randn; r3 = -2 + 0.5*randn;
w3 = [r1 r1; zeros(itrmax-1,2)]; w4 = [r2 r2 r3; zeros(itrmax-1,3)]; 
x = double(rand(itrmax,2) > 0.5); t = double(xor(x(:,1),x(:,2)));
net3 = zeros(itrmax,1); net4 = zeros(itrmax,1); o3 = zeros(itrmax,1); o4 = zeros(itrmax,1);
dl3 = zeros(itrmax,1); dl4 = zeros(itrmax,1);
for i=1:itrmax 
    net3(i) = w3(i,:)*x(i,:)';
    o3(i) = sigmf(net3(i),[k(i),theta1]);
    net4(i) = w4(i,:)*[x(i,:) o3(i)]';
    o4(i) = sigmf(net4(i),[k(i),theta2]);
    dl4(i) = k(i)*o4(i)*(1-o4(i))*(t(i)-o4(i));
    dl3(i) = k(i)*o3(i)*(1-o3(i))*dl4(i)*w4(i,3);
    if (i>1)
        w3(i+1,:) = w3(i,:) + (eta(i)*dl3(i)*o3(i)).*ones(1,2) + alpha.*(w3(i,:)-w3(i-1,:));
        w4(i+1,:) = w4(i,:) + (eta(i)*dl4(i)*o4(i)).*ones(1,3) + alpha.*(w4(i,:)-w4(i-1,:));
    else
        w3(i+1,:) = w3(i,:) + (eta(i)*dl3(i)*o3(i)).*ones(1,2);
        w4(i+1,:) = w4(i,:) + (eta(i)*dl4(i)*o4(i)).*ones(1,3);
    end
end
plot(abs(t-o4));