%The threshold function
function y=thetae(x)
tmp=1-exp(-abs(x));
y=sign(x).*tmp;