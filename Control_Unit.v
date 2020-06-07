//This module describes the beahvior of the 
//control unit of the Shift and ADD Multiplier

module control_unit (clk,reset,start,M0,load,shift_l,shift_r,write,valid);


//Input Port
input clk;
input reset;
input start;
input M0;

//Output POrt
output reg load;
output reg shift_l;
output reg shift_r;
output reg write;
output reg valid;

localparam idle_st    = 3'b000,
           load_st    = 3'b001,
			  check_st   = 3'b010,
			  add_st     = 3'b011,
			  shift_st   = 3'b100,
			  valid_st   = 3'b101;
			 
reg [2:0] pstate,nstate;
reg [5:0]r; // for calculating the repetitions; 32
reg inc_r,reset_r;
//
always@(posedge clk or posedge reset)
begin
	if(reset)
		pstate <= idle_st;
	else
		pstate <= nstate;
end

// Next State Block
always@(pstate or start or M0 or r)
begin
	case (pstate)
		idle_st:begin
					if(start)
						nstate = load_st;
					else
						nstate = idle_st;
				  end
		
		load_st:nstate = check_st;
		
		check_st:begin
					if(M0)				// if multiplier0 is 1
						nstate = add_st;
					else	   			// if multiplier0 is 0
						nstate = shift_st;
				  end

		add_st:nstate = shift_st;

		shift_st:begin
					if(r>=32)				// if r>=32
						nstate = valid_st;
					else	   			
						nstate = check_st;
				  end	

		valid_st:nstate = idle_st;			

		default: nstate = idle_st;
	endcase
end	

//Output Block
always@(pstate)
begin
	case (pstate)
		idle_st:begin
					load    = 1'b0;
					shift_l = 1'b0;
					shift_r = 1'b0;
					write   = 1'b0;
					valid   = 1'b0;
					inc_r   = 1'b0;
					reset_r = 1'b1;//reset the repetition counter
				  end	

		load_st:begin
					load    = 1'b1;
					shift_l = 1'b0;
					shift_r = 1'b0;
					write   = 1'b0;
					valid   = 1'b0;
					inc_r   = 1'b0;
					reset_r = 1'b0;
				  end	

		check_st:begin
					load    = 1'b0;
					shift_l = 1'b0;
					shift_r = 1'b0;
					write   = 1'b0;
					valid   = 1'b0;
					inc_r   = 1'b1;// increment the repetition counter
					reset_r = 1'b0;
				  end	
				  
		add_st:begin
					load    = 1'b0;
					shift_l = 1'b0;
					shift_r = 1'b0;
					write   = 1'b1;
					valid   = 1'b0;
					inc_r   = 1'b0;
					reset_r = 1'b0;
				  end	

		shift_st:begin
					load    = 1'b0;
					shift_l = 1'b1;
					shift_r = 1'b1;
					write   = 1'b0;
					valid   = 1'b0;
					inc_r   = 1'b0;
					reset_r = 1'b0;
				  end					  

		valid_st:begin
					load    = 1'b0;
					shift_l = 1'b0;
					shift_r = 1'b0;
					write   = 1'b0;
					valid   = 1'b1;
					inc_r   = 1'b0;
					reset_r = 1'b0;
				  end	

		default:begin
					load    = 1'b0;
					shift_l = 1'b0;
					shift_r = 1'b0;
					write   = 1'b0;
					valid   = 1'b0;
					inc_r   = 1'b0;
					reset_r = 1'b0;
				  end		
	endcase
end

//A counter to calcuate the repetitions
always@(posedge clk or posedge reset_r)
begin
	if(reset_r)
		r <= 6'b0;
	else if(inc_r)
		r <= r + 6'b00001;
end
		
endmodule	