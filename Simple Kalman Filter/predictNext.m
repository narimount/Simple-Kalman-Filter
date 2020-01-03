function [Xk, Pk] = predictNext (Xk_1, Pk_1, acc, Q)

deltaT = 0.1;
F = [1, deltaT; 0, 1]; %State Matrix
B = [0.5 * deltaT^2; deltaT]; %Control Matrix
Xk = F * Xk_1 + B * acc; %Estimating next state using Newton rules
Pk = F * Pk_1 * F' + Q; %Calculating the state error covariance matrix
