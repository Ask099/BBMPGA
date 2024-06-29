classdef MPMOP7< handle
    %% Properties  
    properties (SetAccess = immutable)
        M;
        DM;
        lower;
        upper;
        D;
        encoding;
        maxFE;
    end
    
    properties (SetAccess = private)
        calcount;
    end


    methods
        %% Initialization
        function obj = MPMOP7(D)
            obj.calcount=0;
            obj.M = 6;
            obj.D =D;
            obj.DM=3;
            obj.maxFE=1000*obj.D*obj.DM;
            obj.lower    = zeros(1,obj.D);
            obj.upper    = ones(1,obj.D);
            obj.lower (:,1)=1;
            obj.upper(:,1)=4;
            obj.encoding = 'real';
        end
        %% Calculate objective values for each party
        function PopObj = CalObj(obj,PopDec)
            M=obj.M;
            assert(obj.calcount<=obj.maxFE, "Maximum number of evaluations exceeded.");
            PopObj(:,[1:M/3])=MPMOP_Value('MPMOP1', PopDec(), 0);
            PopObj(:,[M/3+1:2*M/3])=MPMOP_Value('MPMOP1', PopDec(), 1);
            PopObj(:,[2*M/3+1:M])=MPMOP_Value('MPMOP1', PopDec(), 2);
            obj.calcount = obj.calcount + size(PopDec,1);
        end
        %% Sample reference points on Pareto front
        function P = PF(obj)
            t1=0;
            t2=1;
            t3=2;
            [~,true_y1,true_y2,true_y3]=true_PS(obj.D,'MPMOP7',t1,t2,t3);
            P=[true_y1,true_y2,true_y3];
        end
        
       %% Sample reference points on Pareto optimal set
        function P = PS(obj)
            t1=0;
            t2=1; 
            t3=2;
            P=true_PS(obj.D,'MPMOP7',t1,t2,t3);
        end
        
    end
end