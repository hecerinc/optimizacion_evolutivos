% output = ES(fitness,lb,ub,mu,lambda,max_evals,crossoverProb,mutProb)
%
% fitness: the fitness fuction (handle)
% lb: lower bounds
% ub: upper bounds
% mu: mu parents
% lambda: lambda children
% max_evals: maximum number of fitness evaluations
% crossoverProb: crossover probability
% mutationProb: mutation probability

function output = ES(fitness,lb,ub,mu,lambda,max_evals,crossoverProb,mutProb)

    rng(0);
	best_sol = zeros(1,10); 
	best_fitness = inf;
	start = clock;
	
	randInRange = @(min, max, r, c) min + (max-min).*rand(r, c);
	
	% Generate random population
	minRange = -100;
	maxRange = 100;
	P = randInRange(minRange, maxRange, mu, 10);
	
	
	for i = 1:max_evals
		children = [];
		childN = 0;
		while childN < lambda
			% Select two parents randomly
			indices = ceil(randInRange(0, mu, 1, 2));
			if rand(1) <= crossoverProb
				% Cross the parents!
				child = 0.5.*P(indices(1),:) + 0.5.*P(indices(2), :);
				% Wanna mutate?
				if rand(1) <= mutProb
					child = child + .5*normrnd(0,1);
                end
            else
                child = P(indices(1), :);
                % Wanna mutate?
				if rand(1) <= mutProb
					child = child + .5*normrnd(0,1);
                end
            end
            childN = childN + 1;
            children = [children; child];
        end
        %Agarrar los mejores P
		total = [P; children];
        %[rows,col] = size(children)
        [rows,~] = size(total);
        fitnessCalc = [];
        for row = 1 : rows       
            fitnessCalc = [fitnessCalc ; [fitness(total(row,:)) row]];
        end
        fitnessCalc
        sortedFitness = sortrows(fitnessCalc);
        totalaux = sortedFitness(1:mu, :);
        
        for j = 1:mu
            P(j,:) = total(ceil(totalaux(j,2)),:);
        end
        
        P
		% total = [total fitnessCalc'];

	end
	


	output = struct;
	output(1).Students = {'Jorge Vazquez','Andres Sosa','Hector Rincon'};
	output(1).IDs = {'A01196160','A01176075','A01088760'};
	output(1).best_sol = P(1,:);
	output(1).best_fitness = fitness(P(1,:));
	output(1).time = etime(clock,start);

end
