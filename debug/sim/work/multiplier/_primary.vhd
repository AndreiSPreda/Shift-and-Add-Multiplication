library verilog;
use verilog.vl_types.all;
entity multiplier is
    generic(
        data_width      : integer := 8;
        idle            : integer := 0;
        load            : integer := 1;
        verif_a         : integer := 2;
        adunare_b       : integer := 3;
        depl_a          : integer := 4;
        depl_p          : integer := 5;
        final           : integer := 6
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        req             : in     vl_logic;
        data_req        : in     vl_logic_vector;
        ack             : out    vl_logic;
        data_ack        : out    vl_logic_vector
    );
end multiplier;
