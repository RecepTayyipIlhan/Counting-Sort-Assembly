input_arr             dcd     5, 4, 3, 0, 3, 1
count_arr             dcd     0, 0, 0, 0, 0, 0
output_arr            dcd     0, 0, 0, 0, 0, 0



main                  

                      mov     r5,#0 ;dallanma sarti
                      mov     r3,#0 ; i
                      ldr     r1,=input_arr
                      ldr     r2,=count_arr
                      cmp     r5,#0
                      ldr     r8,[r1] ;size
                      beq     count_loop

                      mov     r10,#3 ;aranan değer
                      mov     r11,#0 ;offset

                      b       find_value
                      mov     r12,#0
                      mov     r5,#1

                      end


find_value            
                      add     r11,r11,#4
                      ldr     r9,[r1,r11]
                      cmp     r9,r10
                      beq     found
                      b       array_loop_control

found                 
                      mov     r12,#1
                      b       exit



exit                  

                      end


array_loop_control    
                      subs    r8,r8,#1
                      cmp     r8,#0
                      beq     exit
                      b       find_value



count_loop            
                      ldr     r4, [r1, r3, lsl #2] ; r4 = array[i] r1+r3*4 adresindeki değer
                      ldr     r5, [r2, r4, lsl #2] ; r5 = count[array[i]] r2+r4*4
                      add     r5, r5, #1
                      str     r5, [r2, r4, lsl #2]
                      cmp     r3,r8
                      beq     cumulaitif
                      add     r3,r3,#1
                      b       count_loop

cumulaitif            
                      mov     r3,#0

cumulaitif_count_loop 
                      ldr     r4, [r2, r3, lsl #2] ;r2+r3*4 adresindeki değeri r4'e yükle
                      add     r3,r3,#1
                      ldr     r5, [r2, r3, lsl #2] ; r2+r3*4 adresindeki değeri r5'e yükle
                      add     r5, r5,r4
                      str     r5, [r2, r3, lsl #2]
                      cmp     r3,r8
                      beq     start_output
                      b       cumulaitif_count_loop
start_output          
                      ldr     r0,=output_arr
                      mov     r3,#5

output                
                      ldr     r4, [r1, r3, lsl #2] ; array[i]
                      ldr     r5,[r2,r4,lsl #2] ;count_arr[array[i]]
                      sub     r5,r5,#1
                      str     r4, [r0, r5, lsl #2] ; output_arr[count_arr[array[i]]-1] = array[i];
                      str     r5,[r2,r4,lsl #2]
                      cmp     r3,#0
                      beq     exit
                      sub     r3,r3,#1
                      b       output