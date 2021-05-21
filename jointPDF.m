function h = jointPDF(xobs, xmod, v, varargin) 
% jointPDF(xobs,xmod,v)

% Defaults
options = struct('clevs', 0:0.05:1, 'LineStyle','none') ;

%# read the acceptable names
optionNames = fieldnames(options);

%# count arguments
nArgs = length(varargin);
if round(nArgs/2)~=nArgs/2
   error('EXAMPLE needs propertyName/propertyValue pairs')
end

for pair = reshape(varargin,2,[]) %# pair is {propName;propValue}
   inpName = lower(pair{1}); %# make case insensitive

   if any(strcmp(inpName, optionNames))
      %# overwrite options. If you want you can test for the right class here
      %# Also, if you find out that there is an option you keep getting wrong,
      %# you can use "if strcmp(inpName,'problemOption'),testMore,end"-statements
      options.(inpName) = pair{2};
   else
      error('%s is not a recognized parameter name', inpName)
   end
end

% get density from 2D kernel density estimator
[D, X, Y] = mk2dcpdf(xobs, xmod, 1:numel(xmod), v) ;

% plot contourf
h = contourf(X(1,:), Y(:,1), D, options.clevs, 'LineStyle', options.LineStyle) ;

