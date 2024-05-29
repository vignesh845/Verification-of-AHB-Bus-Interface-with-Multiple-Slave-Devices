class slave_seqs extends uvm_sequence#(slave_xtn);

   `uvm_object_utils(slave_seqs)
   bit [31:0]HADDR;
   bit [2:0]HSIZE;
   bit [2:0]HBURST;
   bit [1:0]HTRANS;
   bit HWRITE;
   extern function new(string name ="slave_seqs");
	
endclass

//-----------------  constructor new method  -------------------//
function slave_seqs::new(string name ="slave_seqs");
	super.new(name);
endfunction
  


/////////////////3X73ND3D 7357 53Q5\\\\\\\\\\\\\\\\


/*!!!!!!!!!!!!!!! single transfer !!!!!!!!!!!!!!!*/
class ssingle_seq extends slave_seqs;
   `uvm_object_utils(ssingle_seq)

      extern function new(string name = "ssingle_seq");
      extern task body();
endclass


function ssingle_seq::new(string name = "ssingle_seq");
   super.new(name);
endfunction

task ssingle_seq::body();
 //repeat(10)
   begin
     req=slave_xtn::type_id::create("req");
     start_item(req);
     assert(req.randomize()with {HWRITE inside{[0:1]} ; HTRANS==2'b10 ; HBURST==3'b000;})
     finish_item(req);
     $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");

   HADDR = req.HADDR;
   HSIZE = req.HSIZE;
   HBURST = req.HBURST;
   HWRITE = req.HWRITE;
   end
endtask
/*!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!*/





/*_____________ Unspecified Length ______________*/
class sunspecified_seq extends slave_seqs;
   `uvm_object_utils(sunspecified_seq)
      extern function new(string name="sunspecified_seq");
      extern task body();
endclass


function sunspecified_seq::new(string name="sunspecified_seq");
    super.new(name);
endfunction

task sunspecified_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
	  bit [9:0] len;
    
     begin
       req=slave_xtn::type_id::create("req");
       start_item(req);
       assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b001;})
       finish_item(req);
       $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	HADDR=req.HADDR;
	HSIZE=req.HSIZE;
	HBURST=req.HBURST;
	len=req.length;
	for(int i=0;i<100;i=i+1) //unspecified length defined in constraint
	begin	
	  start_item(req);
	    if(HSIZE==0)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+1'b1);})
	      $display("***********display inside HSIZE =0 ***************");
	    end
	    if(HSIZE==1)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+2'b10);})
	      $display("***********display inside HSIZE =1 ***************");
	    end
	    if(HSIZE==2)
	    begin	
              assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+3'b100);})
	      $display("***********display inside HSIZE =2 ***************");
	    end
	  finish_item(req);
	  $display("**********************************FROM SEQUENTIAL TRANSFER *********************");
 	  HADDR=req.HADDR;
	  HSIZE=req.HSIZE;
	end
  end
endtask
/*______________________________________________*/





/*<><><><><><><><><> Wrapping 4 <><><><><><><><><>*/
class swrap4_seq extends slave_seqs;
   `uvm_object_utils(swrap4_seq)

      extern function new(string name="swrap4_seq");
      extern task body();
endclass


function swrap4_seq::new(string name="swrap4_seq");
    super.new(name);
endfunction

