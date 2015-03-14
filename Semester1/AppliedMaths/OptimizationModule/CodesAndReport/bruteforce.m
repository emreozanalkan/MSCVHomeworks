function[minibru]=bruteforce(fx)
% fx=-exp(-(x.^2))+exp(-(x+1).^2);
minib=fx(1); % taking minimu value
for i=2:length(fx)
    if fx(i)<=minib % checking condition and gives minimum value
        minib=fx(i);
    end
end
minibru=min(minib); % minimum value at final step