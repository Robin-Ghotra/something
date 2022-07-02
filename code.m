clear; clc; close all; format compact

load Downloads/StartingCells.mat

while(1)
    figure(1);
    set(gca,'Color',[0.2 0.50 1])
    hold on
    xlim([0 20])
    ylim([0 20])
    xticks([2:2:20])
    yticks([2:2:20])
    StartMarksPlotting = flipud(StartingCells);
    for i = 1:size(StartMarksPlotting,1)
        for j = 1:size(StartMarksPlotting,2)
            if StartMarksPlotting(i,j)>0
                plot(j,i,'ko','MarkerSize',12,'MarkerFaceColor','black')
            end
        end
    end
    m = input('Press s to step the simulation or q to quit: ','s');
    if m == 's' || m == 'S'
        r = StartingCells;
        steps = 1;
        alive = 0;
        for n = 1:steps
            for i = 1:length(r)
                for j = 1:length(r)
                    alive = CellStat(r,i,j);
                    if alive <= 1 && r(i,j) == 1
                        r(i,j) = 0;
                    elseif alive > 3 && r(i,j) == 1
                        r(i,j) = 0;
                    elseif alive == 3 && r(i,j) == 0
                        r(i,j) = 1;
                    end
                end
            end
        end
        figure(2);
        set(gca,'Color',[0.2 0.50 1])
        hold on
        xlim([0 20])
        ylim([0 20])
        xticks([2:2:20])
        yticks([2:2:20])
        newplot = flipud(r);
        for i = 1:size(newplot,1)
            for j = 1:size(newplot,2)
                if newplot(i,j)>0
                    plot(j,i,'ko','MarkerSize',12,'MarkerFaceColor','black')
                end
            end
        end
        pause(0.5)
    elseif m == 'q' || m == 'Q'
        disp('Thanks for simulating life')
        break
    else
        disp('Bad value entered. Please enter s or q')
    end
end

%functions
function [alive] = CellStat(grid,row,col)
%this function finds the number of alive cells surrounding it
alive = 0;
    for i = row-1:row+1
        %making sure the cell is on the board
        if i <= 0 || i > length(grid)
            continue
        end

        for j = col-1:col+1
            if j <= 0 || j > length(grid)
                continue
            end
            %making sure the cell is not counted as its own neighbour
            if i == row && j == col
                continue
            end
            if grid(i,j) == 1
                alive = alive + 1;
            end
        end
    end
end
