function [filepath_FT, filepath_conds, filename] = file_path(azim, elev, vel)

%   Create string for path to all data files
filefolder_FT = "../../Data/2018-08-26 Data/FT Data/"; 
filefolder_conds = "../../Data/2018-08-26 Data/Conds Data/conds_"; 

filename = sprintf("%daz_%del_%dv", azim, elev, vel); 

filepath_FT = sprintf("%s%s", filefolder_FT, filename);
filepath_conds = sprintf("%s%s", filefolder_conds, filename);


end
