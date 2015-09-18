function [ ] = SavePosToBin( fileToLoad, savePrefix)
%SavePosToBin loads the complete game into workspace and saves it to files
%with prefix savePrefix
%
% for frame(
for section = 1:2
    for team=1:2
        for player=1:11
            varname=strcat('team_',num2str(team),'_player_',num2str(player),'_section_',num2str(section));
            fid = fopen(fileToLoad, 'r');
            eval(strcat(varname,' = parseTeam( section ,fid, team,  player );'));
            %assignin ('base',varname,parseTeam(section,fid,team,player));
            fclose(fid);
            save(strcat(savePrefix,varname),varname)
            clear(varname);
        end
    end
ballname=strcat('ball_','section_',num2str(section));
fid = fopen(fileToLoad, 'r');
eval(strcat(ballname,'= parseBall( section, fid );'));
%assignin ('base',ballname,parseBall(section,fid));
fclose(fid);
save(strcat(savePrefix,ballname),ballname');
clear(ballname);
end
end
