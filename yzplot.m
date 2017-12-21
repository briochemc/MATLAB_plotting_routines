function h = yzplot(x2d,opt)
% yzplot plots the filled contour of x2d where x2d's x-axis is latitude
% and its y-axis is depth.

%%-----------------------------------------------------%%
%%                Plot the filled contour              %%
%%-----------------------------------------------------%%
% set in larger grid and extrapolate NaNs
y2 = opt.grid.yt ;
z2 = -[opt.grid.zt sum(opt.grid.dzt) sum(opt.grid.dzt)+100] ;
A2 = [x2d;nan(2,size(x2d,2))] ;
x2d2 = extrapolate_nans_fast(extrapolate_nans_fast(A2)) ;
% plot thick contour lines first (so that these fill the gaps when printing)
contour(y2,z2,x2d2,opt.clevs,'linewidth',2) ;
hold on
h = contourf(y2,z2,x2d2,opt.clevs,'linestyle','none') ;

%%-----------------------------------------------------%%
%%  Plot the additional contours requested in options  %%
%%-----------------------------------------------------%%
if isfield(opt,'pden') % add in potential density if required
  pden2 = [opt.pden;nan(2,size(x2d,2))] ;
  contour(y2,z2,pden2-1e3,opt.pden_levs,'k') ;
end
if isfield(opt,'dash_clevs') % add in dashed
  contour(y2,z2,x2d2,opt.dash_clevs,'k--') ;
end
if isfield(opt,'black_clevs')
  [Cblack,hblack] = contour(y2,z2,x2d2,opt.black_clevs,'k') ;
  if isfield(opt,'black_clevs_labels') clabel(Cblack,hblack) ; end
end
if isfield(opt,'white_clevs')
  contour(y2,z2,x2d2,opt.white_clevs,'w') ;
end

%%-----------------------------------------------------%%
%%              Labels and Axis details                %%
%%-----------------------------------------------------%%
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

%%-----------------------------------------------------%%
%%       fill in land points (NaN) with gray color     %%
%%-----------------------------------------------------%%
% make border coordinates
yb = [opt.grid.yv(1)-opt.grid.dyt(1) opt.grid.yv] ;
zb = [opt.grid.zw opt.grid.zw(end)+opt.grid.dzt(end)] ;
zb2 = -[zb zb(end)+50 ceil((zb(end)+50)*1e-3)*1e3] ;

z_bw = zeros(size(A2)) ;
z_bw(find(isnan(A2))) = 1 ;
gray = .8*[1 1 1] ;
P = mask2poly(boolean(z_bw)) ;
orient = [0] ; % This needs to be set manually unfortunately
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

%%-----------------------------------------------------%%
%%   Add in text in bottom right corner if in options  %%
%%-----------------------------------------------------%%
% text in bot right corner
if isfield(opt,'latex')
  text(70,-5.3e3,opt.latex,'horizontalAlignment','center','fontsize',14,'interpreter','latex')
elseif isfield(opt,'txt')
  text(70,-5.5e3,opt.txt,'horizontalAlignment','center','fontsize',12)
end
