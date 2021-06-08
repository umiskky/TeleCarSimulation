;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   周一 12月 7 2020
; Processor: 8086
; Compiler:  MASM32
;
; Before starting simulation set Internal Memory Size 
; in the 8086 model properties to 0x10000
;====================================================================
      STACKS  SEGMENT   STACK       ;堆栈段
              DW        128 DUP(?)  ;注意这里只有128个字节
      STACKS  ENDS
       DATAS  SEGMENT
   MODE_8253  EQU       29EH
   CLK0_8253  EQU       298H
   CLK1_8253  EQU       29AH
   CLK2_8253  EQU       29CH
 MODE_8255_1  EQU       286H
    A_8255_1  EQU       280H
    B_8255_1  EQU       282H
    C_8255_1  EQU       284H
 MODE_8255_2  EQU       28EH
    A_8255_2  EQU       288H
    B_8255_2  EQU       28AH
    C_8255_2  EQU       28CH
 MODE_8255_3  EQU       296H
    A_8255_3  EQU       290H
    B_8255_3  EQU       292H
    C_8255_3  EQU       294H
    SEG_CODE  DB        3FH,06H,5BH,4FH,66H,6DH,7DH,07H,7FH,6FH         ;数码管段码
    KEY_SCAN  DB        0EEH,0DDH,0BBH,77H      ;键盘扫描码/数码管扫描码
 DIG_DISPLAY  DB        0FFH        ;数码管显示缓存
 KEYBUF_ROW1  DB        00H,00H,00H,00H         ;键盘缓存
 KEYBUF_ROW2  DB        00H,00H,00H,00H
 KEYBUF_ROW3  DB        00H,00H,00H,00H
 KEYBUF_ROW4  DB        00H,00H,00H,00H
    KEY_PRO1  DW        KEY1_1,KEY1_2,KEY1_3,KEY1_4
    KEY_PRO2  DW        KEY2_1,KEY2_2,KEY2_3,KEY2_4
    KEY_PRO3  DW        KEY3_1,KEY3_2,KEY3_3,KEY3_4
    KEY_PRO4  DW        KEY4_1,KEY4_2,KEY4_3,KEY4_4
    SCAN_ROW  DW        SCAN_ROW1,SCAN_ROW2,SCAN_ROW3,SCAN_ROW4
 STEP_TIMING  DB        33H         ;步进电机时序脉冲初值
 DC_CLK_GEAR  DB        06H,04H,02H,01H         ;直流电机挡位
      DC_CLK  DB        01H         ;直流电机设定值
    DC_ISRUN  DB        00H         ;直流电机是否运行
 ROW_LATTICE  DW        LI_PA
 COL_LATTICE  DW        STOP_HI_PA
       LI_PA  DB        01H,02H,04H,08H,10H,20H,40H,80H,00H,00H,00H,00H,00H,00H,00H,00H
       LI_PB  DB        00H,00H,00H,00H,00H,00H,00H,00H,01H,02H,04H,08H,10H,20H,40H,80H
  LEFT_HI_PA  DB        80H,0C0H,0E0H,0F0H,0F8H,0FCH,0FEH,0FFH,0F0H,0F0H,0F0H,0F0H,0F0H,0F0H,0F0H,0F0H
  LEFT_HI_PB  DB        01H,03H,07H,0FH,1FH,3FH,7FH,0FFH,0FH,0FH,0FH,0FH,0FH,0FH,0FH,0FH
 RIGHT_HI_PA  DB        0F0H,0F0H,0F0H,0F0H,0F0H,0F0H,0F0H,0F0H,0FFH,0FEH,0FCH,0F8H,0F0H,0E0H,0C0H,80H
 RIGHT_HI_PB  DB        0FH,0FH,0FH,0FH,0FH,0FH,0FH,0FH,0FFH,7FH,3FH,1FH,0FH,07H,03H,01H
    UP_HI_PA  DB        00H,00H,00H,00H,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,00H,00H,00H,00H
    UP_HI_PB  DB        01H,03H,07H,0FH,1FH,3FH,7FH,0FFH,0FFH,7FH,3FH,1FH,0FH,07H,03H,01H
  DOWN_HI_PA  DB        80H,0C0H,0E0H,0F0H,0F8H,0FCH,0FEH,0FFH,0FFH,0FEH,0FCH,0F8H,0F0H,0E0H,0C0H,80H
  DOWN_HI_PB  DB        00H,00H,00H,00H,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,0FFH,00H,00H,00H,00H
  STOP_HI_PA  DB        0F0H,0F8H,0CH,06H,03H,0E3H,0E3H,0E3H,0E3H,0E3H,0E3H,03H,06H,0CH,0F8H,0F0H
  STOP_HI_PB  DB        0FH,1FH,30H,60H,0C0H,0C7H,0C7H,0C7H,0C7H,0C7H,0C7H,0C0H,60H,30H,1FH,0FH

       DATAS  ENDS
        CODE  SEGMENT   PUBLIC 'CODE'
              ASSUME    CS:CODE,DS:DATAS

      START:
              MOV       AX,DATAS
              MOV       DS,AX

              MOV       DX,MODE_8255_1
              MOV       AL,89H
              OUT       DX,AL
              
              MOV       DX,MODE_8255_2
              MOV       AL,80H
              OUT       DX,AL
              
              MOV       DX,MODE_8255_3
              MOV       AL,80H
              OUT       DX,AL
              
              MOV       DX,MODE_8253            ;CLK0
              MOV       AL,16H      ;方式3
              OUT       DX,AL
              MOV       DX,CLK0_8253
              MOV       AL,32H
              OUT       DX,AL
              
              MOV       DX,MODE_8253            ;CLK1
              MOV       AL,56H      ;方式3
              OUT       DX,AL
              MOV       DX,CLK1_8253
              MOV       AL,32H
              OUT       DX,AL

              MOV       DX,MODE_8253            ;CLK2
              MOV       AL,94H      ;方式2
              OUT       DX,AL
          
          KEYBOARD_SCAN:
