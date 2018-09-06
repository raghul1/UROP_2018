function [filepath] = file_path_1(mass, vel)

%   Create string for path to all data files
filefolder = "../../Data/2018-08-21 Data/"; 

filename = sprintf("%dm_%dv", mass, vel); 

filepath = sprintf("%s%s", filefolder, filename);

end
