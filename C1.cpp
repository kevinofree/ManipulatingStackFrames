/*
Author: Kevin Ochoa
Email: ochoakevinm@gmail.com
Name of this file: C1.cpp
GNU Compiler: g++ -c -m64 -Wall -l C1.lis -o C1.o C1.cpp
Purpose: This is subprogram number 1 out of 5 designed for the purpose of investigating the role of the system stack in the process calling subprograms.
*/
//====== Beginning of C1.cpp ==============================================================================================================================================
#include <iostream>
using namespace std;

extern "C" void C2(double);

int main(){
	cout << "This is CPSC 240 Assignment 7 by Kevin Ochoa " << endl;
	cout << "The main function has begun" << endl;
	double a(5.2), b(-1.6);
	cout << "The variables are: a= " << a << ", b = " << b << endl;
	cout << "Function C2 will be called next" << endl << endl;
	C2(a);
	cout << "This is function C1 resuming execution." << endl;
	cout << "The variables are: a= " << a << ", b = " << b << endl;
	cout << "This function C1 is now returning control to the OS. Goodbye." << endl << endl;
	return 0;
}
//====== End of C1.cpp ====================================================================================================================================================
