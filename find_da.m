function [ da_total,area_act,area_ref,gx,gy ] = find_da( actx, acty, refx, refy,h_fig )
%find_da : This is the correct function that takes care of the
%counter-clockwise countour
%Inputs :
%- actx, acty are the actual ankle trajectories
%- refx, refy are the gait templates
%h_fig is the figure handle
%% Check if plots are wanted
if nargin<5
    is_plot_dev=false;
else
    is_plot_dev=true;
end

%% Find deviation polygon between act and ref
[gx,gy]=polybool('xor',actx,acty,refx,refy);
%% Find the number of polygon in the deviation polygon 
sep=find(isnan(gx));
sep=[0;sep;length(gx)+1];
poly_beg=[];poly_end=[];
for i=1:length(sep)-1
    poly_beg(i)=sep(i)+1;
    poly_end(i)=sep(i+1)-1;
end
%% Find area of each deviation polygon
if is_plot_dev
    figure(h_fig);hold on;axis equal;
end
for i=1:length(poly_beg)
    da_part_x=gx(poly_beg(i):poly_end(i));
    da_part_y=gy(poly_beg(i):poly_end(i));
    da_part_area=polyarea(da_part_x,da_part_y);
    % plot each deviation area if requested
    if is_plot_dev
        plot(da_part_x,da_part_y);
    end
    % if the deviation polygon is ccw, count the area as negative
    if ispolycw(da_part_x,da_part_y)
        da_area(i)=da_part_area;
    else
        da_area(i)=-da_part_area;
    end
end
da_total=sum(  da_area);


%% Calculate the area of ref and act

[andx,andy]=poly2cw(actx,acty);
area_act=polyarea(andx,andy);

[andx,andy]=poly2cw(refx,refy);
area_ref=polyarea(andx,andy);

end

