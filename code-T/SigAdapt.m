
function [sigm1,sigm1U,sigm1L]=SigAdapt(ud_pos,sigm1,sigm1max,sigm1min)
% eps=0.1*norm(sigm1max-sigm1min);
sigm1U=sigm1max;
sigm1L=sigm1min;
if ud_pos>1         
    if sigm1-sigm1L<eps
        sigm1L=0.618*sigm1L;
%         sigm1L=max(0.618*sigm1L,sigm1min);
    end
    sigm1U=sigm1;
    sigm1=sigm1L+0.618*(sigm1U-sigm1L);
else
    if ud_pos==0
        if sigm1U-sigm1<eps
            sigm1U=sigm1U/0.618;
        end
        sigm1L=sigm1;
        sigm1=sigm1+0.618*(sigm1U-sigm1);
    end
end