/*
	Test Bench para multiplicador 2 operandos sincrono em C++, para simulacao utilizando o modelo gerado pelo verilator
	Desenvolvido por Jean C. Scheunemann (https://github.com/JCScheunemann) em julho de 2017
	License:
		Distribuido sob os termos da Open Software fundation, sendo permitida a distribuicao, copia e alteracao, desde que os devidos autores sejam citados.
*/

#include <stdio.h>
#include <iostream>
#include <verilated.h>      // Standard Def from Verilated
#include "Vmultiplicador.h"	// Header from Multiplicador.v modue
#include "verilated.h"		// Verilator Std LIB
#include "verilated_vcd_c.h"	// Verilator VCD LIB

using namespace std;		//Workspace definition

Vmultiplicador *top;       	// Instantiation of module

int main(int argc, char** argv) {
	cout << "Carregando o Modulo 'Multiplicador'..." << endl; 
	Verilated::commandArgs(argc, argv); // Remember args
	top = new Vmultiplicador;           // Create instance o module
	Verilated::traceEverOn(true);		// Active VCD register
	VerilatedVcdC* tfp = new VerilatedVcdC;// Create VCD register
	top->trace (tfp, 99);				// Add module to VCD registe 
	tfp->open ("multiplicador2.vcd");	// Define VCD output file
	
	//start test bench
	int i=0;
	cout << "Iniciando os testes..." << endl;
	for(i=0;i<=11; i++){
		//neg edge
		tfp->dump (2*i);	// Register time
		top->clk = 0;		// clk come of 1 to 0
		top->eval();		// Exec model
		//pos edge
		tfp->dump (2*i+1);	// Register time
		top->A = rand() %0xff; 	// Set A
		top->B = rand() %0xff;	// Set B
		top->clk = 1;			// clk come from 0 to 1
		top->eval();            // Exec model
		//print out
		cout << "\tTestando:" 
				<< int(top->A)<<"*"<<int(top->B)<< "="<<int(top->S)
				<<((int(top->S)==int(top->A) * int(top->B))? "\t OK":"\tERROR")<<endl; 
	}
	top->final();      	// End Model
	delete top;			// Unaloc memory
	tfp->close();		// End and close VCD file
  	exit(0);			// End TB(program)
}