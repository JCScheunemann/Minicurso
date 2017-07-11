/*
	Multiplicador simples, para a demonstracao do funcionamento do qflow e do icarus verilog
	Desenvolvido por Jean C. Scheunemann (https://github.com/JCScheunemann) em julho de 2017
	License:
		Distribuido sob os termos da Open Software fundation, sendo permitida a distribuicao, copia e alteracao, desde que os devidos autores sejam citados.
*/
/*
	Descricao: Recebe os sinais de etrada A e B de largura TAM e multiplica eles a cada ciclo, gerando uma saida com TAM*2 bits
*/

module multiplicador(clk,A,B,S); //Definicao das ports
	parameter TAM=8;
	input [TAM-1:0] A;	//sinal de entrada A
	input [TAM-1:0] B; 	//sinal de entrada B
	input clk;			//sinal de clock
	output reg [(TAM+TAM-1):0] S; // sinal de saida
	
	//A cada borda de subida do clk, o sinal de saida S ira receber o valor da multiplicacao
	always @(posedge clk) begin
		S<=A*B;
	end	
endmodule
