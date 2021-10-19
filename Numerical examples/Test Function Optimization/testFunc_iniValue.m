function [x0 xgmin fgmin] = testFunc_iniValue(name)

% x0 returns array consists of multiple initial points
% xgmin returns the argmin(f)
% fgmin returns the min(f)

switch name
    case 'Ackley'
        x0 = [[-4 -4],[3 3],[-2 2]]
        xgmin = [0 0]
        fgmin = 0
        
    case 'Beale'
        x0 = [[-4 -4],[3 3],[-2 2]]
        xgmin = [3 0.5]
        fgmin = 0
        
    case 'Crossthetray'
        x0 = [[-4 -4],[3 3],[-2 2]]
        xgmin = [[1.34941 -1.34941],[1.34941 1.34941],[-1.34941 1.34941],[-1.34941 -1.34941]]
        fgmin = -2.06261
        
    case 'Goldstein'
        x0 = [[-1.5 -1.5],[1 1],[-0.5 0.5]]
        xgmin = [0 -1]
        fgmin = 3
        
    case 'Matyas'
        x0 = [[-4 -4],[3 3],[-2 2]]
        xgmin = [0 0]
        fgmin = 0
        
    case 'Levi'
        x0 = [[-4 -4],[3 3],[-2 2]]
        xgmin = [1 1]
        fgmin = 0
        
end
end