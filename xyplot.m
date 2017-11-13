function h = xyplot_v5(x2d,opt)
% latlon is 2x1 and is 0 or 1 for plotting lat and lon

% make border coordinates
yb = [opt.grid.yv(1)-opt.grid.dyt(1) opt.grid.yv] ;
xb = [opt.grid.xu(1)-opt.grid.dxt(1) opt.grid.xu] ;

% shift to have no basin split
nsh = 12; % number of grid lon by which to shift east
A2 = [x2d(:,nsh:end),x2d(:,1:nsh-1)];
xb2 = [xb(nsh:end),362+xb(1:nsh-1)] ;
x = opt.grid.xt ;
x2 = [x(nsh:end),360+x(1:nsh-1)] ;
x3 = [x2(end)-360 x2 x2(1)+360] ;
xb3 = [xb2(end)-360 xb2 xb2(1)+360] ;
A3 = [A2(:,end) A2 A2(:,1)] ;

x2d2 = inpaint_nans3(A3) ;
if ~isfield(opt,'linestyle')
  contourf(x3,opt.grid.yt,x2d2,opt.clevs,'linestyle','none') ;
else
  contourf(x3,opt.grid.yt,x2d2,opt.clevs,opt.linestyle) ;
end
% make nanContourf

% labels and axis stuff
set(gca,'YTick',opt.yTicks);
set(gca,'YTickLabel',opt.yTickLabels);
set(gca,'XTick',opt.xTicks);
set(gca,'XTickLabel',opt.xTickLabels);

% fill in coast
% filling nans
% black and white z
z_bw = zeros(size(A3)) ;
z_bw(find(isnan(A3))) = 1 ;
% gray color to fill the nans ; can be changed
gray = .8*[1 1 1] ;
%h = image(x3,opt.grid.yt,z_bw) ;
P = mask2poly(boolean(z_bw)) ;
orient = [1 1 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0] ;
for ii = 1:numel(orient)
  hold on
  if orient(ii) 
    Ps(ii) = polyDiag2polySquare(P(ii)) ; 
  else
    P(ii).X = fliplr(P(ii).X) ;
    P(ii).Y = fliplr(P(ii).Y) ;
    Ps(ii) = polyDiag2polySquare(P(ii)) ; 
  end
  XY2 = [Ps(ii).X' Ps(ii).Y']+.5 ;
  XY = [xb3(XY2(:,1))'  yb(XY2(:,2))'] ;
  fill(XY(:,1),XY(:,2),gray) ;
end

axis([xb2(1) xb2(end) -90 90]);
%set(gca,'TickDir','out');
%caxis(opt.clevs([2 end]));
h = gca;


if isfield(opt,'latex')
  text(40,40,opt.latex,'horizontalAlignment','left','verticalAlignment','baseline','interpreter','latex','fontsize',16)
end
