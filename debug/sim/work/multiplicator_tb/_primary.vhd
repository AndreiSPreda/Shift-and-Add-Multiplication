library verilog;
use verilog.vl_types.all;
entity multiplicator_tb is
    generic(
        data_width      : integer := 8
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        req             : out    vl_logic;
        data_req        : out    vl_logic_vector
    );
end multiplicator_tb;
