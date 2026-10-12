% ------------------------------------------------------------------------
% hw03_letter_grade.m
% Homework 3: map a numeric score to a letter grade (if / elseif).
% Course: Computer Programming (程式設計), YZU, Spring 2023
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------
s=input('成績=')

if (s > 80),grade='A'
elseif(s>70),grade='B'
elseif(s>60),grade='C'
else grade='D'
end

fprintf('\n 你的成績 %5.1f 的等第是 %d \n',grade)
