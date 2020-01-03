function [Xk, Pk] = updateNext(Xk, K, z, H, Pk)

if ~isempty(z)
Xk = Xk + K * (z - H * Xk); %Updating the estimation(next state)
Pk = Pk - K * H * Pk; %Updating the covariance matrix
end
%Xk = Xk + K * (z - H * Xk); %Updating the estimation(next state)

