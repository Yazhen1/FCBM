function [ feat ] = FG(im)

feat = [];

scalenum =1;
  K1 = 0.005;
 C1 = (K1*255)^2;
window = fspecial('gaussian',7,7/6);
window = window/sum(sum(window));
 
 
 for itr_scale = 1:scalenum
  mu            = filter2(window, im, 'same');
  mu_sq         = mu.*mu;
  sigma         = sqrt(abs(filter2(window, im.*im, 'same') - mu_sq));
  structdis     = (im-mu)./(sigma+C1);  %¹éÒ»»¯Í¼Ïñ

  shifts                   = [ 0 1;1 0 ; 1 1; -1 1];
 for itr_shift =1:4
  shifted_structdis        = circshift(structdis,shifts(itr_shift,:));
  pair                     = structdis(:).*shifted_structdis(:);
  [alpha leftstd rightstd] = estimateaggdparam(pair);
  const                    =(sqrt(gamma(1/alpha))/sqrt(gamma(3/alpha)));
  meanparam                =(rightstd-leftstd)*(gamma(2/alpha)/gamma(1/alpha))*const;
  feat                     =[feat alpha meanparam leftstd^2 rightstd^2];
  
 end 
 end 


end
