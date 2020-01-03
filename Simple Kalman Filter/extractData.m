function [accelaration, GPS_time, GPS_location, GPS_velocity] = extractData()
% Importing the acceleration data
accelaration = importdata('driving_force.txt'); 
%Opening GPS info, extracting and saving time, location and velocity
%fields.
GPS_time =[];
GPS_velocity = [];
GPS_location = [];
fileID = fopen('GPS_measurement_data.txt');
while ~feof(fileID)
    y= textscan(fileID, '%f','delimiter','\n');
    GPS_time = [GPS_time,y];
    for i=1:2
        fgets(fileID);
    end
end
fclose(fileID);

fileID = fopen('GPS_measurement_data.txt');
while ~feof(fileID)
    fgets(fileID);
    y= textscan(fileID, '%s%f%f%s%f%s%f%f%f%f%s%f%s%f%s','delimiter',',');
    GPS_location = [GPS_location,y(3)];
    fgets(fileID);
end
fclose(fileID);

fileID = fopen('GPS_measurement_data.txt');
while ~feof(fileID)
    fgets(fileID);
    fgets(fileID);
    y= textscan(fileID, '%s%s%s%s%s%f%s%f%s',1,'delimiter',',');
    GPS_velocity = [GPS_velocity,y(8)];
    fgets(fileID);
   
end
fclose(fileID);

GPS_time = cell2mat(GPS_time);
GPS_location = cell2mat(GPS_location);
GPS_velocity = cell2mat(GPS_velocity);
