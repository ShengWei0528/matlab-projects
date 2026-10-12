% ------------------------------------------------------------------------
% hw07_input_validation.m
% Homework 7 (part 2): check that x and y are not negative, re-prompt once.
% Course: Computer Programming (程式設計), YZU, Spring 2023
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------
x=input('x=')
y=input('y=')
if x<0 
    disp('請將x改為正整數')
    x=input('x=')
elseif y<0
    disp('請y改為正整數')
    y=input('y=')
else
    disp('好棒')
end
