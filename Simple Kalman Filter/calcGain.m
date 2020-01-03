function kGain = calcGain(Pk, H, R)
%
%
est_err = Pk * H'; %Converting the covariance matrix to the domain of maeasurement


kGain = est_err / (H * est_err + R);
%kGain =eye(2,2)