function [xopt,fopt,niter,gnorm,dx] = grad_descent_plot(x0,testFunc)

% one of the x0 choice: [3 3]'

% termination tolerance
tol = 1e-6;

% maximum number of allowed iterations
maxiter = 1000;

% minimum allowed perturbation
dxmin = 1e-6;

% step size ( 0.33 causes instability, 0.2 quite accurate)
alpha = 0.1;

% initialize gradient norm, optimization vector, iteration counter, perturbation
gnorm = inf; x = x0; niter = 0; dx = inf;

% define the objective function
switch testFunc
    
    case 'Ackley'
        f1 = @(x1,x2) -20*exp(-0.2*sqrt(0.5*(x1.^2+x2.^2)))-exp(0.5*(cos(2*pi*x1)+cos(2*pi*x2)))+exp(1)+20;
        syms x1 x2
        f = -20*exp(-0.2*sqrt(0.5*(x1^2+x2^2)))-exp(0.5*(cos(2*pi*x1)+cos(2*pi*x2)))+exp(1)+20;
        searchDom = [-5 5]
        
    case 'Beale'
        f1 = @(x1,x2) (1.5-x1+x1*x2)^2+(2.25-x1+x1*x2^2)^2+(2.625-x1+x1*x2^3)^2;
        syms x1 x2
        f = (1.5-x1+x1*x2)^2+(2.25-x1+x1*x2^2)^2+(2.625-x1+x1*x2^3)^2;
        searchDom = [-4.5 4.5]
        
    case 'Crossthetray'
        f1 = @(x1,x2) -0.0001*(abs(sin(x1)*sin(x2)*exp(abs(100-(sqrt(x1^2+x2^2))/pi)))+1)^0.1;
        syms x1 x2
        f = -0.0001*(abs(sin(x1)*sin(x2)*exp(abs(100-(sqrt(x1^2+x2^2))/pi)))+1)^0.1;
        searchDom = [-10 10]
        
    case 'Goldstein'
        f1 = @(x1,x2) ((1+(x1+x2+1)^2*(19-14*x1+3*x1^2-14*x2+6*x1*x2+3*x2^2))*(30+(2*x1-3*x2)^2*(18-32*x1+12*x1^2+48*x2-36*x1*x2+27*x2^2)))
        syms x1 x2
        f = ((1+(x1+x2+1)^2*(19-14*x1+3*x1^2-14*x2+6*x1*x2+3*x2^2))*(30+(2*x1-3*x2)^2*(18-32*x1+12*x1^2+48*x2-36*x1*x2+27*x2^2)))
        searchDom = [-2 2]
        
    case 'Bukin'
        f1 = @(x1,x2) 100*sqrt(abs(x2-0.01*x1^2))+0.01*abs(x1+10)
        syms x1 x2
        f = 100*sqrt(abs(x2-0.01*x1^2))+0.01*abs(x1+10)
        searchDom = [-15 -5 -3 3]
        
    case 'Matyas'
        f1 = @(x1,x2) 0.26*(x1^2+x2^2)-0.48*x1*x2
        syms x1 x2
        f = 0.26*(x1^2+x2^2)-0.48*x1*x2
        searchDom = [-10 10]
        
    case 'Levi'
        f1 = @(x1,x2) (sin(3*pi*x1))^2+(x1-1)^2*(1+(sin(3*pi*x2))^2)+(x2-1)^2*(1+(sin(2*pi*x2))^2)
        syms x1 x2
        f = (sin(3*pi*x1))^2+(x1-1)^2*(1+(sin(3*pi*x2))^2)+(x2-1)^2*(1+(sin(2*pi*x2))^2)
        searchDom = [-10 10]
        
    case 'Easom'
        f1 = @(x1,x2) -cos(x1)*cos(x2)*exp(-(x1-pi)^2-(x2-pi)^2)
        syms x1 x2
        f = -cos(x1)*cos(x2)*exp(-(x1-pi)^2-(x2-pi)^2)
        searchDom = [-100 100]
        
    case 'Eggholder'
        f1 = @(x1,x2) -(x2+47)*sin(sqrt(abs(x1/2+(x2+47))))-x1*sin(sqrt(abs(x1-(x2+47))))
        syms x1 x2
        f = -(x2+47)*sin(sqrt(abs(x1/2+(x2+47))))-x1*sin(sqrt(abs(x1-(x2+47))))
        searchDom = [-512 512]
end

g = gradient(f)
g1 = matlabFunction(g)
g1 = func2str(g1);
g1 = replace(g1,"@(x1,x2)","@(x)");
g1 = replace(g1,["x1","x2"],["x(1)","x(2)"]);
g1 = str2func(g1)


% redefine objective function syntax for use with optimization:
f2 = @(x) f1(x(1),x(2));
gif(['gif/',name,'_grad.gif']) %trying to gif
% gradient descent algorithm:
while and(gnorm>=tol, and(niter <= maxiter, dx >= dxmin))
    % calculate gradient:
    g = g1(x);
    gnorm = norm(g);
    % take step:
    xnew = x - alpha*g;
    % check step
    if ~isfinite(xnew)
        display(['Number of iterations: ' num2str(niter)])
        error('x is inf or NaN')
    end
    % plot current point
    figure(1); ezcontour(f,searchDom); axis equal; hold on
    plot([x(1) xnew(1)],[x(2) xnew(2)],'-*')
    
    %trying to gif
    gif
    
    % plot function value vs iteration
    figure(2);
    hold on
    plot(niter,f2(x),'-*')
    
    % update termination metrics
    niter = niter + 1;
    dx = norm(xnew-x);
    x = xnew;
    
end
xopt = x;
fopt = f2(xopt);
niter = niter - 1;