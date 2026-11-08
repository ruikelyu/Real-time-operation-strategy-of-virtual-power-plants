function report = check_installation(varargin)
%CHECK_INSTALLATION Check prerequisites for the included MATLAB demo.
%
% Usage:
%   report = check_installation
%   report = check_installation("RequireSolver", false)

parser = inputParser;
addParameter(parser, "RequireSolver", true, @(value) islogical(value) || isnumeric(value));
parse(parser, varargin{:});
requireSolver = logical(parser.Results.RequireSolver);

root = setup();
report = struct();
report.root = root;
report.matlabVersion = version;
report.hasYalmip = exist("sdpsettings", "file") ~= 0;
report.hasGurobi = exist("gurobi", "file") ~= 0 || ...
    exist("gurobi_setup", "file") ~= 0;
report.hasPreprocessedData = isfile(fullfile(root, "data_prepare", "param_day_21.mat"));
report.hasDemoScript = isfile(fullfile(root, "optimal_bidding_control", "main.m"));

fprintf("Repository: %s\n", root);
fprintf("MATLAB: %s\n", report.matlabVersion);
printStatus("YALMIP", report.hasYalmip);
printStatus("Gurobi", report.hasGurobi);
printStatus("Included processed data", report.hasPreprocessedData);
printStatus("Optimal-control demo", report.hasDemoScript);

missing = strings(0, 1);
if ~report.hasYalmip
    missing(end + 1) = "YALMIP";
end
if requireSolver && ~report.hasGurobi
    missing(end + 1) = "Gurobi";
end
if ~report.hasPreprocessedData
    missing(end + 1) = "data_prepare/param_day_21.mat";
end
if ~report.hasDemoScript
    missing(end + 1) = "optimal_bidding_control/main.m";
end

if ~isempty(missing)
    error("VPP:MissingInstallation", ...
        "Missing required components: %s. See README.md for installation instructions.", ...
        strjoin(missing, ", "));
end

fprintf("Installation check passed.\n");
end

function printStatus(label, isAvailable)
if isAvailable
    fprintf("[OK]   %s\n", label);
else
    fprintf("[MISS] %s\n", label);
end
end
