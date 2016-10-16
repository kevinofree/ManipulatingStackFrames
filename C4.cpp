/*
Author: Kevin Ochoa
Email: ochoakevinm@gmail.com
Name of this file: C4.cpp
GNU Compiler: g++ -c -m64 -Wall -l C4.lis -o C4.o C4.cpp
Purpose: This is subprogram number 4 out of 5 designed for the purpose of investigating the role of the system stack in the process calling subprograms.
*/
//====== Beginning of C4.cpp ==============================================================================================================================================
#include <iostream>
using namespace std;

extern "C" void C4(double);
extern "C" void C5(double);

void C4(double C3_variable){
	cout << "Function C4 has begun" << endl;
	double j(-1.5), k(0.6), l(2.1), m(4.3), n(C3_variable);
	cout << "The variables are: j = " << j << ", k = " << k << ", l = " << l  << ", m = " << m  << ", n = " << n << endl;
	cout << "Function C5 will be called next" << endl << endl;
	C5(k);
	cout << "This is function C4 resuming execution." << endl;
	cout << "The variables are: j = " << j << ", k = " << k << ", l = " << l  << ", m = " << m  << ", n = " << n << endl;
	cout << "This function C4 is now returning to caller" << endl << endl;
}
//====== End of C4.cpp ====================================================================================================================================================
