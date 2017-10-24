function B = inpaint_nans3(A)

%[mA,nA] = size(A) ;
%inan = find(isnan(A)) ;
%
%Aind = A ;
%Aind(:) = 1:(mA*nA) ;
%
%B = Aind ;

Anan = isnan(A) ;

countAw = ~[Anan(2:end,:); ones(size(A(1,:)))] ;
countAs = ~[ones(size(A(1,:))); Anan(1:end-1,:)] ;
countAa = ~[Anan(:,2:end), ones(size(A(:,1)))] ;
countAd = ~[ones(size(A(:,1))), Anan(:,1:end-1)] ;
countA = countAw+countAa+countAs+countAd ;

Az = A ;
Az(isnan(A)) = 0 ;
Aw = [Az(2:end,:); zeros(size(Az(1,:)))] ;
As = [zeros(size(Az(1,:))); Az(1:end-1,:)] ;
Aa = [Az(:,2:end), zeros(size(Az(:,1)))] ;
Ad = [zeros(size(Az(:,1))), Az(:,1:end-1)] ;
Asum = Aw+As+Aa+Ad ;

B = Asum ./ countA ;
B(countA == 0) = nan ;
B(~isnan(A)) = A(~isnan(A)) ;


