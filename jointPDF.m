function h = jointPDF(xobs,xmod,v) 
% jointPDF(xobs,xmod,v)

[D, X, Y] = mk2dcpdf(xobs, xmod, 1:numel(xmod), v) ;
clevs = 0:.1:1 ;
h = contourf(X(1,:),Y(:,1),D,clevs,'LineStyle','none') ;
%caxis(minmax2(clevs))

