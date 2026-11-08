function outputFile = run_demo(varargin)
%RUN_DEMO Run the included optimal real-time operation example.
%
% Usage:
%   run_demo
%   run_demo("MakePlot", false)
%
% The demo uses the included processed data for day 21 and saves the
% result under results/result_optimal_bid_ctrl_sep_.mat.

parser = inputParser;
addParameter(parser, "MakePlot", true, @(value) islogical(value) || isnumeric(value));
parse(parser, varargin{:});
makePlot = logical(parser.Results.MakePlot);

root = setup();
check_installation("RequireSolver", true);

outputDirectory = fullfile(root, "results");
if ~isfolder(outputDirectory)
    mkdir(outputDirectory);
end

fprintf("\nRunning the optimal real-time operation example...\n");
fprintf("This optimization may take several minutes with Gurobi.\n");

oldDirectory = pwd;
cleanup = onCleanup(@() cd(oldDirectory)); %#ok<NASGU>
cd(fullfile(root, "optimal_bidding_control"));
run("main.m");

outputFile = fullfile(outputDirectory, "result_optimal_bid_ctrl_sep_.mat");
if ~isfile(outputFile)
    error("VPP:MissingOutput", ...
        "The example finished without creating %s.", outputFile);
end

if makePlot
    data = load(outputFile, "result");
    if isfield(data.result, "actualProfit")
        figure("Name", "VPP demonstration results", "Color", "white");
        plot(data.result.actualProfit, "LineWidth", 1.2);
        grid on;
        xlabel("Hour");
        ylabel("Actual profit");
        title("Optimal real-time VPP operation");
        figureFile = fullfile(outputDirectory, "demo_profit.png");
        exportgraphics(gcf, figureFile, "Resolution", 150);
        fprintf("Figure: %s\n", figureFile);
    else
        fprintf("Result does not contain actualProfit; skipping demo figure.\n");
    end
end

fprintf("Result: %s\n", outputFile);
fprintf("Demo completed successfully.\n");
end
