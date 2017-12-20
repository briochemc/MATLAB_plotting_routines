function h = yzplot_v4(x2d,opt)
% latlon is 2x1 and is 0 or 1 for plotting lat and lon

% make border coordinates
yb = [opt.grid.yv(1)-opt.grid.dyt(1) opt.grid.yv] ;
zb = [opt.grid.zw opt.grid.zw(end)+opt.grid.dzt(end)] ;

%zb2 = -[-10 zb 5800 6000] ;
zb2 = -[ zb 5800 6000] ;
y2 = opt.grid.yt ;
%z2 = -[0 opt.grid.zt 5750 5850] ;
z2 = -[opt.grid.zt 5750 5850] ;

%A2 = [nan(1,size(x2d,2));x2d;nan(2,size(x2d,2))] ;
A2 = [x2d;nan(2,size(x2d,2))] ;

x2d2 = inpaint_nans3(A2) ;
if isfield(opt,'pden')
  contourf(y2,z2,x2d2,opt.clevs,'linestyle','none') ;
  h = gca;
else
  if isfield(opt,'one_in_two')
    contourf(y2,z2,x2d2,opt.clevs,'linestyle','none') ;
    h = gca;
    hold on
    contour(y2,z2,x2d2,opt.clevs(1:2:end),'k','linewidth',1.5) ;
    contour(y2,z2,x2d2,opt.clevs(2:2:end),'k','linewidth',0.5) ;
  else
    h = contourf(y2,z2,x2d2,opt.clevs) ;
  end
end


% make nanContourf

% labels and axis stuff
set(gca,'YTick',opt.yTicks);
set(gca,'YTickLabel',opt.yTickLabels);
set(gca,'XTick',opt.xTicks);
set(gca,'XTickLabel',opt.xTickLabels);
if isfield(opt,'fontsize')
  ylabel(opt.ylabel,'fontsize',opt.fontsize);
  xlabel(opt.xlabel,'fontsize',opt.fontsize);
else
  ylabel(opt.ylabel);
  xlabel(opt.xlabel);
end

% Add potential density contours if given in opt
if isfield(opt,'pden')
  hold on
  pden2 = [opt.pden;nan(2,size(x2d,2))] ;
  contour(y2,z2,pden2-1e3,opt.pden_levs,'linecolor',[0 0 0]) ;
end

% Add white contours if wclevs is given in opt
if isfield(opt,'wclevs')
  hold on
  if (numel(wclevs) == 1) opt.wclevs = kron([1 1],opt.wclevs) ; end ;
  contour(y2,z2,x2d2,opt.wclevs,'linecolor',[1 1 1]) ;
end

% fill in coast
% filling nans
% black and white z
z_bw = zeros(size(A2)) ;
z_bw(find(isnan(A2))) = 1 ;
% gray color to fill the nans ; can be changed
gray = .8*[1 1 1] ;
%h = image(x3,opt.opt.grid.yt,z_bw) ;
P = mask2poly(boolean(z_bw)) ;
%numel(P) 
orient = [0] ;
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
  XY = [yb(XY2(:,1))'  zb2(XY2(:,2))'] ;
  fill(XY(:,1),XY(:,2),gray) ;
end

axis([-90 90 zb2(end) zb2(1)]);
%set(gca,'TickDir','out');
%caxis(opt.clevs([2 end]));


% text in bot right corner
if isfield(opt,'latex')
  text(70,-5.3e3,opt.latex,'horizontalAlignment','center','fontsize',14,'interpreter','latex')
elseif isfield(opt,'txt')
  text(70,-5.5e3,opt.txt,'horizontalAlignment','center','fontsize',12)
end


