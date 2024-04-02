`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/02 09:47:26
// Design Name: 
// Module Name: aurora8b10b_channel
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


module aurora8b10b_channel(
    input               i_clk_100M              ,
    input               i_rst                   ,
    input               i_gtref_clk             ,
    output              gt_txp                  ,
    output              gt_txn                  ,
    input               gt_rxp                  ,
    input               gt_rxn                  ,

    input  [31:0]       s_axi_tx_tdata          ,
    input  [3 :0]       s_axi_tx_tkeep          ,
    input               s_axi_tx_tlast          ,
    input               s_axi_tx_tvalid         ,
    output              s_axi_tx_tready         ,
    output [31:0]       m_axi_rx_tdata          ,
    output [3 :0]       m_axi_rx_tkeep          ,
    output              m_axi_rx_tlast          ,
    output              m_axi_rx_tvalid         ,

    output              o_hard_err              ,
    output              o_soft_err              ,
    output              o_frame_err             ,
    output              o_channel_up            ,
    output              o_lane_up               ,
    input  [2 :0]       i_loopback              ,

    output              o_user_clk              ,
    output              o_user_rst              ,

    input               gt0_qplllock_in         ,
    input               gt0_qpllrefclklost_in   ,
    output              gt0_qpllreset_out       ,
    input               gt_qpllclk_quad3_in     ,
    input               gt_qpllrefclk_quad3_in  
);

wire                    w_tx_out_clk        ;
wire                    w_gt_clk_locked     ;
wire                    w_user_clk          ;
wire                    w_sync_clk          ;
wire                    w_pll_not_locked    ;
wire                    w_sys_reset_out     ;
wire                    w_system_rst        ;
wire                    w_gt_reset          ;

assign o_user_clk = w_user_clk              ;
assign o_user_rst = w_sys_reset_out         ;

aurora_8b10b_0_CLOCK_MODULE aurora_8b10b_0_CLOCK_MODULE_u0
(
    .GT_CLK             (w_tx_out_clk           ),
    .GT_CLK_LOCKED      (w_gt_clk_locked        ),
    .USER_CLK           (w_user_clk             ),
    .SYNC_CLK           (w_sync_clk             ),
    .PLL_NOT_LOCKED     (w_pll_not_locked       )
);

aurora_8b10b_0_SUPPORT_RESET_LOGIC support_reset_logic_i_u0
(
        .RESET          (i_rst              ),
        .USER_CLK       (w_user_clk         ),
        .INIT_CLK_IN    (i_clk_100M         ),
        .GT_RESET_IN    (i_rst              ),
        .SYSTEM_RESET   (w_system_rst       ),
        .GT_RESET_OUT   (w_gt_reset         )
);


aurora_8b10b_0 aurora_8b10b_0_u0 (
  .s_axi_tx_tdata               (s_axi_tx_tdata       ),
  .s_axi_tx_tkeep               (s_axi_tx_tkeep       ),
  .s_axi_tx_tlast               (s_axi_tx_tlast       ),
  .s_axi_tx_tvalid              (s_axi_tx_tvalid      ),
  .s_axi_tx_tready              (s_axi_tx_tready      ),
  .m_axi_rx_tdata               (m_axi_rx_tdata       ),
  .m_axi_rx_tkeep               (m_axi_rx_tkeep       ),
  .m_axi_rx_tlast               (m_axi_rx_tlast       ),
  .m_axi_rx_tvalid              (m_axi_rx_tvalid      ),
  .hard_err                     (o_hard_err           ),
  .soft_err                     (o_soft_err           ),
  .frame_err                    (o_frame_err          ),
  .channel_up                   (o_channel_up         ),
  .lane_up                      (o_lane_up            ),
  .txp                          (gt_txp               ),
  .txn                          (gt_txn               ),
  .reset                        (w_system_rst         ),
  .gt_reset                     (w_gt_reset           ),
  .loopback                     (i_loopback           ),
  .rxp                          (gt_rxp               ),
  .rxn                          (gt_rxn               ),
  .drpclk_in                    (i_clk_100M           ),
  .drpaddr_in                   (0                    ),
  .drpen_in                     (0                    ),
  .drpdi_in                     (0                    ),
  .drprdy_out                   (                     ),
  .drpdo_out                    (                     ),
  .drpwe_in                     (0                    ),
  .power_down                   (0                    ),
  .tx_lock                      (w_gt_clk_locked      ),
  .tx_resetdone_out             (),
  .rx_resetdone_out             (),
  .link_reset_out               (),

  .gt0_qplllock_in              (gt0_qplllock_in        ),
  .gt0_qpllrefclklost_in        (gt0_qpllrefclklost_in  ),
  .gt0_qpllreset_out            (gt0_qpllreset_out      ),
  .gt_qpllclk_quad1_in          (gt_qpllclk_quad3_in    ),
  .gt_qpllrefclk_quad1_in       (gt_qpllrefclk_quad3_in ),

  .init_clk_in                  (i_clk_100M             ),
  .pll_not_locked               (w_pll_not_locked       ),
  .tx_out_clk                   (w_tx_out_clk           ),
  .sys_reset_out                (w_sys_reset_out        ),
  .user_clk                     (w_user_clk             ),
  .sync_clk                     (w_sync_clk             ),
  .gt_refclk1                   (i_gtref_clk            ) 
);

endmodule
