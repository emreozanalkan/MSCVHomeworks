function c = myrref(A,b)
% solver for system of linear equations in binary arithmetic using Gaussion
% elimination algroithm.
    mat = [A b];
    [m n] = size(A);  % read the size of the original matrix A
    
    for i = 1 : n
        j = find(mat(i:m, i), 1); % finds the first 1 in i-th column starting at i
        
        if isempty(j)
            continue
        else
            j = j + i - 1;  % we need to add i - 1 since j starts at i
            temp = mat(j,:);  % swap rows
            mat(j,:) = mat(i,:);
            mat(i,:) = temp;
            % add i-th row to all rows that contain 1 in i-th column
            % starting at j + 1  - remember up to j are zeros
            for k = find(mat( (j+1):m, i ))'
                mat(j + k, :) = bitxor(mat(j + k, :),mat(i, :));
            end
            
        end
    end
    
    %remove all-zero rows if there are some
    mat = mat(sum(mat,2)>0,:);
    
    % calculate final solution
    x = zeros(n,1);  % just an initialization
    for i = n-2: -1 :1 % go back from n to 1
        x(i) = bitand(dot(mat(i,i:n),x(i:n)) + mat(i,n+1),1);
    end
    c = x;
end
