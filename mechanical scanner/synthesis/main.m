% randomly inputed parameters 
l1 = 19.8491; bAng1 = 0; a1 = 0.4902; bAng2 = -15.36774; l2 = 3.7241; l3 = 26.2051; l4 = 25.1122; w2 = 9.3070; w4 = 9.1172; w3 = 3.7223; w6 = 3.2; l5 = -6.8885; l6 = 19.4031;
offset_w2 = 121.2861; offset_w3 = 163.9851;

% bundling all the parameters into one array
param_0 = [l1, bAng1, a1, bAng2, l2, l3, l4, w2, w4, w3, w6, l5, l6, offset_w2, offset_w3];

% adding the customized options for the fminunc optimization function
options = optimoptions('fminunc', 'MaxIterations', 1000, 'Display', 'iter');

% initialising the error value as 1 
err_final = 1;

% implementing the fminunc optimization function until the error is less
% than 0.2 (0.2 is the tolerance we have taken)
% because if we decrease the tolerance less than 0.2 the while loop will
% runs infinitely many times (also it may stop by running a few times but we can't tell exactly but mostly it will take more iterations)
while err_final > 0.2

    % fminunc adjusts param_0 to minimize the error returned by getError
    [param_0, err_final] = fminunc(@getError, param_0, options);
    
    if err_final > 0.2

        % we are introducing the randomised function to perturb the
        % parameters within a range (-1 to 1) to potentially escape local 
        % minima in the optimization process
        param_0 = param_0 + 2 * rand(size(param_0)) - 1;
    end
end

% displaying the final error(less than 0.2)
disp('Error after optimisation:');
disp(err_final);

% displaying the final parameter values 
disp(param_0);

% creating the final curve 
[gen_curve, cx__, cy__] = gOfX(param_0(1), param_0(2), param_0(3), param_0(4), param_0(5), param_0(6), param_0(7), param_0(8), param_0(9), param_0(10), param_0(11), param_0(12), param_0(13), param_0(14), param_0(15));

% ploting the final curve
plot(gen_curve(1,:), gen_curve(2,:));