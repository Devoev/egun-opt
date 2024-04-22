% INPUT:
%       - degree_ref: degree of the reference solution
%       - nsub_ref:   number of subdomains of the reference solution
%       - degree:     array of degrees of the iterative solution
%       - N_it:       number of iterative solutions
%       - filename:   name of the file containing the errors (.mat)

function [] = plot_convergence (degree_ref, nsub_ref, degree, N_it, filename)
    filename = [filename '_degree_ref=' num2str(degree_ref(1)) '_nsub_ref=' num2str(nsub_ref(1)) '_degree=' num2str(degree(1)) '_N_it=' num2str(N_it) '.mat'];
    % 'errh1', 'errl2'
    load(filename);

    h = 1./(2.^(0:N_it));
    h_l2 = h.^(degree(1)+1);
    h_h1 = h.^degree(1);

    % write with dat1D
    figure(1);
    loglog(h, errl2, h, h_l2*errl2(1));
    legend('computed', 'p+1');
    xlabel('h in m');
    title('error in L^2 norm');

    figure(2);
    loglog(h, errh1, h, h_h1*errh1(1));
    legend('computed', 'p');
    xlabel('h in m');
    title('error in H^1 norm');
end
