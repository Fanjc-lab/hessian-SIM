clearvars -except filename pathname sigma mu Progressbar
disp('TV reconstruction, please wait...');
filename_notif=filename(1:end-4);
filename_result=['re-' filename_notif];
%% initialization
iter_Bregman = 1e2;     %number of iteration
siranu=mu;
zbei=0;
lamda = 1;
gexiang=1;
y = double(imreadstack([pathname '\SIM-Wiener\' filename_result '.tif'])); %observed data 						
tic
ymax=max(y(:));
y=y./ymax;

%% initialization
[sx,sy,sz] = size(y);
sizex=[sx,sy,sz] ;
x = zeros(sizex);                  %start point

ztidu(:,:,1)=1;
ztidu(:,:,2)=-1;

%FFT of difference operator
xfft=fftn([1 -1],sizex).*conj(fftn([1 -1],sizex));
yfft=fftn([1 -1]',sizex).*conj(fftn([1 -1]',sizex));
zfft=fftn(ztidu,sizex).*conj(fftn(ztidu,sizex));
%% iteration
for TH=1:1
    clear gap
    b7 = zeros(sizex);
    b8 = zeros(sizex);
    b9 = zeros(sizex);
    d7 = zeros(sizex);
    d8 = zeros(sizex);
    d9 = zeros(sizex);
    x = zeros(sizex);
    for ii = 1:iter_Bregman
%% renew x
        frac = (siranu/lamda)*(y);                 %为什么是减不是加
    %     frac = frac./scale;
        frac = frac-back_diff(d7-b7,1,2);
        frac = frac-back_diff(d8-b8,1,1);
        frac = frac-(zbei)*back_diff(d9-b9,1,3);
        frac = fftn(frac);
        
        divide = (siranu/lamda);
        divide = divide + xfft;
        divide = divide + yfft;
        divide = divide + (zbei)*zfft;
        x = real(ifftn(frac./divide));

%% calculate the dirivative of x
        u_x = forward_diff(x,1,2);
        u_y = forward_diff(x,1,1);
        u_z = forward_diff(x,1,3);
%         u_xx(1:2,:,:)=0;
%         u_xx(end-1:end,:,:)=0;
%         u_yy(:,1:2,:)=0;
%         u_yy(:,end-1:end,:)=0;
%         u_zz(:,:,1:2)=0;
%         u_zz(:,:,end-1:end)=0;
%% renew d
% 'gexiang == 1' means anisotropic;'otherwise' means isotropic
    if gexiang==1
         signd7 = abs(u_x+b7)-1/lamda;
        signd7(signd7<0)=0;
        signd7=signd7.*sign(u_x+b7);
        d7=signd7;
        
        signd8 = abs(u_y+b8)-1/lamda;
        signd8(signd8<0)=0;
        signd8=signd8.*sign(u_y+b8);
        d8=signd8;
        
        signd9 = abs(u_z+b9)-1/lamda;
        signd9(signd9<0)=0;
        signd9=signd9.*sign(u_z+b9);
        d9=signd9;
    else
        s_T = sqrt((u_x+b7).^2+(u_y+b8).^2+(u_z+b9).^2*(zbei));
        d7 = lamda*s_T.*(u_x+b7)./(lamda*s_T+1+eps);
        d8 = lamda*s_T.*(u_y+b8)./(lamda*s_T+1+eps);
        d9 = lamda*s_T.*(u_z+b9)./(lamda*s_T+1+eps);
    end
    
%% renew frac
        b7 = b7+(u_x-d7);
        b8 = b8+(u_y-d8);
        b9 = b9+(u_z-d9);
%         ii
        x(x<0) = 0;
        waitbar(ii/iter_Bregman , Progressbar, 'TV reconstruction');
    end
end
toc
imwritestack(x.*ymax, [pathname '\SIM-TV\TV_' filename_notif '.tif']);
disp('TV reconstruction Successfully');