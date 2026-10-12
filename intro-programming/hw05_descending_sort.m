% ------------------------------------------------------------------------
% hw05_descending_sort.m
% Homework 5 (part 1): sort a vector in descending order with nested loops.
% Course: Computer Programming (程式設計), YZU, Spring 2023
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------
x = input('輸入數列')
n = length(x);
for i = 1:n
    for j = i:n
        if x(i) < x(j)
            a = x(i);
            x(i) = x(j);
            x(j) = a;
        end
    end
end
disp(x)
