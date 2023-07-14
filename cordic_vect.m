function [mag,ph] = cordic_vect_floating_pt(x_in,y_in);

    bitLen = 16;
    fracLen = 14;
    cordicIterationNum = 16;
    fipref('NumberDisplay','RealWorldValue','NumericTypeDisplay','none','FimathDisplay','full');

    if(x_in < 0 && y_in >0 || x_in < 0 && y_in <0)
    	dirn = -1;
    else
    	dirn = +1;
    end

    cordic_angle = zeros(cordicIterationNum);
    X = fi(x_in*0.607252935103139,1,bitLen,fracLen);
    Y = fi(y_in*0.607252935103139,1,bitLen,fracLen);
    theta = fi(0,1,bitLen,fracLen);
    
    for j=1:cordicIterationNum
        cordic_angle(j) = fi(atan(2.^ (-(j-1))),1,bitLen,fracLen);
    end
    
    for m=0:cordicIterationNum-1
        if(Y>=0)
            sign = fi(+1,1,bitLen,fracLen);
        else
            sign = fi(-1,1,bitLen,fracLen);
        end
        x_shift=fi((2^-m)*X,1,bitLen,fracLen);
        y_shift=fi((2^-m)*Y,1,bitLen,fracLen);
        X = fi(X+dirn*sign*y_shift,1,bitLen,fracLen);
        Y = fi(Y-dirn*sign*x_shift,1,bitLen,fracLen);
        theta = fi(theta+dirn*sign*cordic_angle(m+1),1,bitLen,fracLen);
    end

    if(x_in < 0)
        mag = -1*X;
        ph = theta;
    else
        mag = X;
        ph = theta; 
    end

end
