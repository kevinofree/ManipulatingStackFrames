/*
Author: Kevin Ochoa
Email: ochoakevinm@gmail.com
Name of this file: C3.cpp
GNU Compiler: g++ -c -m64 -Wall -l C3.lis -o C3.o C3.cpp
Purpose: This is subprogram number 3 out of 5 designed for the purpose of investigating the role of the system stack in the process calling subprograms.
*/
//====== Beginning of C3.cpp ==============================================================================================================================================
#include <iostream>
using namespace std;

extern "C" void C3(double);
extern "C" void C4(double);

void C3(double C2_variable){

	cout << "Function C3 has begun" << endl;
	double f(-2.3), g(7.9), h(2.2), i(C2_variable);
	cout << "The variables are: f = " << f << ", g = " << g << ", h = " << h  << ", i = " << i << endl;
	cout << "Function C4 will be called next" << endl << endl;
	C4(f);
	cout << "This is function C3 resuming execution." << endl;
	cout << "The variables are: f = " << f << ", g = " << g << ", h = " << h  << ", i = " << i << endl;
	cout << "This function C3 is now returning to caller" << endl << endl;
}
//====== End of C3.cpp ====================================================================================================================================================

