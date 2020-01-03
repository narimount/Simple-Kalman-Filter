deltaT = 0.1
F = [1, deltaT; 0, 1]; %State Matrix
Pk_1 = [10, 0; 0,1];
for i = 1:29
    Pk = F * Pk_1 * F'; %Calculating the state error covariance matrix
    Pk_1 = Pk;
end
disp(Pk)