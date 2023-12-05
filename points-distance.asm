%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global points_distance
    extern printf

points_distance:
    ;; DO NOT MODIFY
    
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; points
    mov eax, [ebp + 12]     ; distance
    ;; DO NOT MODIFY
   
    ;; Your code starts here
 
	; in urmatoarele randuri imi explic ideea principala, apoi explic randurile in parte
	; initial ar fi fost: sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
	; dar, cand e paralel cu ox => diferenta de y-uri e 0, deci rezultatul e x2 - x1
	; cand e paralel cu oy => diferenta de x-uri e 0, deci rezultatul e y2 -y1
	; verifica daca DOAR doua puncte au acelasi x
	; iau registre mici, gen cl, dl pentru ca lucrez cu numere mici, asta din ce am observat din teste
	; daca as fi folosit registre mai mari, ar fi fost in ele alte valori, fiind completat cu f-uri
	; de mentionat faprul ca in cl si in dl se mentin, dupa caz x-urile (sau y-urile) primului, respectiv celui de-al doilea punct. 
	; ^ asa raman de-a lungul acestui program
	mov cl, [ebx + point.x] ; x-ul unui punct
	mov dl, [ebx + 4 + point.x] ; x-ul altui punct
	; iau cate 2 puncte
	cmp dl, cl ; le compar
	jne ok ; daca nu sunt egale x-urile fac diferenta dintre ele
	mov cl, [ebx + point.y] ; daca sunt egale, trece mai departe si face diferenta de y-uri de data aceasta
	; de aceea muta in cl pe y al primului punct
	mov dl, [ebx + 4 + point.y] ; si in dl pe y-ul celui de-al doilea
	jmp ok ; si verifica ordinea lor ca sa se faca diferenta in absoult
ok:
	cmp dl, cl ; mai compar o data ca sa stiu sa iau diferenta in absolut
	jl continue2 ; daca cel de-al doilea e mai mare face diferenta direct
	jmp continue1 ; daca e invers, atunci scade din al doilea pe primul
continue1:
	sub dl, cl ; dupa cum spuneam anterior, face diferenta dintre cordonta primului si celui de-al doilea
	mov [eax], dl ; muta in destinatie diferenta
	jmp return ; si inchide programul
continue2:
	sub cl, dl ; aici e asemanator ca la continue1, doar ca le face invers, in cazul in care al doilea este mai mare decat primul
	mov [eax], cl
	jmp return
return:
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret

    ;; DO NOT MODIFY