;=====================================================================
;扫描第一行            
  SCAN_ROW1:  MOV       DX,A_8255_1
              MOV       AL,[KEY_SCAN]
              OUT       DX,AL
              CALL      DELAY
              
              CALL      DISPLAY_STATIC
              
              
              MOV       DX,C_8255_1
              IN        AL,DX
              LEA       DI,KEYBUF_ROW1          ;通过DI传参
              LEA       SI,KEY_PRO1 ; 通过SI传键盘处理程序参数
              MOV       BX,[SCAN_ROW+2]         ;通过BX继续进行扫描
              JMP       KEY_TEST
;=====================================================================
;扫描第二行            
  SCAN_ROW2:  MOV       DX,A_8255_1
              MOV       AL,[KEY_SCAN+1]
              OUT       DX,AL
              CALL      DELAY

              CALL      DISPLAY_STATIC
              
              MOV       DX,C_8255_1
              IN        AL,DX
              LEA       DI,KEYBUF_ROW2          ;通过DI传参
              LEA       SI,KEY_PRO2 ; 通过SI传键盘处理程序参数
              MOV       BX,[SCAN_ROW+4]         ;通过BX继续进行扫描
              JMP       KEY_TEST
;=====================================================================
;扫描第三行            
  SCAN_ROW3:  MOV       DX,A_8255_1
              MOV       AL,[KEY_SCAN+2]
              OUT       DX,AL
              CALL      DELAY

              CALL      DISPLAY_STATIC

              MOV       DX,C_8255_1
              IN        AL,DX
              LEA       DI,KEYBUF_ROW3          ;通过DI传参
              LEA       SI,KEY_PRO3 ; 通过SI传键盘处理程序参数
              MOV       BX,[SCAN_ROW+6]         ;通过BX继续进行扫描
              JMP       KEY_TEST
;=====================================================================
;扫描第四行            
  SCAN_ROW4:  MOV       DX,A_8255_1
              MOV       AL,[KEY_SCAN+3]
              OUT       DX,AL
              CALL      DELAY

              CALL      DISPLAY_STATIC

              MOV       DX,C_8255_1
              IN        AL,DX
              LEA       DI,KEYBUF_ROW4          ;通过DI传参
              LEA       SI,KEY_PRO4 ; 通过SI传键盘处理程序参数
              MOV       BX,[SCAN_ROW]           ;通过BX继续进行扫描
              JMP       KEY_TEST
