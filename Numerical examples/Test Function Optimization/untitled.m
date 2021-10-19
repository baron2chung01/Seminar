iniTime = clock;
f1 = @(x1,x2) 0.26*(x1^2+x2^2)-0.48*x1*x2
syms x1 x2
f = 0.26*(x1^2+x2^2)-0.48*x1*x2
searchDom = [-10 10]
hess = hessian(f);
h1 = inv(hess);
h1 = matlabFunction(h1);
h1 = func2str(h1);
h1 = replace(h1,"@(x1,x2)","@(x)");
h1 = replace(h1,["x1","x2"],["x(1)","x(2)"]);
h1 = str2func(h1);

runtime = double(etime(clock, iniTime))