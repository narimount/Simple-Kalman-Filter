[acc, GPS_time, GPS_loc, GPS_vel] = extractData();
[Pk_1, Xk_1, Q, R] = feedOriginal();
fixedTime = fix(GPS_time*10);
H = calcH();
predicted_loc =[];
updated_loc =[];
predicted_vel =[];
updated_vel =[];

for i = 1:size(acc)
    [Xk, Pk] = predictNext (Xk_1, Pk_1, acc(i), Q);
    
    predicted_loc = [predicted_loc, Xk(1)];
    predicted_vel =[predicted_vel, Xk(2)];
    
    index = find(~(fixedTime-i)); %Returns the index of that element
    %of GPS_time which is equal to i, if there is any
    
    K = calcGain(Pk, H, R);
    
    if (isempty(index))
        [Xk_1, Pk_1] = updateNext(Xk, K, [0;0], H, Pk);
        
    else
        [Xk_1, Pk_1] = updateNext(Xk, K, [GPS_loc(index);GPS_vel(index)] , H, Pk);
    end
    
    updated_loc =[updated_loc, Xk_1(1)];
    updated_vel = [updated_vel, Xk_1(2)];
    
end
X = linspace(1, 3001, 3001);
%plot(X, updated_loc);
plot(X, updated_vel);