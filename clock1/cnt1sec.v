module CNT1SEC(
        input CLK, RST,
        output EN1HZ
    );

    /* 50MHzカウンタ */
    reg [25:0] cnt;

    always @( posedge CLK ) begin
        if ( RST )
            cnt <= 26'b0;
        else if (cnt == 26'd49_999_999)
            cnt <= 26'b0;
        else
            cnt <= cnt + 26'b1;
    end

    /* 1Hzのイネーブル信号 */
    assign EN1HZ = (cnt == 26'd49_999_999);

endmodule
