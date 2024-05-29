class virtual_seqs extends uvm_sequence #(uvm_sequence_item);
   `uvm_object_utils(virtual_seqs)
  
    master_seqr mseqrh;
    slave_seqr sseqrh;
    virtual_seqr vsqrh;
    env_config e_cfg;

    // handles for master the sequences
    single_seq singleh;
    unspecified_seq unspecifiedh;
    wrap4_seq wrap4h;
    incr4_seq incr4h;
    wrap8_seq wrap8h;
    incr8_seq incr8h;
    wrap16_seq wrap16h;
    incr16_seq incr16h;
    
    // handles for slave the sequences
    ssingle_seq ssingleh;
   // sunspecified_seq sunspecifiedh;
    //swrap4_seq swrap4h;
    //sincr4_seq sincr4h;
    //swrap8_seq swrap8h;
    //sincr8_seq sincr8h;
    //swrap16_seq swrap16h;
    //sincr16_seq sincr16h;
	
     // standard UVM methods:
     extern function new(string name = "virtual_seqs");
     extern task body();
endclass


//-----------Constructor----------//
  function virtual_seqs::new(string name="virtual_seqs");
    super.new(name);
  endfunction


//-----------Build Phase----------//
   task virtual_seqs::body();
	if(!uvm_config_db #(env_config)::get(null,get_full_name(),"env_config",e_cfg))
	   `uvm_fatal("CONFIG","Cannot get() env_config from uvm_config_db.Is it set?")
	assert($cast(vsqrh,m_sequencer))
	else
	 begin
	  `uvm_error("BODY","Error in $cast")
	 end
	mseqrh=vsqrh.mseqrh;
	sseqrh=vsqrh.sseqrh;
endtask




/////////////////3X73ND3D 7357 53QU3NC35\\\\\\\\\\\\\\\


/*0000000000000000 single transfer 00000000000000*/
class vsingle_seq extends virtual_seqs;
   `uvm_object_utils(vsingle_seq)

    extern function new(string name="vsingle_seq");
    extern task body();
endclass

function vsingle_seq::new(string name="vsingle_seq");
    super.new(name);
endfunction

task vsingle_seq::body();
    super.body();
      singleh=single_seq::type_id::create("singleh");
      ssingleh=ssingle_seq::type_id::create("ssingleh");
      if(e_cfg.has_ahb_magent)
       begin
	      singleh.start(mseqrh);
       end
       if(e_cfg.has_ahb_sagent)
         begin
	        ssingleh.start(sseqrh);
         end
endtask
/*00000000000000000000000000000000000000000000000*/





/*1111111111111 Unspecified Length 11111111111111*/
class vunspecified_seq extends virtual_seqs;
   `uvm_object_utils(vunspecified_seq)

    extern function new(string name="vunspecified_seq");
    extern task body();
endclass

function vunspecified_seq::new(string name="vunspecified_seq");
    super.new(name);
endfunction

task vunspecified_seq::body();
    super.body();
      unspecifiedh=unspecified_seq::type_id::create("unspecifiedh");
      //sunspecifiedh=sunspecified_seq::type_id::create("sunspecifiedh");
      if(e_cfg.has_ahb_magent)
       begin
        unspecifiedh.start(mseqrh);
       end
     /* if(e_cfg.has_ahb_sagent)
       begin
        sunspecifiedh.start(sseqrh);
       end*/
endtask
/*11111111111111111111111111111111111111111111111*/





/*22222222222222222 Wrapping 4 222222222222222222*/
class vwrap4_seq extends virtual_seqs;
   `uvm_object_utils(vwrap4_seq)

    extern function new(string name="vwrap4_seq");
    extern task body();
endclass

function vwrap4_seq::new(string name="vwrap4_seq");
    super.new(name);
endfunction

task vwrap4_seq::body();
    super.body();
      wrap4h=wrap4_seq::type_id::create("wrap4h");
      //swrap4h=swrap4_seq::type_id::create("swrap4h");
      if(e_cfg.has_ahb_magent)
       begin
	      wrap4h.start(mseqrh);
       end
      /* if(e_cfg.has_ahb_sagent)
         begin
	        swrap4h.start(sseqrh);
         end*/