;=====================================================================
;键盘测试 
;=====================================================================              
   KEY_TEST:  TEST      AL,01H
              JZ        SET_COL1
              TEST      AL,02H
              JZ        SET_COL2
              TEST      AL,04H
              JZ        SET_COL3
              TEST      AL,08H
              JZ        SET_COL4
              JMP       BX
              
   SET_FLAG:  PUSH      BX
              MOV       BX,CX
              MOV       BYTE PTR[DI+BX],DL
              SHL       BX,1
              JMP       WORD PTR[SI+BX]         ;转键盘处理程序

   SET_COL1:  MOV       CX,00H      ;确定列1位置
              MOV       DL,01H      ;置标志位
              JMP       SET_FLAG
   SET_COL2:  MOV       CX,01H      ;确定列2位置
              MOV       DL,01H      ;置标志位
              JMP       SET_FLAG
   SET_COL3:  MOV       CX,02H      ;确定列3位置
              MOV       DL,01H      ;置标志位
              JMP       SET_FLAG
   SET_COL4:  MOV       CX,03H      ;确定列4位置
              MOV       DL,01H      ;置标志位
              JMP       SET_FLAG
  
;============================================================================
;键盘处理程序1_1 
     KEY1_1:  POP       BX
              JMP       BX
;============================================================================
;键盘处理程序1_2
     ;直流电机前进 
     KEY1_2:
              MOV       AL,[DC_ISRUN]
              TEST      AL,01H
              JNZ       NEXT_KEY1_2
              ;设置默认转速              
              MOV       AL,[DC_CLK_GEAR]
              MOV       [DC_CLK],AL
              MOV       DIG_DISPLAY,01H         ;更改数码管挡位显示
              
              CALL      DC_MOVE
              ;更改点阵显示 
              LEA       DX,UP_HI_PA
              MOV       [COL_LATTICE],DX
            NEXT_KEY1_2:
              POP       BX
              JMP       BX
              
;============================================================================
;键盘处理程序1_3 
     KEY1_3:  POP       BX
              JMP       BX
;============================================================================
;键盘处理程序1_4 
     KEY1_4:                        ;JMP       KEY1_4      ;死循环测试
              POP       BX
              JMP       BX
;============================================================================
;键盘处理程序2_1 
     ;步进电机左转向     
     KEY2_1:  CALL      STEP_LEFT_QUARTER

              MOV       DX,[COL_LATTICE]
              PUSH      DX          ;保存上一状态
              LEA       DX,LEFT_HI_PA
              MOV       [COL_LATTICE],DX
     
              MOV       DX,C_8255_1
         TEST_LOOP_LEFT:
              CALL      DISPLAY_STATIC
              IN        AL,DX
              TEST      AL,01H
              JZ        TEST_LOOP_LEFT

              POP       DX
              MOV       [COL_LATTICE],DX        ;恢复上一状态
              
              CALL      STEP_RIGHT_QUARTER
              POP       BX
              JMP       BX
              
;============================================================================
;键盘处理程序2_2
     ;直流电机停转 
     KEY2_2:  CALL      DC_STOP
              ;更改点阵显示 
              LEA       DX,STOP_HI_PA
              MOV       [COL_LATTICE],DX
              MOV       DIG_DISPLAY,0FFH        ;更改数码管挡位显示
              
              POP       BX
              JMP       BX
;============================================================================
;键盘处理程序2_3 
     ;步进电机右转向     
     KEY2_3:  CALL      STEP_RIGHT_QUARTER

              MOV       DX,[COL_LATTICE]
              PUSH      DX          ;保存上一状态
              LEA       DX,RIGHT_HI_PA
              MOV       [COL_LATTICE],DX
                   
              MOV       DX,C_8255_1
        TEST_LOOP_RIGHT:
              CALL      DISPLAY_STATIC
              IN        AL,DX
              TEST      AL,04H
              JZ        TEST_LOOP_RIGHT

              POP       DX
              MOV       [COL_LATTICE],DX        ;恢复上一状态
              
              CALL      STEP_LEFT_QUARTER
              POP       BX
              JMP       BX
              
;============================================================================
;键盘处理程序2_4 
     KEY2_4:  POP       BX
              JMP       BX
;============================================================================
;键盘处理程序3_1 
     KEY3_1:  POP       BX
              JMP       BX
;============================================================================
;键盘处理程序3_2
     KEY3_2:  POP       BX
              JMP       BX
;============================================================================
;键盘处理程序3_3 
     KEY3_3:  POP       BX
              JMP       BX
;============================================================================
;键盘处理程序3_4 
     KEY3_4:  POP       BX
              JMP       BX
