%The Dog matrix
function dist=dogdistm(x,sigm1)
sigm2=2*sigm1;
[num,~]=size(x);
if num==1
   Distx=0; 
else
    Distx=squareform(pdist(x,'cosine'));%ori
    %Distx=squareform(pdist(x,'seuclidean'));%lp优势
end
dist=(1/(sqrt(2*pi)*sigm1))*exp(-1/2*(Distx/sigm1^2))-(1/(sqrt(2*pi)*sigm2))*(exp(-1/2*(Distx/sigm2^2)));
