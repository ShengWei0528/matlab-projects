% ------------------------------------------------------------------------
% myMatProd.m
% Matrix product with explicit loops and a dimension check (returns ErrorCode).
% Warm-up exercise, saved September 2024
% Author: Sheng-Wei Lu (呂聖韡)
% ------------------------------------------------------------------------
function [C, ErrorCode] = myMatProd(A, B)
    % 檢查矩陣維度是否相容
    if size(A, 2) ~= size(B, 1)
        ErrorCode = 1;  % 矩陣無法相乘
        C = [];
        disp('Error: Matrices dimensions are not aligned for multiplication.');
        return;
    else
        ErrorCode = 0;  % 矩陣可以相乘
    end
    
    % 矩陣相乘
    C = zeros(size(A, 1), size(B, 2));
    for i = 1:size(A, 1)
        for j = 1:size(B, 2)
            C(i, j) = A(i, :) * B(:, j);
        end
    end
end
