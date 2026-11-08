function root = setup()
%SETUP Add the supported repository folders to the MATLAB path.
%
% Usage:
%   setup
%   root = setup

root = fileparts(mfilename("fullpath"));
folders = {
    root
    fullfile(root, "data_prepare")
    fullfile(root, "optimal_bidding_control")
    fullfile(root, "visualise")
    fullfile(root, "visualise_cn")
    };

for idx = 1:numel(folders)
    if isfolder(folders{idx})
        addpath(folders{idx});
    end
end
end
