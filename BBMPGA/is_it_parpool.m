delete(gcp('nocreate'));
parpool("local",15);
problems = {@MPMOP1, @MPMOP2, @MPMOP3, @MPMOP4,@MPMOP5, @MPMOP6, @MPMOP7, @MPMOP8,@MPMOP9, @MPMOP10, @MPMOP11};
results = zeros(1, 30);
for n=[10,30,50]
    for p=1:11
        parfor i=1:30
            results(i)=demo1_nsga2(i,problems{p},n,@MPIGD);
        end
        dlmwrite(sprintf('nsga2-std(%d)[%d].txt',n, p), results);
        dlmwrite(sprintf('nsga2-std(%d)[%d].txt',n,p), mean(results), '-append');
        dlmwrite(sprintf('nsga2-std(%d)[%d].txt',n,p), std(results), '-append');
    end
end
problems= {@MPUAV1,@MPUAV2,@MPUAV3,@MPUAV4,@MPUAV5,@MPUAV6};
    for p=1:6
        parfor i=1:30
            results(i)=demo1_nsga2(i,problems{p},1,@MPHV);
        end
        dlmwrite(sprintf('nsga2-mpuav-std[%d].txt', p), results);
        dlmwrite(sprintf('nsga2-mpuav-std[%d].txt',p), mean(results), '-append');
        dlmwrite(sprintf('nsga2-mpuav-std[%d].txt',p), std(results), '-append');
    end

