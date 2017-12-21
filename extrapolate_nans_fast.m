function B = extrapolate_nans_fast(A)
% extrapolate_nans_fast fills in the NaNs (of a 2d matrix) that have
% at least one non-NaN neighbour. The filling value is the mean
% of the non-NaN neighbours.
% This function is used to fill in the edges of the contour plots used
% for example in horizontal maps (xyplot) and zonal averages (yzplot).
% This function is faster than inpain_nans because it only fills one
% "layer" of neighbours, the rationale being that NaNs further away will
% be masked by the land boxes that should be filled with a light gray.

%%-----------------------------------------------------%%
%%          Count the number of neighbours             %%
%%-----------------------------------------------------%%
Anan = isnan(A) ;
countAw = ~[Anan(2:end,:); ones(size(A(1,:)))] ;
countAs = ~[ones(size(A(1,:))); Anan(1:end-1,:)] ;
countAa = ~[Anan(:,2:end), ones(size(A(:,1)))] ;
countAd = ~[ones(size(A(:,1))), Anan(:,1:end-1)] ;
countA = countAw+countAa+countAs+countAd ;

%%-----------------------------------------------------%%
%%            Sum the value of neighbours              %%
%%-----------------------------------------------------%%
Az = A ;
Az(isnan(A)) = 0 ;
Aw = [Az(2:end,:); zeros(size(Az(1,:)))] ;
As = [zeros(size(Az(1,:))); Az(1:end-1,:)] ;
Aa = [Az(:,2:end), zeros(size(Az(:,1)))] ;
Ad = [zeros(size(Az(:,1))), Az(:,1:end-1)] ;
Asum = Aw+As+Aa+Ad ;

%%-----------------------------------------------------%%
%%            Take the mean = sum / count              %%
%%-----------------------------------------------------%%
B = Asum ./ countA ;
B(countA == 0) = nan ;
B(~isnan(A)) = A(~isnan(A)) ;
