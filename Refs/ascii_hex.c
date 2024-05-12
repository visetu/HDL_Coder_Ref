//
//  https://www.w3schools.com/c/tryc.php?filename=demo_compiler
//  https://www.tutorialspoint.com/compile_verilog_online.php
//

#include <stdio.h>
#include <stdlib.h> // Header file containing strtof function 

//-- function prototypes -----------------------------
  float  str_2_f( char  *char_array);
  char  *f_2_str( float  f         );

//-- declare variables --------
char    HexStr[]  = "0x12345678";
float   fq;
char   *HexStr2;//   = "0x12345678";

//---------------------------------------------------
int main() {
//---------------------------------------------------
 // printf("Hello World!  x = 0x%04x\n\r",x);
  
  printf("HexStr  = %s\n\r",  HexStr);   fq      = str_2_f( HexStr );    
  printf("Strtof  = %.4f\n\r",    fq);   HexStr2 = f_2_str(     fq );
  printf("HexStr2 = %s\n\r", HexStr2);  
  
// 1. The app receives "0xBRAMADDR 0xBRAMDATA" write command, then writes 0xBRAMDATA word into 0xBRAMADDR address.
// 2. The app receives "0xBRAMADDR"            read  command, then reads  32-bit word from 0xBRAMADDR address and transmit 0xBRAMDATA it to the host.
// 3. If 0xBRAMADDR == 0x8000_0054 then 0xBRAMDATA represents coded FLOAT number. The coding is as follows:
//
//       
//       0xBRAMDATA  ==> 0xSExManti ==> [0x19999999 throu 0x09999999] i.e. [-99.99999 throu +99.99999]
//       ||||||||||
//       ||||| \\\\\____ Manti[ssa]  (all digits are decimal, the MAX=99999)
//       ||| \\_________ Ex[ponent]  (all digits are decimal, the MAX=   99)  
//       || \___________ S[ign]      (0-positive, 1-negative)
//        \\____________ Not used
//
//      (1) 0xSExManti 
//

  return 0;
}

  int   i;        // 0123456789A

//-------------------------------------------
  float str_2_f( char *char_array)  {
//-------------------------------------------
     float f; 
     char  fStr[11]; 
  
     for (i=0; i<11; i=i+1) {
       if      ( i<=1                   )   fStr[i]=' ';
       else if (      i==2) {
               if   (char_array[2]=='1' )   fStr[i]='-';
               else                         fStr[i]=' ';
            }
       else if (      i >2 && i <5      )   fStr[i]=char_array[i];  
       else if (              i==5      )   fStr[i]='.';            
       else  /*(              i >5      )*/ fStr[i]=char_array[i-1];
     }
     f = strtof(fStr, NULL); 
     return f;
  }

//---------------------------------------------------
  char *f_2_str( float  f)  {
//--------------------------------------------------- 
     static char        af[10 + 1];  sprintf(af, "%.5f", f);
     static char        ah[10 + 1];
     int                qq;

                        ah[0] = '0'; 
                        ah[1] = 'x';

     if  (af[0]=='-') { ah[2] = '1'; i=1; qq=0; }
     else             { ah[2] = '0'; i=1; qq=1; }

     while  ( i-qq<4 && af[i-qq]!='.') {
       ah[i+2]=af[i-qq];       i=i+1;
     } // while

     while  ( i-qq < 10 )    {
       ah[i+2]=af[i-qq + 1];   i=i+1;
     } // while

     return ah;
  }