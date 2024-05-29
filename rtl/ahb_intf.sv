interface ahb_intf(input logic HCLK);

        logic HRESETn;
        logic HREADY;
        logic [1:0] HTRANS;
        logic [2:0] HBURST;
        logic [2:0] HSIZE;
        logic HWRITE;
        logic HSEL;
        logic [31:0] HADDR;
        logic [31:0] HWDATA;
        logic [31:0] HRDATA;
        logic [1:0] HRESP;


        clocking mdrv_cb@(posedge HCLK);
                default input #1 output #0;
                output HRESETn;
                output HTRANS;
                output HBURST;
                output HSIZE;
                output HWRITE;
                output HADDR;
                output HWDATA;
                input HREADY;
                input HRESP;
               // input HRDATA;

        endclocking
        clocking mmon_cb@(posedge HCLK);
                default input #1 output #0;

                input HRESETn;
                input HREADY;
                input HTRANS;
                input HBURST;
                input HSIZE;
                input HWRITE;
                input HADDR;
                input HWDATA;
                input HRESP;
                input HRDATA;

        endclocking

        clocking sdrv_cb@(posedge HCLK);
                default input #1 output #0;

                input HTRANS;
                output HRESETn;
                input HBURST;
                input HSIZE;
                output HWRITE;
                output HADDR;
                input HSEL;
                input HWDATA;
                input HREADY;
                output HRESP;
                output HRDATA;

        endclocking

        clocking smon_cb@(posedge HCLK);
                default input #1 output #0;

                input HREADY;
                input HTRANS;
                input HBURST;
                input HSIZE;
                input HWRITE;
                input HADDR;
                input HSEL;
                input HWDATA;
                input HRESP;
                input HRDATA;

        endclocking


        modport MDRV_MP(clocking mdrv_cb, input HRESETn);
        modport MMON_MP(clocking mmon_cb, input HRESETn);
        modport SDRV_MP(clocking sdrv_cb, input HRESETn);
        modport SMON_MP(clocking smon_cb, input HRESETn);

endinterface

