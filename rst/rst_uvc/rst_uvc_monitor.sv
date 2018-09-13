
`ifndef RST_UVC_MONITOR_SV
`define RST_UVC_MONITOR_SV

class rst_uvc_monitor extends uvm_monitor;
  
  // registration macro
  `uvm_component_utils(rst_uvc_monitor)
  
  // analysis port
  uvm_analysis_port #(rst_uvc_item) m_aport;
  
  // virtual interface reference
  virtual interface rst_uvc_if m_vif;
  
  // configuration reference
  rst_uvc_agent_cfg m_cfg;
  
  // monitor item
  rst_uvc_item m_item;
  
  // constructor
  extern function new(string name, uvm_component parent);
  // build phase
  extern virtual function void build_phase(uvm_phase phase);
  // run phase
  extern virtual task run_phase(uvm_phase phase);
  // collect item
  extern virtual task collect_item();
  // print item
  extern virtual function void print_item(rst_uvc_item item);

endclass : rst_uvc_monitor

// constructor
function rst_uvc_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction : new

// build phase
function void rst_uvc_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  
  // create port
  m_aport = new("m_aport", this);
  
  // create item
  m_item = rst_uvc_item::type_id::create("m_item", this);
endfunction : build_phase

// connect phase
task rst_uvc_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  forever begin
    collect_item();
  end
endtask : run_phase

// collect item
task rst_uvc_monitor::collect_item();  

  `uvm_info(get_type_name(), "Starting to collect items...", UVM_HIGH)
  
  forever begin    

    m_item.rst_duration = 0;

    @(negedge m_vif.RESET_N);
  
    forever begin
      if(m_vif.RESET_N == 1) begin
        break;
      end
      else begin
        m_item.rst_duration++;
        @(posedge m_vif.clock);
      end
    end

    // print item
    print_item(m_item);
    
    // write analysis port
    m_aport.write(m_item);    
  end // forever begin  
endtask : collect_item

// print item
function void rst_uvc_monitor::print_item(rst_uvc_item item);
  `uvm_info(get_type_name(), $sformatf("Item collected: \n%s", item.sprint()), UVM_HIGH)
endfunction : print_item

`endif // RST_UVC_MONITOR_SV
