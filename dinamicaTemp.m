clear all
% dt = data(1:600);
% 
% y1=dt(1);
% yf=dt(end);
% 
% y=zeros(size(dt));
% y(1) = y1;
% 
% a=0.994;
% 
%     
% for i=1:size(dt)
%     
%    y(i+1) = a*y(i)+(1-a)*yf;
%    
% end
% 
% plot([y(2:end) dt])
% 
% RMSE = sqrt(sum((dt - y(2:end)).^2)/size(dt,1))

a=0.994;

t(1)=80.8425;
t2=103.7942;

i=1;
while t(i) <= 103
    t(i+1) = a*t(i)+(1-a)*t2;
    i=i+1;
end

plot(t)