% ------------------------------------------------------------------------
% hw07_polygon_area.m
% Homework 7: polygon area from an N-by-2 vertex matrix (shoelace terms).
% Course: Computer Programming (程式設計), YZU, Spring 2023
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------
%{
q=input('請輸入第一個座標點,[x,y]:')
w=input('請輸入第二個座標點,[x,y]:')
e=input('請輸入第三個座標點,[x,y]:')
r=input('請輸入第四個座標點,[x,y]:')
x=[q(1),w(1),e(1),r(1)]
y=[q(2),w(2),e(2),r(2)]
%}
p=input('輸入多邊形N*2的矩陣')
x=p(:,1)
y=p(:,2)
n=length(x)
s=0
for i=1:(n-1)
    a=(x(i)*y(i+1)-x(i+1)*y(i))/2
    s=s+a;
end
disp(s)
