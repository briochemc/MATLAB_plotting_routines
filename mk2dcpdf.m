% plot the model tracer concentration against 
% the observed tracer concentration using a joint 
% cumulative density distribution

function [D, X, Y] = mk2dcpdf(data_obs, data_mod, ikeep, dVt)

data = [data_obs(ikeep),data_mod(ikeep)];

dmin = min(data(:));
dmax = max(data(:));

%pad the range by 5% because kernel may be estimated outside bounds.
scale = dmax-dmin;
dmin = dmin - 0.05*scale;
dmax = dmax + 0.05*scale;

% call Botev's routine modified to include the grid-box volume weight
[bandwidth,density,X,Y] = mykde2d(data,200,[dmin dmin],[dmax dmax],dVt(ikeep));

% calculate cumulative density from density
dx = X(3,5)-X(3,4); dy = Y(4,2)-Y(3,2);
[q,i] = sort(density(:)*dx*dy,'descend');
D = density;
D(i) = 1-cumsum(q);
