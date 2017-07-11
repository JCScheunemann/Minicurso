/*
	Test Bench para multiplicador 2 operandos sincrono
	Desenvolvido por Jean C. Scheunemann (https://github.com/JCScheunemann) em julho de 2017
	License:
		Distribuido sob os termos da Open Software fundation, sendo permitida a distribuicao, copia e alteracao, desde que os devidos autores sejam citados.
*/
/*
	Descricao: Algoritmo para teste do multiplicador utilizado no minicurso
*/
`timescale 1 ns / 1 ns
module multiplicador_tb;
	//Definicao dos paramtros e variaveis(sinais)
	parameter TAM=8;
	localparam integer PERIOD = 10;
	reg [TAM-1:0] A;
	reg [TAM-1:0] B;
	wire [TAM+TAM-1:0] S;
	reg clk;
	
	//Definicao das funcoes	e parametros para a simulacao
	initial begin
		$dumpfile("Multiplicador1.vcd");			//Definicao do arquivo de saida da simulacao
		$dumpvars(0,multiplicador_tb);	//Definicao do nivel dos sinais que serao salvos no arquivo("0" todos os sinais internos, "1" apenas os sinais de entrada e saida); Declaracao de qual modulo terah os sinais salvos na simulacao.
		$display("Inicio do TB...");	//Mensagem de inicio da simulacao
		#100 $finish;					//Criterio de termino da simulacao,nesse exemplo apos 100ns a simulacao acaba
		
	end
	
	//Daqui em diante eh o TB do multiplicador
	multiplicador m1(.clk(clk),
					 .A(A),
					 .B(B),
					 .S(S));
	//geracao dos valores de entrada, extraido de um codigo do professor Mateus Beck Fonseca
	always@(negedge clk) begin
		A = $random; 
		B = $random; 
	end
	//geracao do clk
	initial clk = 1'b0;
	always #(PERIOD/2) clk = ~clk;
	
	//verificacao do valor
	always@(posedge clk) begin
		#1
		if(S==A*B) begin
			$display("\nTest passed");
		end else
			$display("\nError at time-",$time);
		
	end
	
endmodule
