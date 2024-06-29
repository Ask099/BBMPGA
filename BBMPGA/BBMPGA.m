function score = demo1_nsga2(i, p,w,mp)
clc
close all
rng(i, "twister")
popsize = 100;
Problem = p(w);
X0 = Problem.lower+(Problem.upper-Problem.lower).*rand(popsize,Problem.D);
Y0 = Problem.CalObj(X0);
P.getX = @(population) population(:,1:Problem.D);
P.getY = @(population) population(:,Problem.D+1:Problem.D+Problem.M);
P.Population = [X0 Y0];
Archive=[];
[P.Population,FrontNo,CrowdDis] = EnvironmentalSelection(P,popsize,Problem);
while Problem.calcount<Problem.maxFE
    fprintf("FE:%d/MaxFE:%d\n",Problem.calcount,Problem.maxFE);
    MatingPool = TournamentSelection(2,popsize,FrontNo,-CrowdDis);
    Offspring_X  = GA(P.getX(P.Population(MatingPool,:)),Problem.lower,Problem.upper);
    Offspring_Y  = Problem.CalObj(Offspring_X);
    P.Population = [P.Population; Offspring_X Offspring_Y];
    [P.Population,FrontNo,CrowdDis] = EnvironmentalSelection(P,popsize,Problem);
    Archive=updateArchive(Problem,Archive,P,100);
end
disp('The MPIGD metric of the population')
objs=P.getY(P.Population);
% objs = [objs;Archive];
[temp,~]=size(objs);
objs=objs(MPNDsort(Problem,objs,temp)==1,:);
score = mp(objs,Problem);
end