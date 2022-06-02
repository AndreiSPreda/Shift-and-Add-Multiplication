//---------------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Proiect     : Limbaje de descriere hardware
// Autor       : Preda Silviu Andrei
// Data        : 29.05.2022
//---------------------------------------------------------------------------------------
// Descriere   : Test-bench Multiplicator cu deplasare dreapta
//---------------------------------------------------------------------------------------
module multiplicator_tb #(
    parameter DATA_WIDTH = 'd8
) (
    input                      clk      , 
    input                      rst_n    , 
    output reg                 req      , 
    output reg [2*DATA_WIDTH-1:0]  data_req  

);

initial begin
    req <= 'bx;
    data_req <= 'bx;
    @(negedge rst_n);
    //data_req <= 16'b0000011100001010; //7x10
    data_req <= 16'b0000010100000011; //5x3
    req <='b1;
    @(posedge clk);
    
    repeat(50)@(posedge clk);
    $stop;

end
    
endmodule