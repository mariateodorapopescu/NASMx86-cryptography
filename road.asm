%include "../include/io.mac"

struc point
    .x: resw 1
    .y: resw 1
endstruc

section .text
    global road
    extern printf

road:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]      ; points
    mov ecx, [ebp + 12]     ; len
    mov ebx, [ebp + 16]     ; distances
    ;; DO NOT MODIFY
   
    ;; Your code starts here
	; in urmatoarele randuri imi explic ideea principala, apoi explic randurile in parte
	; initial ar fi fost: sqrt((x2-x1)*(x2-x1)+(y2-y1)*(y2-y1))
	; dar, cand e paralel cu ox => diferenta de y-uri e 0, deci rezultatul e x2 - x1
	; cand e paralel cu oy => diferenta de x-uri e 0, deci rezultatul e y2 -y1
	; iau registre mici, gen cl, dl pentru ca lucrez cu numere mici, asta din ce am observat din teste
	; daca as fi folosit registre mai mari, ar fi fost in ele alte valori, fiind completat cu f-uri
	; de mentionat faprul ca in cl si in dl se mentin, dupa caz x-urile (sau y-urile) primului, respectiv celui de-al doilea punct. 
	; ^ asa raman de-a lungul acestui program
	xor edx, edx ; mai intai fac 0 registrele cu care lucrez, asta ca sa fiu sigura ca nu
	; am valori garbage aici
	xor esi, esi
	xor edi, edi
idk:
	mov si, [eax + point_size*edx + point.x] 
	; ^ x-ul punctului de la indexul edx, care initial e 0, ca porneste de la inceput
	mov di, [eax + point_size*edx + point_size + point.x]
	; ^ x-ul punctului urmatorul celui pe care l-am luat; iau cate 2, cate 2, plecand
	; de la ideea punctului 1
	cmp di, si ; le compar, si daca nu-s egale fac difernta intre x-uri
	jne ok
	mov si, [eax + point_size*edx + point.y] ; altfel, iau y-urile si fac diferenta intre ele
	mov di, [eax + point_size*edx + point_size + point.y]
	jmp ok ; verific care dintre ele e mai mare ca sa iau diferenta in absolut
	jmp continue1 
	; ^ aici se intoarce in cazul in care prima e mai mare decat a doua ca sa mearga mai departe
ok:
	cmp di, si ; aici verific care e mai mare ca sa stiu ce sa fac
	jl continue2 ; daca a doua e mai mare decat prima, scad din al doilea pe primul
	jg continue1 ; daca primul e mai mare, atunci face diferenta normal
	je continue3 ; daca atat x-urile, cat si y-urile sunt egale, pune 0 in regsitrul in care se cere rezultatul
continue1:
	sub di, si ; face diferenta 
	mov [ebx + 4*(edx)], edi ; si adauga in registrul destinatie
	inc edx ; trece la urmatorul punct din vector
	cmp edx, ecx ; compar adresa/indexul la care ma agflu sa stiu daca mai am elemente din vector
	jl idk ; daca mai am, atunci reiau
	; nu stiu ce nume sa le mai pun label-urilor
	jmp return ; daca nu mai sunt elemente de verificat in vector, atunci inchide programul
continue2:
	sub si, di ; aici e in cazul in care al doilea e mai mare decta primul
	mov [ebx + 4*(edx)], esi ; se procedeaza la fel ca la continue1, dar s-a facut diferenta dintre registre pe dos
	inc edx
	cmp edx, ecx
	jl idk
	jmp return
continue3:
	mov word [ebx + 4*(edx)], 0  ; si aici la fel, in cazul in care atat x-urile cat si y-urile sunt egale
	inc edx
	cmp edx, ecx
	jl idk
	jmp return
return:
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