;============================================================================
;键盘处理程序4_1
     ;直流电机一档 
     KEY4_1:  PUSH      AX
              MOV       AL,[DC_CLK_GEAR]
              MOV       [DC_CLK],AL
              CALL      DC_GEAR
              MOV       DIG_DISPLAY,01H         ;更改数码管挡位显示
              POP       AX
              POP       BX
              JMP       BX
;============================================================================
;键盘处理程序4_2
     ;直流电机二档  
     KEY4_2:  PUSH      AX
              MOV       AL,[DC_CLK_GEAR+1]
              MOV       [DC_CLK],AL
              CALL      DC_GEAR
              MOV       DIG_DISPLAY,02H         ;更改数码管挡位显示
              POP       AX
              POP       BX
              JMP       BX
;============================================================================
;键盘处理程序4_3
     ;直流电机三档  
     KEY4_3:  PUSH      AX
              MOV       AL,[DC_CLK_GEAR+2]
              MOV       [DC_CLK],AL
              MOV       DIG_DISPLAY,03H         ;更改数码管挡位显示
              CALL      DC_GEAR
              POP       AX
              POP       BX
              JMP       BX
              
;============================================================================
;键盘处理程序4_4
     ;直流电机四档   
     KEY4_4:  PUSH      AX
              MOV       AL,[DC_CLK_GEAR+3]
              MOV       [DC_CLK],AL
              MOV       DIG_DISPLAY,04H         ;更改数码管挡位显示
              CALL      DC_GEAR
              POP       AX
              POP       BX
              JMP       BX

 ;######################################################################             
              ;自定义函数 
 ;######################################################################               
;延时程序        
       DELAY  PROC
              PUSH      CX
              MOV       CX,200H
 DELAY_LOOP:  LOOP      DELAY_LOOP
              POP       CX
              RET
       DELAY  ENDP
;=======================================================================
;延时程序步进电机        
  DELAY_STEP  PROC
              PUSH      CX
              MOV       CX,800H
 DELAY_LOOP:  LOOP      DELAY_LOOP
              POP       CX
              RET
  DELAY_STEP  ENDP
;=======================================================================
;延时程序直流电机        
    DELAY_DC  PROC
              PUSH      CX
              MOV       CX,80H
 DELAY_LOOP:  LOOP      DELAY_LOOP
              POP       CX
              RET
    DELAY_DC  ENDP
;=======================================================================    
;点阵延时程序        
           DELAY_LATTICE  PROC
              PUSH      CX
              MOV       CX,20H
 DELAY_LOOP:  LOOP      DELAY_LOOP
              POP       CX
              RET
           DELAY_LATTICE  ENDP
;=======================================================================    
;数码管延时程序        
           DELAY_DIGITAL  PROC
              PUSH      CX
              MOV       CX,10H
 DELAY_LOOP:  LOOP      DELAY_LOOP
              POP       CX
              RET
           DELAY_DIGITAL  ENDP
;=======================================================================
;步进电机左转 
       STEP_LEFT_QUARTER  PROC
              PUSH      AX
              PUSH      CX
              PUSH      DX
              MOV       CX,19H      ;计算脉冲数量
              MOV       DX,C_8255_2
              MOV       AL,[STEP_TIMING]
  STEP_LOOP:  ROR       AL,1
              OUT       DX,AL
              CALL      DELAY_STEP
              LOOP      STEP_LOOP
              MOV       [STEP_TIMING],AL
              POP       DX
              POP       CX
              POP       AX
              RET
       STEP_LEFT_QUARTER  ENDP
;=======================================================================
;步进电机右转 
      STEP_RIGHT_QUARTER  PROC
              PUSH      AX
              PUSH      CX
              PUSH      DX
              MOV       CX,19H      ;计算脉冲数量
              MOV       DX,C_8255_2
              MOV       AL,[STEP_TIMING]
  STEP_LOOP:  ROL       AL,1
              OUT       DX,AL
              CALL      DELAY_STEP
              LOOP      STEP_LOOP
              MOV       [STEP_TIMING],AL
              POP       DX
              POP       CX
              POP       AX
              RET
      STEP_RIGHT_QUARTER  ENDP
