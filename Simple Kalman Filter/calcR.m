function R = calcR(R)
a = 6378137;
b = 6356752.3142;
f = (a-b)/a;
le0 = 38.940226;
%le0 = 38.930650;
e = sqrt(f*(1-f));
Rlat = (a*(1-e^2)*2*pi)/(360*(1-e^2*(sin(le0))^2)^1.5);
HEIGHT = 54;
R(1,1) = R(1,1) * (Rlat + HEIGHT); 