endtask
/*22222222222222222222222222222222222222222222222*/





/*33333333333333333 Incrementing 4 333333333333333*/
class vincr4_seq extends virtual_seqs;
   `uvm_object_utils(vincr4_seq)

    extern function new(string name="vincr4_seq");
    extern task body();
endclass

function vincr4_seq::new(string name="vincr4_seq");
    super.new(name);
endfunction

task vincr4_seq::body();
    super.body();
      incr4h=incr4_seq::type_id::create("incr4h");
      //sincr4h=sincr4_seq::type_id::create("sincr4h");
      if(e_cfg.has_ahb_magent)
       begin
	      incr4h.start(mseqrh);
       end
     /* if(e_cfg.has_ahb_sagent)
       begin
	      sincr4h.start(sseqrh);
       end*/
endtask
/*33333333333333333333333333333333333333333333333*/





/*44444444444444444 Wrapping 8 444444444444444444*/
class vwrap8_seq extends virtual_seqs;
   `uvm_object_utils(vwrap8_seq)

    extern function new(string name="vwrap8_seq");
    extern task body();
endclass

function vwrap8_seq::new(string name="vwrap8_seq");
    super.new(name);
endfunction

task vwrap8_seq::body();
    super.body();
      wrap8h=wrap8_seq::type_id::create("wrap8h");
     // swrap8h=swrap8_seq::type_id::create("swrap8h");
      if(e_cfg.has_ahb_magent)
       begin
	      wrap8h.start(mseqrh);
       end
     /* if(e_cfg.has_ahb_sagent)
       begin
	      swrap8h.start(sseqrh);
       end*/
endtask
/*44444444444444444444444444444444444444444444444*/





/*55555555555555555 Incrementing 8 55555555555555*/
class vincr8_seq extends virtual_seqs;
   `uvm_object_utils(vincr8_seq)

    extern function new(string name="vincr8_seq");
    extern task body();
endclass

function vincr8_seq::new(string name="vincr8_seq");
    super.new(name);
endfunction

task vincr8_seq::body();
    super.body();
      incr8h=incr8_seq::type_id::create("incr8h");
     // sincr8h=sincr8_seq::type_id::create("sincr8h");
      if(e_cfg.has_ahb_magent)
       begin
	      incr8h.start(mseqrh);
       end
     /* if(e_cfg.has_ahb_sagent)
       begin
	      sincr8h.start(sseqrh);
       end*/

endtask
/*55555555555555555555555555555555555555555555555*/





/*66666666666666666 Wrapping 16 66666666666666666*/
class vwrap16_seq extends virtual_seqs;
   `uvm_object_utils(vwrap16_seq)

    extern function new(string name="vwrap16_seq");
    extern task body();
endclass

function vwrap16_seq::new(string name="vwrap16_seq");
    super.new(name);
endfunction

task vwrap16_seq::body();
    super.body();
      wrap16h=wrap16_seq::type_id::create("wrap16h");
     // swrap16h=swrap16_seq::type_id::create("swrap16h");
      if(e_cfg.has_ahb_magent)
       begin
	      wrap16h.start(mseqrh);
       end
    /*  if(e_cfg.has_ahb_sagent)
       begin
	      swrap16h.start(sseqrh);
       end*/

endtask
/*66666666666666666666666666666666666666666666666*/





/*77777777777777777 Incrementing 16 7777777777777*/
class wincr16_seq extends virtual_seqs;
   `uvm_object_utils(wincr16_seq)

    extern function new(string name="wincr16_seq");
    extern task body();
endclass

function wincr16_seq::new(string name="wincr16_seq");
    super.new(name);
endfunction

task wincr16_seq::body();
    super.body();
      incr16h=incr16_seq::type_id::create("incr16h");
     // sincr16h=sincr16_seq::type_id::create("sincr16h");
      if(e_cfg.has_ahb_magent)
       begin
	      incr16h.start(mseqrh);
       end
    /*  if(e_cfg.has_ahb_sagent)
       begin
	      sincr16h.start(sseqrh);
       end*/

endtask
/*77777777777777777777777777777777777777777777777*/










