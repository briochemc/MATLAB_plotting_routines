function Ps = polyDiag2polySquare(P)

dX = diff(P.X) ;
dY = diff(P.Y) ;

Ps.X = [] ;
Ps.Y = [] ;

if numel(P.X) == 1
  Ps.X = P.X + [-.5 -.5 .5 .5 -.5] ;
  Ps.Y = P.Y + [-.5 .5 .5 -.5 -.5] ;
else
  for ii = 1:numel(P.X)-1
    n = abs(dX(ii)) ;
    if dX(ii)>0 & dY(ii)==0
      Ps.X = [Ps.X P.X(ii)-.5 P.X(ii+1)+.5] ;
      Ps.Y = [Ps.Y P.Y(ii)+.5 P.Y(ii+1)+.5] ;
    elseif dX(ii)<0 & dY(ii)==0
      Ps.X = [Ps.X P.X(ii)+.5 P.X(ii+1)-.5] ;
      Ps.Y = [Ps.Y P.Y(ii)-.5 P.Y(ii+1)-.5] ;
    elseif dX(ii)==0 & dY(ii)>0
      Ps.X = [Ps.X P.X(ii)-.5 P.X(ii+1)-.5] ;
      Ps.Y = [Ps.Y P.Y(ii)-.5 P.Y(ii+1)+.5] ;
    elseif dX(ii)==0 & dY(ii)<0
      Ps.X = [Ps.X P.X(ii)+.5 P.X(ii+1)+.5] ;
      Ps.Y = [Ps.Y P.Y(ii)+.5 P.Y(ii+1)-.5] ;
    elseif dX(ii)>0 & dY(ii)>0
      for jj = 1:n
        Ps.X = [Ps.X P.X(ii)+jj-1+[-.5 .5 .5]] ;
        Ps.Y = [Ps.Y P.Y(ii)+jj-1+[.5 .5 1.5]] ;
      end
    elseif dX(ii)>0 & dY(ii)<0
      for jj = 1:n
        Ps.X = [Ps.X P.X(ii)+jj-1+[.5 .5 1.5]] ;
        Ps.Y = [Ps.Y P.Y(ii)-jj+1+[.5 -.5 -.5]] ;
      end
    elseif dX(ii)<0 & dY(ii)<0
      for jj = 1:n
        Ps.X = [Ps.X P.X(ii)-jj+1+[.5 -.5 -.5]] ;
        Ps.Y = [Ps.Y P.Y(ii)-jj+1+[-.5 -.5 -1.5]] ;
      end
    elseif dX(ii)<0 & dY(ii)>0
      for jj = 1:n
        Ps.X = [Ps.X P.X(ii)-jj+1+[-.5 -.5 -1.5]] ;
        Ps.Y = [Ps.Y P.Y(ii)+jj-1+[-.5 .5 .5]] ;
      end
    end
  end
end
