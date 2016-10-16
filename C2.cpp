/*
Author: Kevin Ochoa
Email: ochoakevinm@gmail.com
Name of this file: C2.cpp
GNU Compiler: g++ -c -m64 -Wall -l C2.lis -o C2.o C2.cpp
Purpose: This is subprogram number 2 out of 5 designed for the purpose of investigating the role of the system stack in the process calling subprograms.
*/
//====== Beginning of C2.cpp ==============================================================================================================================================
#include <iostream>
using namespace std;

extern "C" void C2(double);
extern "C" void C3(double);

void C2(double C1_variable){

	cout << "Function C2 has begun" << endl;
	double c(9.1), d(-2.7), e(C1_variable);
	cout << "The variables are: c = " << c << ", d = " << d << ", e = " << e << endl;
	cout << "Function 3 will be called next" << endl << endl;
	C3(d);
	cout << "This is function C2 resuming execution." << endl;
	cout << "The variables are: c = " << c << ", d = " << d << ", e = " << e << endl;
	cout << "This function C2 is now returning to caller" << endl << endl;
}
//====== End of C2.cpp ====================================================================================================================================================
