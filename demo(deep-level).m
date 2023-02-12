clc
clear all
close all
clc
%  % 载入训练数据
% 利用uigetfile函数交互式选取训练样本
%ile = gpuArray(0.0001);
net    = vgg16;
% Layers1 = {'relu1_2'};
% % Layers2 = {'relu2_2'};
% % Layers3 = {'relu3_3'};
% % Layers4 = {'relu4_3'};
% Layers5 = {'relu5_3'};
Layers1 = {'relu5_1'};
Layers2 = {'relu5_2'};
Layers3 = {'relu5_3'};

[Dstname,PathName,FilterIndex] = uigetfile({'*.tif';'*.jpg';'*.bmp'},'请导入训练图片','*.tif','MultiSelect','on');
if  FilterIndex==0
    return; 
end
n=length(Dstname);
%Dfeature=zeros(n,512);
for k = 1:n
    Mul= imread([PathName,Dstname{k}]);

    T1(:,:,1)=Mul(:,:,1);
    T1(:,:,2)=Mul(:,:,1);
    T1(:,:,3)=Mul(:,:,1);
    D1(k,:)= getFeatures(T1,Layers1, net);
    D11(k,:)= getFeatures(T1,Layers2, net);
    D111(k,:)= getFeatures(T1,Layers3, net);
end 

for k = 1:n
    Mul= imread([PathName,Dstname{k}]);
   
    T2(:,:,1)=Mul(:,:,2);
    T2(:,:,2)=Mul(:,:,2);
    T2(:,:,3)=Mul(:,:,2);
    D2(k,:)= getFeatures(T2,Layers1, net);
    D22(k,:)= getFeatures(T2,Layers2, net);
    D222(k,:)= getFeatures(T2,Layers3, net);
end
for k = 1:n
    Mul= imread([PathName,Dstname{k}]);
  
    T3(:,:,1)=Mul(:,:,3);
    T3(:,:,2)=Mul(:,:,3);
    T3(:,:,3)=Mul(:,:,3);
    D3(k,:)= getFeatures(T3,Layers1, net);
    D33(k,:)= getFeatures(T3,Layers2, net);
    D333(k,:)= getFeatures(T3,Layers3, net);
end
for k = 1:n
    Mul= imread([PathName,Dstname{k}]);
    T4(:,:,1)=Mul(:,:,4);
    T4(:,:,2)=Mul(:,:,4);
    T4(:,:,3)=Mul(:,:,4);
    D4(k,:)= getFeatures(T4,Layers1, net);
    D44(k,:)= getFeatures(T4,Layers2, net);
    D444(k,:)= getFeatures(T4,Layers3, net);
end
for k = 1:n
    Mul= imread([PathName,Dstname{k}]);
    NDVI= (Mul(:,:,4)-Mul(:,:,1))./(Mul(:,:,4)+Mul(:,:,1));
    T5(:,:,1)=NDVI;
    T5(:,:,2)=NDVI;
    T5(:,:,3)=NDVI;
    D5(k,:)= getFeatures(T5,Layers1, net);
    D55(k,:)= getFeatures(T5,Layers2, net);
    D555(k,:)= getFeatures(T5,Layers3, net);
end
for k = 1:n
    Mul= imread([PathName,Dstname{k}]);
    NDWI=( Mul(:,:,2)-Mul(:,:,4))./(Mul(:,:,2)+Mul(:,:,4));
    T6(:,:,1)=NDWI;
    T6(:,:,2)=NDWI;
    T6(:,:,3)=NDWI;
    D6(k,:)= getFeatures(T6,Layers1, net);
    D66(k,:)= getFeatures(T6,Layers2, net);
    D666(k,:)= getFeatures(T6,Layers3, net);
end
for k = 1:n
    Mul= imread([PathName,Dstname{k}]);
    RatioG= Mul(:,:,2)./(Mul(:,:,1)+Mul(:,:,2)+Mul(:,:,3)+Mul(:,:,4));
    T7(:,:,1)=RatioG;
    T7(:,:,2)=RatioG;
    T7(:,:,3)=RatioG;
    D7(k,:)= getFeatures(T7,Layers1, net);
    D77(k,:)= getFeatures(T7,Layers2, net);
    D777(k,:)= getFeatures(T7,Layers3, net);
end
%%%%%%%%%%%%%%%%%

A=[D1 D11 D111];
B=[D2 D22 D222];
C=[D3 D33 D333];
D=[D4 D44 D444];
E=[D5 D55 D555];
F=[D6 D66 D666];
G=[D7 D77 D777];
% % [coeffA, wnA] = pca(A);
% % [coeffB, wnB] = pca(B);
% % [coeffC, wnC] = pca(C);
% % [coeffD, wnD] = pca(D);
% % [coeffE, wnE] = pca(E);
% % [coeffF, wnF] = pca(F);
% % [coeffG, wnG] = pca(G);
% wn=[wnA wnB wnC wnD wnE wnF wnG];
H=[A B C D E F G];
[coeffH, wnH] = pca(H');