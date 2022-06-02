//---------------------------------------------------------------------------------------
// Universitatea Transilvania din Brasov
// Proiect     : Limbaje de descriere hardware
// Autor       : Preda Silviu Andrei
// Data        : 29.05.2022
//---------------------------------------------------------------------------------------
// Descriere   : Multiplicator cu deplasare dreapta
//---------------------------------------------------------------------------------------
module multiplier #(
    parameter DATA_WIDTH = 'd8
) (
    input                     clk     ,
    input                     rst_n   ,
    input                     req     ,
    input [2*DATA_WIDTH-1:0]  data_req,
    output                    ack     ,
    output [2*DATA_WIDTH-1:0] data_ack

);
    reg [DATA_WIDTH-1:0] A;
    reg [DATA_WIDTH-1:0] B;
    reg [DATA_WIDTH-1:0] P;
    reg [2*DATA_WIDTH:0]counter;

    reg [2:0] state;
    reg [2:0] next_state;

    localparam IDLE = 3'b000; //initializare
    localparam LOAD = 3'b001; //load
    localparam VERIF_A = 3'b010; //verificare daca MSB A = 1
    localparam ADUNARE_B = 3'b011; // P <= P + B
    localparam DEPL_A = 3'b100; // MSB A = LSB P
    localparam DEPL_P = 3'b101; // MSB P = 0
    localparam FINAL = 3'b110;  // P contine MSB produs, A contine LSB produs

    always @(posedge clk or negedge rst_n) begin
    if(~rst_n) state <= IDLE;
    else state <= next_state;
end
always@(*) begin
 case (state)
    IDLE:if(req) next_state <= LOAD;
            else next_state <= IDLE;
    LOAD:        next_state <= VERIF_A;
    VERIF_A: if (A[0]==1) next_state <= ADUNARE_B;
             else next_state <= DEPL_A;
    ADUNARE_B:   next_state <= DEPL_A;
    DEPL_A: next_state <= DEPL_P;
    DEPL_P: if (counter == DATA_WIDTH-1) next_state <= FINAL;
            else next_state <= VERIF_A;
    FINAL: next_state <= IDLE;
    default: next_state <= IDLE;

 endcase
end

//calea de date

always@(posedge clk or negedge rst_n) begin
    if (~rst_n) A <= 'd0;
    else if(state == LOAD) A <= data_req[2*DATA_WIDTH-1:DATA_WIDTH];
end
always@(posedge clk or negedge rst_n) begin
    if (~rst_n) B <= 'd0;
    else if(state == LOAD) B <= data_req[DATA_WIDTH-1:0];
end

always@(posedge clk or negedge rst_n) begin
    if (~rst_n) P <= 'd0;
    else if(state == ADUNARE_B) P <= P + B;
end


always@(posedge clk or negedge rst_n) begin
    if (state == DEPL_A) A <= {P[0],A[DATA_WIDTH-1:1]};
end

always@(posedge clk or negedge rst_n) begin
    if (~rst_n) counter <= 'd0;
    else if(state == DEPL_P) begin P <= {1'b0, P[DATA_WIDTH-1:1]};
    counter <= counter + 1; 
    end
end

assign data_ack ={P[DATA_WIDTH-1:0], A[DATA_WIDTH-1:0]};
assign ack = (state == FINAL);

/*
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) stare <= S0;
        else if (stare == S0 & req) stare <= S1;
        else if (stare == S1 & A[DATA_WIDTH-1]==1) stare <= S2;
        else if (stare == S2) stare <= S3;
        else if (stare == S3) stare <= S4;
        else if (stare == S4 & counter == 7) stare <= S5;
        else if (stare == S4) stare <= S1;
    end
    always @(posedge clk or posedge rst_n) // aici e un counter pt a repeta de n ori
    begin
	if(~rst_n) counter <='b0;
	else if (stare == S0) counter <= 'b0;
	else if (stare == S4) counter <= counter + 1;
    end
    always @(posedge clk or posedge rst_n)
    begin
	if(~rst_n) A <= 'b0;
	else if (stare == S1) A <= data_req[2*DATA_WIDTH-1:DATA_WIDTH];
    end
    always @(posedge clk or posedge rst_n)
    begin
	if(~rst_n) B <= 'b0;
	else if (stare == S1) B <= data_req[DATA_WIDTH-1:0];
    end 
    always @(posedge clk or posedge rst_n)
    begin
	if(~rst_n) P <= 'b0;
	else if (stare == S1) P <= B;
	else if (stare == S2) P <= P + B;
	else if (stare == S3) A <= { P[0] , A[DATA_WIDTH-1:1]};
	else if (stare == S4)  P[DATA_WIDTH] <= 0;
    end 
    
    assign data_ack ={P[DATA_WIDTH-1:1], A[DATA_WIDTH-1:0]};
    assign ack = (stare == S5);
*/
endmodule