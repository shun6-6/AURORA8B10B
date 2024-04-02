`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/02 09:47:26
// Design Name: 
// Module Name: XC7Z100_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module XC7Z100_top(
    input                       i_gtref_clk_p       ,
    input                       i_gtref_clk_n       ,
    input                       i_clk_100M_p        ,
    input                       i_clk_100M_n        ,
    output [1 :0]               gt_txp              ,
    output [1 :0]               gt_txn              ,
    input  [1 :0]               gt_rxp              ,
    input  [1 :0]               gt_rxn              ,
    output [1 :0]               o_sfp_dis           
);

wire                            w_clk_100M          ;
wire                            w_clk_100M_rst      ;
wire                            w_c0_user_clk       ;
wire                            w_c0_user_rst       ;
wire                            w_c1_user_clk       ;
wire                            w_c1_user_rst       ;
wire                            w_100Mhz_locked     ;
(* MARK_DEBUG = "TRUE" *)wire [31:0]                        m_c0_axi_tx_tdata   ;
(* MARK_DEBUG = "TRUE" *)wire [3 :0]                        m_c0_axi_tx_tkeep   ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c0_axi_tx_tlast   ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c0_axi_tx_tvalid  ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c0_axi_tx_tready  ;
(* MARK_DEBUG = "TRUE" *)wire [31:0]                        s_c0_axi_rx_tdata   ;
(* MARK_DEBUG = "TRUE" *)wire [3 :0]                        s_c0_axi_rx_tkeep   ;
(* MARK_DEBUG = "TRUE" *)wire                               s_c0_axi_rx_tlast   ;
(* MARK_DEBUG = "TRUE" *)wire                               s_c0_axi_rx_tvalid  ;
(* MARK_DEBUG = "TRUE" *)wire [31:0]                        m_c1_axi_tx_tdata   ;
(* MARK_DEBUG = "TRUE" *)wire [3 :0]                        m_c1_axi_tx_tkeep   ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c1_axi_tx_tlast   ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c1_axi_tx_tvalid  ;
(* MARK_DEBUG = "TRUE" *)wire                               m_c1_axi_tx_tready  ;
(* MARK_DEBUG = "TRUE" *)wire [31:0]                        s_c1_axi_rx_tdata   ;
(* MARK_DEBUG = "TRUE" *)wire [3 :0]                        s_c1_axi_rx_tkeep   ;
(* MARK_DEBUG = "TRUE" *)wire                               s_c1_axi_rx_tlast   ;
(* MARK_DEBUG = "TRUE" *)wire                               s_c1_axi_rx_tvalid  ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c0_hard_err       ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c0_soft_err       ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c0_frame_err      ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c0_channel_up     ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c0_lane_up        ;
(* MARK_DEBUG = "TRUE" *)wire [2 :0]                        w_c0_loopback       ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c1_hard_err       ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c1_soft_err       ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c1_frame_err      ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c1_channel_up     ;
(* MARK_DEBUG = "TRUE" *)wire                               w_c1_lane_up        ;
(* MARK_DEBUG = "TRUE" *)wire [2 :0]                        w_c1_loopback       ;

assign w_c0_loopback = 3'b000;
assign w_c1_loopback = 3'b000;
assign o_sfp_dis     = 2'b00 ;

clk_wiz_100Mhz clk_wiz_100Mhz_u0
(
    .clk_out1   (w_clk_100M     ),
    .locked     (w_100Mhz_locked),
    .clk_in1_p  (i_clk_100M_p   ),
    .clk_in1_n  (i_clk_100M_n   )
);
// IBUFDS #(
//     .DIFF_TERM                  ("TRUE"             ),
//     .IBUF_LOW_PWR               ("TRUE"             ),
//     .IOSTANDARD                 ("DEFAULT"          ) 
// )IBUFDS_inst(               
//     .O                          (w_clk_100M         ),
//     .I                          (i_clk_100M_p       ),
//     .IB                         (i_clk_100M_n       ) 
// );  

rst_gen_module#(    
    .P_RST_CYCLE                (10                 )   
)   
rst_gen_module_U0   
(   
    .i_clk                      (w_clk_100M         ),
    .o_rst                      (w_clk_100M_rst     )
);

user_data_gen user_data_gen_u0(
    .i_clk                      (w_c0_user_clk      ),
    .i_rst                      (w_c0_user_rst      ),

    .m_axi_tx_tdata             (m_c0_axi_tx_tdata  ),
    .m_axi_tx_tkeep             (m_c0_axi_tx_tkeep  ),
    .m_axi_tx_tlast             (m_c0_axi_tx_tlast  ),
    .m_axi_tx_tvalid            (m_c0_axi_tx_tvalid ),
    .m_axi_tx_tready            (m_c0_axi_tx_tready ),
    .s_axi_rx_tdata             (s_c0_axi_rx_tdata  ),
    .s_axi_rx_tkeep             (s_c0_axi_rx_tkeep  ),
    .s_axi_rx_tlast             (s_c0_axi_rx_tlast  ),
    .s_axi_rx_tvalid            (s_c0_axi_rx_tvalid )
);

user_data_gen user_data_gen_u1(
    .i_clk                      (w_c1_user_clk      ),
    .i_rst                      (w_c1_user_rst      ),

    .m_axi_tx_tdata             (m_c1_axi_tx_tdata  ),
    .m_axi_tx_tkeep             (m_c1_axi_tx_tkeep  ),
    .m_axi_tx_tlast             (m_c1_axi_tx_tlast  ),
    .m_axi_tx_tvalid            (m_c1_axi_tx_tvalid ),
    .m_axi_tx_tready            (m_c1_axi_tx_tready ),
    .s_axi_rx_tdata             (s_c1_axi_rx_tdata  ),
    .s_axi_rx_tkeep             (s_c1_axi_rx_tkeep  ),
    .s_axi_rx_tlast             (s_c1_axi_rx_tlast  ),
    .s_axi_rx_tvalid            (s_c1_axi_rx_tvalid )
);


aurora8b10b_module aurora_module_u0(
    .i_gtref_clk_p              (i_gtref_clk_p      ),
    .i_gtref_clk_n              (i_gtref_clk_n      ),
    .i_clk_100M                 (w_clk_100M         ),
    .i_rst                      (w_clk_100M_rst     ),
    .gt_txp                     (gt_txp             ),
    .gt_txn                     (gt_txn             ),
    .gt_rxp                     (gt_rxp             ),
    .gt_rxn                     (gt_rxn             ),

    .s_axi_c0_tx_tdata          (m_c0_axi_tx_tdata  ),
    .s_axi_c0_tx_tkeep          (m_c0_axi_tx_tkeep  ),
    .s_axi_c0_tx_tlast          (m_c0_axi_tx_tlast  ),
    .s_axi_c0_tx_tvalid         (m_c0_axi_tx_tvalid ),
    .s_axi_c0_tx_tready         (m_c0_axi_tx_tready ),
    .m_axi_c0_rx_tdata          (s_c0_axi_rx_tdata  ),
    .m_axi_c0_rx_tkeep          (s_c0_axi_rx_tkeep  ),
    .m_axi_c0_rx_tlast          (s_c0_axi_rx_tlast  ),
    .m_axi_c0_rx_tvalid         (s_c0_axi_rx_tvalid ),

    .s_axi_c1_tx_tdata          (m_c1_axi_tx_tdata  ),
    .s_axi_c1_tx_tkeep          (m_c1_axi_tx_tkeep  ),
    .s_axi_c1_tx_tlast          (m_c1_axi_tx_tlast  ),
    .s_axi_c1_tx_tvalid         (m_c1_axi_tx_tvalid ),
    .s_axi_c1_tx_tready         (m_c1_axi_tx_tready ),
    .m_axi_c1_rx_tdata          (s_c1_axi_rx_tdata  ),
    .m_axi_c1_rx_tkeep          (s_c1_axi_rx_tkeep  ),
    .m_axi_c1_rx_tlast          (s_c1_axi_rx_tlast  ),
    .m_axi_c1_rx_tvalid         (s_c1_axi_rx_tvalid ),

    .o_c0_hard_err              (w_c0_hard_err      ),
    .o_c0_soft_err              (w_c0_soft_err      ),
    .o_c0_frame_err             (w_c0_frame_err     ),
    .o_c0_channel_up            (w_c0_channel_up    ),
    .o_c0_lane_up               (w_c0_lane_up       ),
    .i_c0_loopback              (w_c0_loopback      ),
    .o_c1_hard_err              (w_c1_hard_err      ),
    .o_c1_soft_err              (w_c1_soft_err      ),
    .o_c1_frame_err             (w_c1_frame_err     ),
    .o_c1_channel_up            (w_c1_channel_up    ),
    .o_c1_lane_up               (w_c1_lane_up       ),
    .i_c1_loopback              (w_c1_loopback      ),

    .o_c0_user_clk              (w_c0_user_clk      ),
    .o_c0_user_rst              (w_c0_user_rst      ),
    .o_c1_user_clk              (w_c1_user_clk      ),
    .o_c1_user_rst              (w_c1_user_rst      )
);

endmodule

