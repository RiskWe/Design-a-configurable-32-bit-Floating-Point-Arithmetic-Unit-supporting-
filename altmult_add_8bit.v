`timescale 1 ps / 1 ps
// synopsys translate_on
module altmult_add_8bit (
	aclr0,
	clock0,
	dataa_0,
	dataa_1,
	datab_0,
	datab_1,
	ena0,
	result);

	input	  aclr0;
	input	  clock0;
	input	[7:0]  dataa_0;
	input	[7:0]  dataa_1;
	input	[7:0]  datab_0;
	input	[7:0]  datab_1;
	input	  ena0;
	output	[16:0]  result;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0	  aclr0;
	tri1	  clock0;
	tri0	[7:0]  dataa_0;
	tri0	[7:0]  dataa_1;
	tri0	[7:0]  datab_0;
	tri0	[7:0]  datab_1;
	tri1	  ena0;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [16:0] sub_wire0;
	wire [7:0] sub_wire6 = datab_1[7:0];
	wire [7:0] sub_wire3 = dataa_1[7:0];
	wire [16:0] result = sub_wire0[16:0];
	wire [7:0] sub_wire1 = dataa_0[7:0];
	wire [15:0] sub_wire2 = {sub_wire3, sub_wire1};
	wire [7:0] sub_wire4 = datab_0[7:0];
	wire [15:0] sub_wire5 = {sub_wire6, sub_wire4};

	
