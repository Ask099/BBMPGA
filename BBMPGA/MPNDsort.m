function FrontNo=MPNDsort(Problem,Pops,popsize)
FrontNotemp=zeros(popsize,Problem.M/Problem.DM);%
for i=1:Problem.DM
    FrontNotemp(:,i)=NDSort(Pops(:,1+(i-1)*Problem.M/Problem.DM:i*Problem.M/Problem.DM),popsize);
end
FrontNo=NDSort(FrontNotemp,popsize);
end