task swrap4_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
    
     begin
       req=slave_xtn::type_id::create("req");
       start_item(req);
       assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b010;})
       finish_item(req);
       $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	HADDR=req.HADDR;
	HSIZE=req.HSIZE;
	HBURST=req.HBURST;
	
	repeat(3)
	begin	
	  start_item(req);
	    if(HSIZE==0)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR=={HADDR[31:2],HADDR[1:0]+1'b1};})
	      $display("***********display inside HSIZE =0 ***************");
	    end
	    if(HSIZE==1)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR=={HADDR[31:3],HADDR[2:0]+2'b10};})
	      $display("***********display inside HSIZE =1 ***************");
	    end
	    if(HSIZE==2)
	    begin	
              assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR=={HADDR[31:4],HADDR[3:0]+3'b100};})
	      $display("***********display inside HSIZE =2 ***************");
	    end
	  finish_item(req);
	  $display("**********************************FROM SEQUENTIAL TRANSFER *********************");
 	  HADDR=req.HADDR;
	  HSIZE=req.HSIZE;
	end
	end
endtask
/*<><><><><><><><><><><><><><><><><><><><><><><>*/





/*+++++++++++++++++ Increment 4 +++++++++++++++++*/
class sincr4_seq extends slave_seqs;
   `uvm_object_utils(sincr4_seq)

      extern function new(string name="sincr4_seq");
      extern task body();
endclass


function sincr4_seq::new(string name="sincr4_seq");
    super.new(name);
endfunction

task sincr4_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
    
     begin
       req=slave_xtn::type_id::create("req");
       start_item(req);
       assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b011;})
       finish_item(req);
       $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	HADDR=req.HADDR;
	HSIZE=req.HSIZE;
	HBURST=req.HBURST;
	
	repeat(3)
	begin	
	  start_item(req);
	    if(HSIZE==0)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+1'b1);})
	      $display("***********display inside HSIZE =0 ***************");
	    end
	    if(HSIZE==1)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+2'b10);})
	      $display("***********display inside HSIZE =1 ***************");
	    end
	    if(HSIZE==2)
	    begin	
              assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+3'b100);})
	      $display("***********display inside HSIZE =2 ***************");
	    end
	  finish_item(req);
	  $display("**********************************FROM SEQUENTIAL TRANSFER *********************");
 	  HADDR=req.HADDR;
	  HSIZE=req.HSIZE;
	end
 end
endtask
/*++++++++++++++++++++++++++++++++++++++++++++++*/





/*================= Wrapping 8 =================*/
class swrap8_seq extends slave_seqs;
   `uvm_object_utils(swrap8_seq)

      extern function new(string name="swrap8_seq");
      extern task body();
endclass


function swrap8_seq::new(string name="swrap8_seq");
    super.new(name);
endfunction

task swrap8_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
    
     begin
       req=slave_xtn::type_id::create("req");
       start_item(req);
       assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b100;})
       finish_item(req);
       $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	HADDR=req.HADDR;
	HSIZE=req.HSIZE;
	HBURST=req.HBURST;
	
	repeat(7)
	begin	
	  start_item(req);
	    if(HSIZE==0)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR=={HADDR[31:2],HADDR[1:0]+1'b1};})
	      $display("***********display inside HSIZE =0 ***************");
	    end
	    if(HSIZE==1)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR=={HADDR[31:3],HADDR[2:0]+2'b10};})
	      $display("***********display inside HSIZE =1 ***************");
	    end
	    if(HSIZE==2)
	    begin	
              assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR=={HADDR[31:4],HADDR[3:0]+3'b100};})
	      $display("***********display inside HSIZE =2 ***************");
	    end
	  finish_item(req);
	  $display("**********************************FROM SEQUENTIAL TRANSFER *********************");
 	  HADDR=req.HADDR;
	  HSIZE=req.HSIZE;
	end
 end
endtask
/*==============================================*/





/*.................. Increment 8 ...............*/
class sincr8_seq extends slave_seqs;
   `uvm_object_utils(sincr8_seq)

      extern function new(string name="sincr8_seq");
      extern task body();
endclass


function sincr8_seq::new(string name="sincr8_seq");
    super.new(name);
endfunction

task sincr8_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
    
     begin
       req=slave_xtn::type_id::create("req");
       start_item(req);
       assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b101;})
       finish_item(req);
       $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	HADDR=req.HADDR;
	HSIZE=req.HSIZE;
	HBURST=req.HBURST;
	
	repeat(7)
	begin	
	  start_item(req);
	    if(HSIZE==0)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+1'b1);})
	      $display("***********display inside HSIZE =0 ***************");
	    end
	    if(HSIZE==1)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+2'b10);})
	      $display("***********display inside HSIZE =1 ***************");
	    end
	    if(HSIZE==2)
	    begin	
              assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+3'b100);})
	      $display("***********display inside HSIZE =2 ***************");
	    end
	  finish_item(req);
	  $display("**********************************FROM SEQUENTIAL TRANSFER *********************");
 	  HADDR=req.HADDR;
	  HSIZE=req.HSIZE;
	end
  end
endtask
/*..............................................*/





/*/\/\/\/\/\/\/\/\ Wrapping 16 /\/\/\/\/\/\/\/\*/
class swrap16_seq extends slave_seqs;
   `uvm_object_utils(swrap16_seq)

      extern function new(string name="swrap16_seq");
      extern task body();
endclass


function swrap16_seq::new(string name="swrap16_seq");
    super.new(name);
endfunction

task swrap16_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
    
     begin
       req=slave_xtn::type_id::create("req");
       start_item(req);
       assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b010;})
       finish_item(req);
       $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	HADDR=req.HADDR;
	HSIZE=req.HSIZE;
	HBURST=req.HBURST;
	
	repeat(15)
	begin	
	  start_item(req);
	    if(HSIZE==0)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR=={HADDR[31:2],HADDR[1:0]+1'b1};})
	      $display("***********display inside HSIZE =0 ***************");
	    end
	    if(HSIZE==1)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR=={HADDR[31:3],HADDR[2:0]+2'b10};})
	      $display("***********display inside HSIZE =1 ***************");
	    end
	    if(HSIZE==2)
	    begin	
              assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR=={HADDR[31:4],HADDR[3:0]+3'b100};})
	      $display("***********display inside HSIZE =2 ***************");
	    end
	  finish_item(req);
	  $display("**********************************FROM SEQUENTIAL TRANSFER *********************");
 	  HADDR=req.HADDR;
	  HSIZE=req.HSIZE;
	end
  end
endtask
/*/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\*/





/*[][][][][][][][] Increment 16 [][][][][][][][]*/
class sincr16_seq extends slave_seqs;
   `uvm_object_utils(sincr16_seq)
      extern function new(string name="sincr16_seq");
      extern task body();
endclass


function sincr16_seq::new(string name="sincr16_seq");
    super.new(name);
endfunction

task sincr16_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
     begin
       req=slave_xtn::type_id::create("req");
       start_item(req);
       assert(req.randomize() with {HWRITE==1;HTRANS==2'b10;HBURST==3'b111;})
       finish_item(req);
       $display("***********************FROM NON_SEQUENTIAL TRANSFER ****************");
	HADDR=req.HADDR;
	HSIZE=req.HSIZE;
	HBURST=req.HBURST;
	
	repeat(15)
	begin	
	  start_item(req);
	    if(HSIZE==0)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+1'b1);})
	      $display("***********display inside HSIZE =0 ***************");
	    end
	    if(HSIZE==1)
	    begin
	      assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+2'b10);})
	      $display("***********display inside HSIZE =1 ***************");
	    end
	    if(HSIZE==2)
	    begin	
              assert(req.randomize() with {HWRITE==1;HTRANS==2'b11;HSIZE==HSIZE;HBURST==HBURST;HADDR==(HADDR+3'b100);})
	      $display("***********display inside HSIZE =2 ***************");
	    end
	  finish_item(req);
	  $display("**********************************FROM SEQUENTIAL TRANSFER *********************");
 	  HADDR=req.HADDR;
	  HSIZE=req.HSIZE;
	end
 end
endtask
/*[][][][][][][][][][][][][][][][][][][][][][][]*/







