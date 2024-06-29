function Archive=updateArchive(Problem,Archive,P,popsize)
pops=P.getY(P.Population);
Archive=[Archive;pops];
[len,~]=size(Archive);
Archive=Archive(MPNDsort(Problem,Archive,len)==1,:);
[len,~]=size(Archive);
if len>popsize
    Crodis=CrowdingDistance(Archive,ones(len,1));
    [~,index]=sort(Crodis,"descend");
    Archive=Archive(index(1:popsize),:);
end
end