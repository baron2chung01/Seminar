function [xopt,fopt,niter,gnorm,dx,terminateBy,runtime] = optimizer_nognorm(x0,funcName,method,mode)

% funcName: name of test function
% method: grad/newt
% mode: plot/time


% maximum number of allowed iterations
maxiter = 100;
% step size for gradient descent( 0.33 causes instability, 0.2 quite accurate)
alpha = 0.1;
% minimum allowed difference of x_n+1-x_n
dxmin = 1e-4;
% initialize gradient norm, optimization vector, iteration counter, perturbation
x = x0; niter = 0; dx = inf;
% define the objective function

[f1 f searchDom] = testFunc(funcName);

% both method requires computing gradient
g = gradient(f);
g1 = matlabFunction(g);
g1 = func2str(g1);
g1 = replace(g1,"@(x1,x2)","@(x)");
g1 = replace(g1,["x1","x2"],["x(1)","x(2)"]);
g1 = str2func(g1);
% if method='newt', need to compute hessian
if method == "newt"
    hess = hessian(f);
    h1 = inv(hess);
    h1 = matlabFunction(h1);
    h1 = func2str(h1);
    h1 = replace(h1,"@(x1,x2)","@(x)");
    h1 = replace(h1,["x1","x2"],["x(1)","x(2)"]);
    h1 = str2func(h1);
end
% plot objective function contours for visualization:

% redefine objective function syntax for use with optimization:
f2 = @(x) f1(x(1),x(2));

if mode == "time"
    iniTime = clock
end

while and(niter <= maxiter, dx >= dxmin)
    % if method = 'newt', need tocalculate hessian inverse:
    
    % both method requires calculating gradient:
    g = g1(x);
    % take gradient descent step:
    if method == "grad"
        xnew = x - alpha*g
    end
    % take newton's method step:
    if method == "newt"
        if funcName == "Matyas"
            hess = [1.3e+1,1.2e+1;1.2e+1,1.3e+1];
            xnew = x - hess*g;
        else
            hess = h1(x);
            xnew = x - hess*g
        end
    end
    % check step
    if xnew(1) < searchDom(1) || xnew(1) > searchDom(2) || xnew(2) < searchDom(1) || xnew(2) > searchDom(2)
        display(['Number of iterations: ' num2str(niter)])
        error('x is out of search domain')
    end
    % plot current point
    if mode == "plot"
        figure(1); ezcontour(f,[-4 0]); axis equal; hold on
        
        if method == "grad"
            quiver(x(1),x(2),xnew(1)-x(1),xnew(2)-x(2),'b','ShowArrowHead','off','Marker','x','LineWidth',1)
        elseif method == "newt"
            quiver(x(1),x(2),xnew(1)-x(1),xnew(2)-x(2),'k','ShowArrowHead','off','Marker','x','LineWidth',1)
        end
        % making gif
        if niter == 0
            % plot the xmin
            plot(1,1,'-p','MarkerSize',15,'MarkerFaceColor','red')
            filepath = sprintf('gif_compare_1/%s_%s_%s_%s.gif',funcName,method,mat2str(x0),num2str(alpha));
            if method == "newt"
                gif(filepath,'DelayCount',5,'LoopCount',1)
            elseif method == "grad"
                gif(filepath,'LoopCount',1)
            end
        else
            if method == "newt"
                gif('DelayCount',5,'LoopCount',1)
            elseif method == "grad"
                gif('LoopCount',1)
            end
        end

        % plot function value vs iteration
        figure(2); handle = figure(2);
        hold on
        if method == "grad"
            plot(niter,f2(x),'b-x','MarkerSize',5)
        elseif method == "newt"
            plot(niter,f2(x),'k-*')
        end
        handle = yline(0,'r--');
    end
    % update termination metrics
    niter = niter + 1;
    dx = norm(xnew-x);
    x = xnew;
    
end
hold off
% determine what causes termination
if dx < dxmin
    terminateBy = 'Difference between x_n+1 and x_n too small'
elseif niter > maxiter
    terminateBy = 'Maximum number of iterations reached'
end
xopt = x
fopt = f2(xopt)
niter = niter - 1
if mode == "time"
    runtime = double(etime(clock, iniTime))
elseif mode == "plot"
    runtime = ''
end
end