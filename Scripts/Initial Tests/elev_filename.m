function [filepath] = elev_filename(azim, elev, vel)

%   Create string for path to all data files
filefolder = "/Users/Raghul/Documents/Imperial/Aeronautics - 3rd Year/UROP/Data/"; 

filename = sprintf("%daz_%del_%dv", azim, elev, vel); 

filepath = sprintf("%s%s", filefolder, filename);

end