;=======================================================================
;直流电机前进 
     DC_MOVE  PROC
              PUSH      AX
              PUSH      DX
              
              MOV       DX,CLK2_8253            ;CLK2赋初值
              MOV       AL,[DC_CLK]
              OUT       DX,AL
              
              MOV       DX,C_8255_3
              MOV       AL,01H      ;C0口置1,使GATE为高电平，开始计数
              OUT       DX,AL
              
              MOV       [DC_ISRUN],01H
              
              POP       DX
              POP       AX
              RET
     DC_MOVE  ENDP
;=======================================================================
;直流电机停转 
     DC_STOP  PROC
              PUSH      AX
              PUSH      DX
              MOV       DX,C_8255_3
              MOV       AL,00H      ;C0口置0,使GATE为低电平，停止计数
              OUT       DX,AL
              MOV       [DC_ISRUN],00H
              POP       DX
              POP       AX
              RET
     DC_STOP  ENDP
;=======================================================================
;直流电机换挡
     DC_GEAR  PROC
              PUSH      AX
              PUSH      DX
              MOV       AL,[DC_ISRUN]
              TEST      AL,01H
              JZ        EXIT
              CALL      DC_STOP
              CALL      DELAY_DC
              CALL      DC_MOVE
       EXIT:
              POP       DX
              POP       AX
              RET
     DC_GEAR  ENDP

;=======================================================================
;数码管显示  
         DIGITAL_DISPLAY  PROC
              PUSH      AX
              PUSH      BX
              PUSH      DX
              ;查表输出              
              MOV       BL,[DIG_DISPLAY]
              CMP       BL,0FFH     ;0FFH用于数码管不显示
              JZ        DIGPLAY_NULL
              
              AND       BX,000FH
              MOV       AL,[SEG_CODE+BX]
              MOV       DX,B_8255_1
              OUT       DX,AL
              ;延时              
              CALL      DELAY_DIGITAL

           DIGPLAY_NULL:
              MOV       DX,B_8255_1
              MOV       AL,00H
              OUT       DX,AL
              
              POP       DX
              POP       BX
              POP       AX

              RET
         DIGITAL_DISPLAY  ENDP
;=======================================================================
;清空点阵       
            DISPLAY_NULL  PROC
              PUSH      AX
              PUSH      DX
              MOV       AL,00H
              MOV       DX,A_8255_2
              OUT       DX,AL
              MOV       DX,B_8255_2
              OUT       DX,AL
              MOV       DX,A_8255_3
              OUT       DX,AL
              MOV       DX,B_8255_3
              OUT       DX,AL
              POP       DX
              POP       AX
              RET
            DISPLAY_NULL  ENDP
;=======================================================================            
;点阵静态显示(传递行列数据参数)            
          DISPLAY_STATIC  PROC
              PUSH      AX
              PUSH      BX
              PUSH      CX
              PUSH      DX
              PUSH      SI
              PUSH      DI
              CALL      DISPLAY_NULL
              MOV       BX,0000H
              
              MOV       SI,[ROW_LATTICE]
              MOV       DI,[COL_LATTICE]
              MOV       CX,00FFH
          DISPLAY_START:
              ;置点阵行选              
              MOV       AL,BYTE PTR[DI+BX]
              MOV       DX,A_8255_3
              OUT       DX,AL
              MOV       AL,BYTE PTR[DI+BX+16]
              MOV       DX,B_8255_3
              OUT       DX,AL
              ;置点阵列选              
              MOV       AL,BYTE PTR[SI+BX]
              MOV       DX,A_8255_2
              OUT       DX,AL
              MOV       AL,BYTE PTR[SI+BX+16]
              MOV       DX,B_8255_2
              OUT       DX,AL
              ;延时
              ;CALL      DELAY_LATTICE
              CALL      DIGITAL_DISPLAY
              ;点阵行选清零 
              MOV       AL,00H
              MOV       DX,A_8255_2
              OUT       DX,AL
              MOV       DX,B_8255_2
              OUT       DX,AL
              ;扫描下一列 
              INC       BX
              CMP       BX,0010H
              JZ        SET
              DEC       CX
              JZ        EXIT
              JMP       DISPLAY_START
              ;指针置零,从头扫描              
        SET:  MOV       BX,0000H
              DEC       CX
              JZ        EXIT
              JMP       DISPLAY_START
              
       EXIT:  POP       DI
              POP       SI
              POP       DX
              POP       CX
              POP       BX
              POP       AX
              RET
          DISPLAY_STATIC  ENDP

;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ENDLESS:
              JMP       ENDLESS
        CODE  ENDS
              END       START
