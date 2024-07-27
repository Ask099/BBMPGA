function [Population,FrontNo,CrowdDis] = EnvironmentalSelection(P,N,Problem)
    objs=P.getY(P.Population);
    [Nin,M]= size(objs);
    FrontNo_low = zeros(Nin,Problem.DM);
    cons=[];
    Infeasible = any(cons>0,2);
    objs(Infeasible,:) = repmat(max(objs,[],1),sum(Infeasible),1) + repmat(sum(max(0,cons(Infeasible,:)),2),1,M);
    temp=Problem.M/Problem.DM;
    for i =1:Problem.DM
        FrontNo_low(:,i) = NDSort(objs(:,1+(temp)*(i-1):temp*i),cons,Nin);
    end
    
    Diff_FrontNo=(max(FrontNo_low,[],2)-min(FrontNo_low,[],2));
    n=max(Diff_FrontNo);
    alpha = 1-0.8*power(Problem.calcount/Problem.maxFE,2); 
    Diff_FrontNo=Diff_FrontNo>(n*alpha);
    objs=objs+Diff_FrontNo.*max(max(objs))*10;
    for i =1:Problem.DM
        FrontNo_low(:,i) = NDSort(objs(:,1+(temp)*(i-1):temp*i),cons,Nin);
     end
                                                                                    
    [FrontNo,MaxFNo] = NDSort(FrontNo_low,cons,N); 
    Next = FrontNo < MaxFNo;
    CrowdDis = CrowdingDistance(objs,FrontNo);

    Last     = find(FrontNo==MaxFNo);
    [~,Rank] = sort(CrowdDis(Last),'descend');
    Next(Last(Rank(1:N-sum(Next)))) = true;
    Population = P.Population(Next,:);
    FrontNo    = FrontNo(Next);
    CrowdDis   = CrowdDis(Next);
  end
