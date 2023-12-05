%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
for:
	mov al, [esi + ecx - 1] ; pune o litera din sursa 
	add eax, edx ; adauga la litera aceea pasul
	cmp eax, 90 ; daca depaseste literele mari, Z = 90
	jg if ; o sa scada 26 ca sa ramana litera mare si se intoarce in bucla for
	jmp continue ; daca nu, continua
if:
	sub eax, 26 
	; aici intra doar daca litera continuta in al are valoarea in cod ascii mai mare decat 90, adica Z
	cmp eax, 91
	; si verifica si scade de fiecare data, cand e necesar, pana cand e mai mica decat Z
	jg if
	jmp continue ; daca face parte din alfabet nu scade si nu adauga, ci merge mai departe
continue:
	mov byte [edi + ecx - 1], al ; aici pune cate un caracter in textul criptat
	loop for
	jmp return ; daca a terminat de iterat prin sir, atunci inchide programul
return:
    ;; Your code ends here

    ;; DO NOT MODIFY

    popa
    leave
    ret
    
    ;; DO NOT MODIFY
