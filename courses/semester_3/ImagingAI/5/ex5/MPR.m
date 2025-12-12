% 
% This file is part of the ASM-Toolbox and is provided "as is" and comes
% with absolutely no warranty. Use at your own risk.
%
% Author: Florian Bernard (f.bernard@hochschule-trier.de)
% Copyright: Institute for Innovative Informatics Applications (i3a), Trier
%            University of Applied Sciences
%

classdef MPR < handle
% Object used for MPR Visualisation. For usage example see test() function
% at the bottom.

    properties (Access = protected) 
        volImage = [];

        axesObj = [];
        
        scrollDim = [];
        scrollLines = [];
        mprPlanes = [];
        
        onScrollListeners = {};
        scrollListenersIdentifiers = {};
    end
    
    methods
        function this = MPR(axesObj, volImage)
            this.axesObj = axesObj;
            this.volImage = volImage;
            
            updateMPR(this);
        end

        function valid = isValid(this)
            % checks if axes handle is still a valid handle. Might become
            % invalid due to serialisation, if so, we must discard the MPR
            % instance and create a new one (as user).
            valid = ishandle(this.axesObj);
        end
        
        function volIm = getVolImage(this)
            volIm = this.volImage;
        end
        
        function setVolImage(this, volIm)
            this.volImage = volIm;
            updateMPR(this);
        end
        
        function addOnScrollListener(this, listenerFct, uniqueIdentifier)
            if ( exist('uniqueIdentifier', 'var') )
                % We have given an identifier, thus we want that only a
                % single callback with this uniqueIdentifier is kept. This
                % is useful as a single instance of MPR object can be used 
                % for plotting different data objects (merely the model
                % data, namely the volume, is changed using the setVolImage
                % if a different data objects is displayed. Thus, we might
                % want to cleanup previous callbacks.
                for i=1:numel(this.scrollListenersIdentifiers)
                    if ( strcmpi(this.scrollListenersIdentifiers{i}, uniqueIdentifier) )
                        this.scrollListenersIdentifiers(i) = [];
                        this.onScrollListeners(i) = [];
                    end
                end
                this.scrollListenersIdentifiers{end+1} = uniqueIdentifier;
                this.onScrollListeners{end+1} = listenerFct;
            else
                this.scrollListenersIdentifiers{end+1} = num2str(rand());
                this.onScrollListeners{end+1} = listenerFct;
            end
        end
        
        function updateMPR(this)
            userData = get(this.axesObj, 'UserData');
            if ( ~isfield(userData, 'xyzSlices') )
                xdim = size(this.volImage,1);
                ydim = size(this.volImage,2);
                zdim = size(this.volImage,3);

                userData.xyzSlices = [floor(xdim/2), floor(ydim/2), floor(zdim/2)];
            end
            xyzSlices = userData.xyzSlices;

            if ( ~isfield(userData, 'gaussLayer') )
                userData.gaussLayer = 0;
            end
            gaussLayer = userData.gaussLayer;
            
            set(this.axesObj, 'UserData', userData);
            
            xyzSlicesLayer = getXyzSlicesLayer(this, ...
                                               xyzSlices, ...
                                               gaussLayer, ...
                                               this.volImage);
            % delete previously drawn objects  
            delete(this.mprPlanes(ishandle(this.mprPlanes)));
            delete(this.scrollLines(ishandle(this.scrollLines)));
            this.scrollLines = [];
            
            xSlice = xyzSlicesLayer(1); 
            ySlice = xyzSlicesLayer(2); 
            zSlice = xyzSlicesLayer(3); 

            siz(1) = size(this.volImage,1);
            siz(2) = size(this.volImage,2);
            siz(3) = size(this.volImage,3);
            
            set(gcf, 'CurrentAxes', this.axesObj);
    
            prevCallback = get(gcf, 'WindowScrollWheelFcn');

            % create x-y plane
            slice = zSlice;
            cdata = squeeze(this.volImage(:,:,zSlice));
            x = [1 1; siz(1) siz(1)];
            y = [1 siz(2); 1 siz(2)];
            z = [slice slice; slice slice];
            this.mprPlanes(3) = surface('XData',x,'YData',y,'ZData',z,... % x-y plane
                                    'CData',cdata,...
                                    'FaceColor','texturemap',...
                                    'EdgeColor','none',...
                                    'LineStyle','none',...
                                    'Marker','none',...
                                    'MarkerFaceColor','none',...
                                    'MarkerEdgeColor','none',...
                                    'CDataMapping','scaled');

            % create x-z plane
            slice = ySlice;
            cdata = squeeze(this.volImage(:,ySlice,:));
            x = [1 1; siz(1) siz(1)];
            y = [slice slice; slice slice];
            z = [1 siz(3);1 siz(3)];
            this.mprPlanes(2) = surface('XData',x,'YData',y,'ZData',z,... % x-z plane
                                    'CData', cdata,...
                                    'FaceColor','texturemap',...
                                    'EdgeColor','none',...
                                    'LineStyle','none',...
                                    'Marker','none',...
                                    'MarkerFaceColor','none',...
                                    'MarkerEdgeColor','none',...
                                    'CDataMapping','scaled');


            % create y-z plane
            slice = xSlice;
            cdata = squeeze(this.volImage(slice,:,:));
            x = [slice slice; slice slice];
            y = [1 1; siz(2) siz(2)];
            z = [1 siz(3); 1 siz(3)];
            this.mprPlanes(1) = surface('XData',x,'YData',y,'ZData',z,... (y-z plane)
                                    'CData', cdata,...
                                    'FaceColor','texturemap',...
                                    'EdgeColor','none',...
                                    'LineStyle','none',...
                                    'Marker','none',...
                                    'MarkerFaceColor','none',...
                                    'MarkerEdgeColor','none',...
                                    'CDataMapping','scaled');

            view(3);
            axis equal;
            axis vis3d;
            axis off;

            colormap jet;

            xlabel x
            ylabel y
            zlabel z
            set(this.axesObj, 'Clim', [min(this.volImage(:)) max(this.volImage(:))]);
%             set(this.axesToPlot, 'UserData', xyzSlices);

            % current figure renderer need to be set to opengl
            set(gcf,'renderer','opengl');  

            for i=1:3
                set(this.mprPlanes(i), 'ButtonDownFcn', @(x,y) mprCallback(x, y, this, prevCallback, i));
                
                % associate instance of MPR object with each mprPlane
                set(this.mprPlanes(i), 'UserData', this);
            end
        %     set(mprPlanes(3), 'ButtonDownFcn', @(x,y) mprCallback(x, y, prevCallback, axesToPlot, mprPlanes, 3, volImage));
        %     set(mprPlanes(1), 'ButtonDownFcn', @(x,y) mprCallback(x, y, prevCallback, axesToPlot, mprPlanes, 1, volImage));

        %     addlistener(axesToPlot , 'scrollEvent', {@updateMPR mprPlanes, volImage, dim, SliceNo});

%             set(gcf, 'WindowScrollWheelFcn', @(x,y) mprCallback(x, y, this, prevCallback, nan));
%             handle.listener(gcf,'WindowScrollWheelFcn', @(x,y) mprCallback(x, y, this, prevCallback, nan))
        end
        
%         function invokeWindowScrollWheelFcns(
        function mprCallback(hObj, evt, this, prevCallback, newScrollDim) %#ok<INUSL>
            % this argument is just a dummy as it is overriden later on
            % anyways
            persistent lastClickedSurface;
            
            if ( strcmpi(get(hObj,'Type'), 'surface') )
                lastClickedSurface = hObj;
            end
            if ( ~ishandle(lastClickedSurface) )
                return;
            end
            % get instance of MPR object associated with hObj
            this = get(lastClickedSurface, 'UserData');
            if ( isempty(this) )
                return;
            end
            
            % check if mouse cursor is within axes
            mousePosition = get(gcf, 'CurrentPoint');
            [relativePosition, ~] = relativeCoordinatesToAbsoluteCoordinates(gcf, this.axesObj);

            if ( mousePosition(1) >= relativePosition(1) && mousePosition(1) <= relativePosition(1) + relativePosition(3) && ...% x direction
                 mousePosition(2) >= relativePosition(2) && mousePosition(2) <= relativePosition(2) + relativePosition(4) ) % y direction
                set(gcf, 'WindowScrollWheelFcn', ...
                    @(x,y) mprCallback(x, y, this, prevCallback, nan));
            else
                return; % outside axes, do nothing
            end
            
            
            surfHandle = this.mprPlanes(this.scrollDim);
            if ( exist('newScrollDim', 'var') && ~isnan(newScrollDim)) % if scrollDim has been changed by mouse-click, update it
                this.scrollDim = newScrollDim;
            end
            if ( ~isempty(this.scrollDim) ) % highlight scrollDim surface by green lines around plane
                x = get(this.mprPlanes(this.scrollDim), 'XData');
                y = get(this.mprPlanes(this.scrollDim), 'YData');
                z = get(this.mprPlanes(this.scrollDim), 'ZData');

                
                % xlabel x, ylabel y, zlabel z, axis on;
                if ( ~isempty(this.scrollLines) && ishandle(this.scrollLines) )
                    delete(this.scrollLines);
                end

                if this.scrollDim == 3 % x-y plane
                    xLine = [x(1,1), x(2,1), x(2,1), x(1,1), x(1,1)];
                    yLine = [y(1,1), y(1,1), y(1,2), y(1,2), y(1,1)];
                    zLine = repmat(z(1,1),1,5);
                    this.scrollLines = line(xLine,yLine,zLine,'Color', [0 1 0], 'LineWidth', 2);

                elseif this.scrollDim == 2 % x-z plane
                    xLine = [x(1,1), x(2,1), x(2,1), x(1,1), x(1,1)];
                    yLine = repmat(y(1,1),1,5);
                    zLine = [z(1,1), z(1,1), z(1,2), z(1,2), z(1,1)];
                    this.scrollLines = line(xLine,yLine,zLine,'Color', [0 1 0], 'LineWidth', 2);
                elseif this.scrollDim == 1 % y-z planel
                    xLine = repmat(x(1,1),1,5);
                    yLine = [y(1,1), y(1,1), y(2,1), y(2,1), y(1,1)];
                    zLine = [z(1,1), z(1,2), z(1,2), z(1,1), z(1,1)];
                    this.scrollLines = line(xLine,yLine,zLine,'Color', [0 1 0], 'LineWidth', 2);
                end%if
            end

                % call previous callback
        %         prevCallback(hObj,evt);
            if ( isfield(evt, 'VerticalScrollCount') ) % actual scroll
                userData = get(this.axesObj, 'UserData');
                xyzSlices = userData.xyzSlices;
                gaussLayer = userData.gaussLayer;
                
                xyzSlices(this.scrollDim) = ...
                    xyzSlices(this.scrollDim) - (evt.VerticalScrollCount.*2^gaussLayer);

                userData.xyzSlices = xyzSlices;
                
                xyzSlicesLayer = floor(xyzSlices./2^(gaussLayer));
                if ( any(xyzSlicesLayer < 1) || any(xyzSlicesLayer > size(this.volImage)) )
                    return;
                end
                set(this.axesObj, 'UserData', userData);
         
                
                sliceNo = xyzSlicesLayer(this.scrollDim);
                if this.scrollDim == 3 % x-y plane
                    cdata = squeeze(this.volImage(:,:,sliceNo));
                    z = [sliceNo sliceNo; sliceNo sliceNo];
                    set(surfHandle, 'ZData',z,'CData',cdata);    % update ZData of AxialPlane

                    set(this.scrollLines, 'ZData', repmat(xyzSlicesLayer(this.scrollDim),1,5));
                elseif this.scrollDim == 2 % x-z plane
                    cdata = squeeze(this.volImage(:,sliceNo,:));
                    y = [sliceNo sliceNo; sliceNo sliceNo];
                    set(surfHandle,'YData',y,'CData',cdata);    % update ZData of AxialPlane

                    set(this.scrollLines, 'YData', repmat(xyzSlicesLayer(this.scrollDim),1,5));
                elseif this.scrollDim == 1 % y-z planel
                    cdata = squeeze(this.volImage(sliceNo,:,:));
                    x = [sliceNo sliceNo; sliceNo sliceNo];
                    set(surfHandle,'XData',x,'CData',cdata);    % update ZData of AxialPlane

                    set(this.scrollLines, 'XData', repmat(xyzSlicesLayer(this.scrollDim),1,5));
                end
                
                % call registered onScrollListeners
                for i=1:numel(this.onScrollListeners)
                    listenerFcn = this.onScrollListeners{i};
                    listenerFcn(hObj,evt, xyzSlices);
                end
            end
        end

        function xyzSlicesLayer=getXyzSlicesLayer(this, xyzSlices, gaussLayer, volImage)
            xyzSlicesLayer = floor(xyzSlices./2^(gaussLayer));

            imSize = size(volImage);
            xyzSlicesLayer(xyzSlicesLayer<1) = 1;
            xyzSlicesLayer(xyzSlicesLayer>imSize) = imSize(xyzSlicesLayer>imSize);
        end
    end
    
end

function test()
%%
    figure;
    axesObj = axes;
    
    % we want to store the image layer and the xyz slices in the axes
    % object, as we want to keep these values even if we change the
    % volImage property
%     userData.gaussLayer = 0;
%     userData.xyzSlices = [40 40 40];
%     set(axesObj, 'UserData', userData);
    
    volImage = rand(100,100,100);

    
    mpr=MPR(axesObj, volImage);
    mpr=MPR(axesObj, volImage);
%%  we can change the actual image but we keep our current scroll position
    mpr.setVolImage(rand(100,100,100))
%%
end
