function [f1 f searchDom] = testFunc(name)
% f1: function handle of the test function
% f: symbolic expression of the test function
% searchDom: range of plot


switch name
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

end
end