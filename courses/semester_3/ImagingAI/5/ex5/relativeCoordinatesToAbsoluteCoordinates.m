% 
% This file is part of the ASM-Toolbox and is provided "as is" and comes
% with absolutely no warranty. Use at your own risk.
%
% Author: Florian Bernard (f.bernard@hochschule-trier.de)
% Copyright: Institute for Innovative Informatics Applications (i3a), Trier
%            University of Applied Sciences
%
       
function [relativePosition absolutePosition]=relativeCoordinatesToAbsoluteCoordinates(rootParentFigureHandle, childHandle)

    relativePosition = [0 0 0 0];

    % find x and y location
    currentHandle = childHandle;
    while currentHandle ~= rootParentFigureHandle
       u = get(currentHandle, 'Units');

       set(currentHandle, 'Units', 'pixels');
       tPos = get(currentHandle, 'Position');
       relativePosition(1:2) = relativePosition(1:2) + tPos(1:2);
       set(currentHandle, 'Units', u);

       currentHandle = get(currentHandle, 'Parent');
    end

    % find x and y width
    u = get(childHandle, 'Units');
    set(childHandle, 'Units', 'pixels');
    absolutePosition = get(childHandle, 'Position');
    set(childHandle, 'Units', u);

    relativePosition(3:4) = absolutePosition(3:4);

end
