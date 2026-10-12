% ------------------------------------------------------------------------
% hw04_midpoint_integration.m
% Homework 4 (part 3): midpoint Riemann sum of humps(x) on [-1, 1].
% Course: Computer Programming (程式設計), YZU, Spring 2023
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------
f = @(x) humps(x);

a = -1;
b = 1;
n = 1000000;


dx = (b-a)/n;


Area = 0;
for i = 1:n
    
    x_left = a + (i-1)*dx;
    x_right = a + i*dx;
    
   
    x_mid = (x_left + x_right)/2;
    
   
    Area = Area + dx * f(x_mid);
end


fprintf('數值積分結果為 %.6f\n', Area);
