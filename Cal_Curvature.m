function [ k ] = Cal_Curvature( x , p )

%syms x y;
y = zeros(length(x),1);
k = zeros(length(x),1);
 
for i = 1:length(x)
    
%Generating all y values
y(i) = p(1)*x(i)^4 + p(2)*x(i)^3 + p(3)*x(i)^2 + p(4)*x(i) + p(5);

%% Method one:  Calc curvature based on polynomial equation
% k(i) = abs(12*p(1)*(x(i).^2) + 6*p(2)*x(i) + 2*p(3))./(1 + ((4*p(1)*(x(i).^3)...
%     + 3*p(2)...
%     *(x(i).^2) + 2*p(3)*x(i) + p(4)).^2)).^1.5;
end

%% Method two: Calc curvature based on 3 neighboring points

for n = 1:length(x)-2
    
    xs = x(n:n+2);
    ys = y(n:n+2);
    os = ones(3,1);
    ss = xs.^2+ys.^2; % sum of squares
    
    a = det([xs ys os]); 
    d = -det([ss ys os]); 
    e = det([ss xs os]); 
    f = -det([ss xs ys]);
    r = sqrt((d^2+e^2)/(4*a^2)-(f/a)); 

    k(n+1)=1/r; % curvature
    
end



end

