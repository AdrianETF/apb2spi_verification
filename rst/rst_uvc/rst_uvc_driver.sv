
`ifndef RST_UVC_MASTER_DRIVER_SV
`define RST_UVC_MASTER_DRIVER_SV

class rst_uvc_driver extends uvm_driver #(rst_uvc_item);
  
  // registration macro
  `uvm_component_utils(rst_uvc_driver)
  
  // virtual interface reference
  virtual interface rst_uvc_if m_vif;
  
  // configuration reference
  rst_uvc_agent_cfg m_cfg;
  
  // request item
  REQ m_req;
   
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // process item
  extern virtual task process_item(rst_uvc_item item);

endclass : rst_uvc_driver

// constructor
function rst_uvc_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void rst_uvc_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction : build_phase

// run phase
task rst_uvc_driver::run_phase(uvm_phase phase);
  super.run_phase(phase);

  // init signals
  m_vif.RESET_N = 1'b0;
  
  forever begin
    seq_item_port.get_next_item(m_req);
    process_item(m_req);
    seq_item_port.item_done();
  end
endtask : run_phase

// process item
task rst_uvc_driver::process_item(rst_uvc_item item);

  // print item
  `uvm_info(get_type_name(), $sformatf("Item to be driven: \n%s", item.sprint()), UVM_HIGH)
  
  for(int i = 0; i < item.rst_delay; i++) begin
    @(posedge m_vif.clock);
  end

  m_vif.RESET_N = 0;

  for(int i = 0; i < item.rst_duration; i++) begin
    @(posedge m_vif.clock);
  end

  m_vif.RESET_N = 1;

endtask : process_item

`endif // RST_UVC_MASTER_DRIVER_SV
