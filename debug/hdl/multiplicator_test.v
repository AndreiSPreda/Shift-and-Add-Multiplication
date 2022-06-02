//---------------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Proiect     : Limbaje de descriere hardware
// Autor       : Preda Silviu Andrei
// Data        : 29.05.2022
//---------------------------------------------------------------------------------------
// Descriere   : Test Multiplicator cu deplasare dreapta
//---------------------------------------------------------------------------------------
module multiplicator_test#(parameter DATA_WIDTH = 'd8
)(

);

wire clk      ; 
wire rst_n    ; 
wire req      ; 
wire [2*DATA_WIDTH-1:0] data_req ; 
wire ack      ; 
wire [2*DATA_WIDTH-1:0] data_ack ; 

multiplicator_tb #(.DATA_WIDTH ('d8)
) MULTI_TB(
.clk      (clk     ),
.rst_n    (rst_n   ),
.req      (req     ),
.data_req (data_req)
);

multiplier # (.DATA_WIDTH  ('d8)
) MULTI (
.clk      (clk     ),
.rst_n    (rst_n   ),
.req      (req     ),
.data_req (data_req),
.ack      (ack     ),
.data_ack (data_ack)
);



ck_rst_tb #(
.CK_SEMIPERIOD ('d10)
) CLK_GEN (
.clk    (clk   ),
.rst_n  (rst_n )
);
endmodule