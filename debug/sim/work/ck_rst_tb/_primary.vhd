library verilog;
use verilog.vl_types.all;
entity ck_rst_tb is
    generic(
        ck_semiperiod   : integer := 10
    );
    port(
        clk             : out    vl_logic;
        rst_n           : out    vl_logic
    );
end ck_rst_tb;
