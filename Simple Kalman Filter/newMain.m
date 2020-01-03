%Extracting data
[acc, GPS_time, GPS_loc, GPS_vel] = extractData();

%Determining the initial values and constant 
[Pk_1, Xk_1, Q, R] = feedOriginal();

%Turning R into the format of our states ( meters and m/s)
R = calcR(R);

%Matching the GPS data times with our time interval and 
%determining to which interval they belong 
fixedTime = fix(GPS_time*10);

%As I changed the unit of GPS data to (m, m/s) H will be identity matrix.
H = eye(2,2);

%Before Measurement update
predicted_loc =[];
predicted_vel =[];

%After Measurement Update
updated_loc =[];
updated_vel =[];

holdK =[];
domain =[];
for i = 1:size(acc)
    
    %Estimation
    [Xk, Pk] = predictNext (Xk_1, Pk_1, acc(i), Q);
    
        predicted_loc = [predicted_loc, Xk(1)];
        predicted_vel =[predicted_vel, Xk(2)];
    
    %Calculating the Kalman gain
    K = calcGain(Pk, H, R);
    holdK = [holdK, K];
    %Measurment update; If there is no GPS data, this part will only
    %updates the state covariance matrix P
    index = find(~(fixedTime-i)); %Returns the index of that element
    %of GPS_time which is equal to i, if there is any
    
    if (isempty(index))
        [Xk_1, Pk_1] = updateNext(Xk, K, [], H, Pk);
    else
        domain = [domain, i];
        %Turning R into the format of our states ( meters and m/s)
        %domain = [domain, i]
        z = calcZ([GPS_loc(index);GPS_vel(index)]);
        [Xk_1, Pk_1] = updateNext(Xk, K, z , H, Pk);

    end
        updated_loc =[updated_loc, Xk_1(1)];
        updated_vel = [updated_vel, Xk_1(2)];
    
end
X = linspace(1, size(predicted_loc,2), size(predicted_loc,2));
figure
plot(X, predicted_loc, 'blue');
hold on
%plot(X, updated_loc, 'green');
%hold on
%plot(domain, updated_loc)


for i= 1:size(domain,2)
    scatter(domain(i), updated_loc(domain(i)), 'g*');
    hold on
end



