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
		while  childN < lambda
			% Select two parents randomly
			indices = floor(randInRange(minRange, maxRange, 1, 2));
			if rand(1) <= crossoverProb
				% Cross the parents!
				child = 0.5.*P(indices(1),:) + 0.5.*P(indices(2), :);
				% Wanna mutate?
				if rand(1) <= mutProb
					child = child + .5*normrnd(0,1);
				end
				children = [children; child];
				childN = childN+1;
			end

		end
		total = [P; children];
		fitnessCalc = fitness(total);
		% total = [total fitnessCalc'];
		
		
	end
	


	output = struct;
	output(1).Students = {'Jorge Vazquez','Andres Sosa','Hector Rincon'};
	output(1).IDs = {'A01196160','A01176075','A01088760'};
	output(1).best_sol = best_sol;
	output(1).best_fitness = best_fitness;
	output(1).time = etime(clock,start);

end
