To run the test based on "An Alternative to the BDS Test: Integration
Accross the Correlation Integral",
forthcoming in the Econometric Reviews, you need to do the following:

1. Use the BDS.EXE program and calculate values of the correlation
integral Cm for 41 values of proximity parameter epsilon. Range of
epsilons is <0.25, 1.00> of standard deviation (in BDS.EXE you use
std. dev./spread due to construction of the test and design of program).
This is done at nine embedding dimensions m = 2,...,10.

2. To do this choose "Record Multiple Calculations" option in the
BDS.EXE program, set all required parameters, perform computation
and save the results in a file.

3. Start the CONVERT.EXE progam and use the file where the results from
previous step were saved. Follow the prompts of this program that will
compute the values of slope coefficients beta(m). Compare values with
critical values tabulated in the paper.