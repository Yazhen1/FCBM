clc
clear all
clc


[Dstname,PathName,FilterIndex] = uigetfile({'*.tif';'*.tif'},'Çëµ¼ÈëÑµÁ·Í¼Æ¬','*.tif','MultiSelect','on');
if  FilterIndex==0
    return;
end    
n=length(Dstname);

% wn=zeros(n,40);
for k = 1:n
    
    Mul=imread([PathName,Dstname{k}]);
    
   NDVI= (Mul(:,:,4)-Mul(:,:,1))./(Mul(:,:,4)+Mul(:,:,1));
   %%%%%  B>RatioG>G>NIR>R>>NDVI>NDWI
   NDWI=( Mul(:,:,2)-Mul(:,:,4))./(Mul(:,:,2)+Mul(:,:,4));
   RatioG= Mul(:,:,2)./(Mul(:,:,1)+Mul(:,:,2)+Mul(:,:,3)+Mul(:,:,4));
   % I = (0.1.*Mul(:,:,1)+0.1.*Mul(:,:,2)+0.6.*Mul(:,:,3)+0.1.*RatioG+0.1.*Mul(:,:,4));
    %%%I = (0.15.*Mul(:,:,1)+0.3.*Mul(:,:,2)+0.3.*Mul(:,:,3)+0.15.*AAA+0.1.*Mul(:,:,4));
I = (0.135.*Mul(:,:,1)+0.199.*Mul(:,:,2)+0.220.*Mul(:,:,3)+0.135.*Mul(:,:,4)+0.061.*NDVI+0.051.*NDWI+0.199.*RatioG);
    %I=(0.142.*Mul(:,:,1)+0.137.*Mul(:,:,2)+0.148.*Mul(:,:,3)+0.147.*Mul(:,:,4)+0.142.*NDVI+0.147.*NDWI+0.137.*RatioG); 
%I=RatioG;
    pic =double(I); 
     %pic =double(imread([PathName,Dstname{k}]));
  %  pic =imread([PathName,Dstname{k}]);  
%     wn(k,:)= FG(pic);
wn0(k,:)=FGSR(pic);
   %  wn(k,:)=lgp_feature(pic);
       %  wn(k,:)= u1(pic);
  %wn(k,:)= TLLFD_feature(pic);
end
for k = 1:n
    
       Mul=imread([PathName,Dstname{k}]);
       I = Mul(:,:,1);
    pic =double(I); 
wn1(k,:)=FG(pic);
   %  wn(k,:)=lgp_feature(pic);
       %  wn(k,:)= u1(pic);
  %wn(k,:)= TLLFD_feature(pic);
end
for k = 1:n
    
    Mul=imread([PathName,Dstname{k}]);
    I = Mul(:,:,2);
    pic =double(I); 
wn2(k,:)=FG(pic);

end
for k = 1:n
    Mul=imread([PathName,Dstname{k}]);
    I = Mul(:,:,3);
    pic =double(I); 

wn3(k,:)=FG(pic);

end
for k = 1:n
    
    Mul=imread([PathName,Dstname{k}]);
    I = Mul(:,:,4);
    pic =double(I); 
wn4(k,:)=FG(pic);

end

   for k = 1:n
   
   Mul=imread([PathName,Dstname{k}]);
   NDVI= (Mul(:,:,4)-Mul(:,:,1))./(Mul(:,:,4)+Mul(:,:,1));
    pic =double(NDVI); 
wn5(k,:)=FG(pic);

   end
for k = 1:n
    
    Mul=imread([PathName,Dstname{k}]);
    NDWI=( Mul(:,:,2)-Mul(:,:,4))./(Mul(:,:,2)+Mul(:,:,4));
    
    pic =double(NDWI); 
wn6(k,:)=FG(pic);

end
for k = 1:n
    
    Mul=imread([PathName,Dstname{k}]);
       RatioG= Mul(:,:,2)./(Mul(:,:,1)+Mul(:,:,2)+Mul(:,:,3)+Mul(:,:,4));
    pic =double(RatioG); 
wn7(k,:)=FG(pic);

end
   
   
   
%wn=[wn0 wn1 wn2 wn3 wn4];
wn=[wn0 wn1 wn2 wn3 wn4 wn5 wn6 wn7];
%wn=[wn0 wn1];