
function [cosVal,sinVal] = cordic_rotn(theta_in);

    bitLen = 16;
    fracLen = 14;
    cordicIterationNum = 16;
    fipref('NumberDisplay','RealWorldValue','NumericTypeDisplay','none','FimathDisplay','full');

    if(theta_in > 2*pi)
        N = floor(theta_in / (2*pi));
        theta_in = theta_in - 2*N*pi;
    end
    
    if(theta_in > pi/2 && theta_in <= pi)
        theta = (pi)-theta_in;
    elseif(theta_in > pi && theta_in <= 3*pi/2)
        theta = (3*pi/2)-theta_in;
    elseif(theta_in > 3*pi/2 && theta_in <= 2*pi)
        theta = (2*pi)-theta_in;
    else
        theta = theta_in;
    end

    cordic_angle = zeros(cordicIterationNum);
    X = fi(0.607252935103139,1,bitLen,fracLen);
    Y = fi(0,1,bitLen,fracLen);
    theta = fi(theta,1,bitLen,fracLen);
    
    for j=1:cordicIterationNum
        cordic_angle(j) = fi(atan(2.^ (-(j-1))),1,bitLen,fracLen);
    end
    
    for m=0:cordicIterationNum-1
        if(theta>=0)
            sign = fi(+1,1,bitLen,fracLen);
        else
            sign = fi(-1,1,bitLen,fracLen);
        end
        x_shift=fi((2^-m)*X,1,bitLen,fracLen);
        y_shift=fi((2^-m)*Y,1,bitLen,fracLen);
        X = fi(X-sign*y_shift,1,bitLen,fracLen);
        Y = fi(Y+sign*x_shift,1,bitLen,fracLen);
        theta = fi(theta-sign*cordic_angle(m+1),1,bitLen,fracLen);
    end

    if(theta_in > pi/2 && theta_in <= pi)
        cosVal = -X;
        sinVal = Y;
    elseif(theta_in > pi && theta_in <= 3*pi/2)
        cosVal = -Y;
        sinVal = -X;
    elseif(theta_in > 3*pi/2 && theta_in <= 2*pi)
        cosVal = X;
        sinVal = -Y;
    else
        cosVal = X;
        sinVal = Y;
    end
end
