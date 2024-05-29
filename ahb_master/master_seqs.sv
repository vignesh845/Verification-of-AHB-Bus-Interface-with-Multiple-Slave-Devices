
class master_seqs extends uvm_sequence#(master_xtn);

   `uvm_object_utils(master_seqs)
   bit [31:0]HADDR;
   bit [2:0]HSIZE;
   bit [2:0]HBURST;
   bit HWRITE;
   
  extern function new(string name = "master_seqs");
endclass


//--------------- Constructor method----------------------//
function master_seqs::new(string name = "master_seqs");
   super.new(name);
endfunction





/////////////////3X73ND3D 7357 53Q5\\\\\\\\\\\\\\\\


/*!!!!!!!!!!!!!!! single transfer !!!!!!!!!!!!!!!*/
class single_seq extends master_seqs;
   `uvm_object_utils(single_seq)

      extern function new(string name = "single_seq");
      extern task body();
endclass


function single_seq::new(string name = "single_seq");
   super.new(name);
endfunction

task single_seq::body();
 //repeat(10)
   begin
     req=master_xtn::type_id::create("req");
     start_item(req);
     assert(req.randomize() with {HWRITE inside{[0:1]} ; HTRANS==2'b10 ; HBURST==3'b000;})
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
class unspecified_seq extends master_seqs;
   `uvm_object_utils(unspecified_seq)
      extern function new(string name="unspecified_seq");
      extern task body();
endclass


function unspecified_seq::new(string name="unspecified_seq");
    super.new(name);
endfunction

task unspecified_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
	  bit [9:0] len;
    
     begin
       req=master_xtn::type_id::create("req");
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
class wrap4_seq extends master_seqs;
   `uvm_object_utils(wrap4_seq)

      extern function new(string name="wrap4_seq");
      extern task body();
endclass


function wrap4_seq::new(string name="wrap4_seq");
    super.new(name);
endfunction

task wrap4_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
    
     begin
       req=master_xtn::type_id::create("req");
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
class incr4_seq extends master_seqs;
   `uvm_object_utils(incr4_seq)

      extern function new(string name="incr4_seq");
      extern task body();
endclass


function incr4_seq::new(string name="incr4_seq");
    super.new(name);
endfunction

task incr4_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
    
     begin
       req=master_xtn::type_id::create("req");
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
class wrap8_seq extends master_seqs;
   `uvm_object_utils(wrap8_seq)

      extern function new(string name="wrap8_seq");
      extern task body();
endclass


function wrap8_seq::new(string name="wrap8_seq");
    super.new(name);
endfunction

task wrap8_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
    
     begin
       req=master_xtn::type_id::create("req");
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
class incr8_seq extends master_seqs;
   `uvm_object_utils(incr8_seq)

      extern function new(string name="incr8_seq");
      extern task body();
endclass


function incr8_seq::new(string name="incr8_seq");
    super.new(name);
endfunction

task incr8_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
    
     begin
       req=master_xtn::type_id::create("req");
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
class wrap16_seq extends master_seqs;
   `uvm_object_utils(wrap16_seq)

      extern function new(string name="wrap16_seq");
      extern task body();
endclass


function wrap16_seq::new(string name="wrap16_seq");
    super.new(name);
endfunction

task wrap16_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
    
     begin
       req=master_xtn::type_id::create("req");
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
class incr16_seq extends master_seqs;
   `uvm_object_utils(incr16_seq)
      extern function new(string name="incr16_seq");
      extern task body();
endclass


function incr16_seq::new(string name="incr16_seq");
    super.new(name);
endfunction

task incr16_seq::body();
    bit [31:0] HADDR;
    bit [2:0] HBURST;
    bit [2:0] HSIZE;
    bit HWRITE;
     begin
       req=master_xtn::type_id::create("req");
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







