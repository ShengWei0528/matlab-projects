% ------------------------------------------------------------------------
% hw06_lottery_draw.m
% Homework 6: lottery draw (小樂透演算法) - n distinct random numbers from 1..p.
% Course: Computer Programming (程式設計), YZU, Spring 2023
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------
n = input('抽取的數量')
p = input('抽獎數字範圍')
a = zeros(1, n);

for i = 1:n
    repeat = true;
    while repeat
        num = randi(p);
        repeat = false;
        for j = 1:i-1
            if num == a(j)
                repeat = true;
                break;
            end
        end
    end
    

    a(i) = num;
end


a = sort(a);

fprintf('中獎號碼為：');
disp(a)
