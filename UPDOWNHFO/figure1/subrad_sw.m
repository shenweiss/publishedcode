function [radout] = subrad(rad1, rad2)
deg1=rad2deg(rad1);
deg2=rad2deg(rad2);
if deg1 < 0 
		deg1 = -(-deg1);
		if deg1 <= -180 
        deg1 = 360 + deg1;
    	else 
		deg1 = deg1;
		if deg1 > 180 
        deg1 = -360 + deg1; 
        end;
        end;
end;
if deg2 < 0 
		deg2 = -(-deg2);
		if deg2 <= -180 
        deg2 = 360 + deg2;
    	else 
		deg2 = deg2;
		if deg2 > 180
        deg2 = -360 + deg2; 
        end;
        end;
end;
	if deg1 - deg2 > 180 
    radout = (deg1 - deg2) - 360;
    elseif deg1 - deg2 < -180 
    radout = (deg1 - deg2) + 360;
    else 
    radout = deg1 - deg2;
    end;
radout=deg2rad(radout);

