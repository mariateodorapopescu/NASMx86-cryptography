%include "../include/io.mac"

section .text
    global is_square
    extern printf

is_square:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov ebx, [ebp + 8]      ; dist
    mov eax, [ebp + 12]     ; nr
    mov ecx, [ebp + 16]     ; sq
    ;; DO NOT MODIFY
    ;; Your code starts here
	; nu, eu folosesc alte registre
	; pentru ca ecx -> contor; voiam initial sa fac un loop dar pana la urma am pus conditie de oprire, compratie cu 0
	; in eax se pune rezultatul inmultirii. la un moment dat o sa folosesc o inmultire
	mov esi, [ebp + 8]
	mov ecx, [ebp + 12]
	mov edi, [ebp + 16]
	; mai intai fac 0 registrele cu care lucrez, asta ca sa fiu sigura ca nu
	; am valori garbage aici
	xor eax, eax
	xor ebx, ebx
	xor edx, edx
	dec ecx ; cum in ecx e numarul de elemente, iar de data asta iau de la sfarsirt la inceput, 
	; o sa fie cu un element in plus fata de cate sunt, de fapt, in vector, de aceea decrementez de la inceput
	; o sa scriu aici ideea mea in c ca mi-e mai usor asa:
	; for (i = nr_elem_vector - 1; i >= 0; i--)
	; for (j = 1; j <= elem_curent_din_vector; j++)
	; if (j * j == elem_curent_din_vector)
	; atunci pune 1 in vectorul in care se cere rezultatul 
fori: 
	mov ebx, [esi + ecx * 4] ; deci, aici iau elementul curent din vector
	mov dword [edi + 4 * ecx], 0 ; mai intai presupun ca nu e patrat perfect, de aceea pun 0 im vectoruld estinatie
	mov dl, 1 ; asta e pe post de j
	jmp forj ; si da, intru in forul sugestiv de mai sus cu j 
forj:
	mov al, dl ; ma pregatesc sa fac patratul j-ului
	mul al
	cmp eax, ebx ; si sa-l compar cu elementul curent din vector
	je ok ; si daca e radacina lui, atunci se duce la label-ul in care pune 1
	jne continue ; daca nu, trece mai departe
continue:
	inc dl ; si daca a trecut mai departe, trece la urmatorul j, factor, ca sa afle radacina, in cazul in care e patrat perfect
	cmp edx, ebx ; compara cu numarul ca sa stiu cand ies din for-ul sugestiv cu j
	jle forj
	dec ecx ; si daca am terminat cu verificarea existentei radacinii (fie ca am gasit-o, fie ca nu), atunci trec mai departe in vector 
	cmp ecx, 0 ; si vad daca mai am de verificat elemente din vector sau nu
	jge fori ; daca da, reia for-ul cu i sugestiv 
	jle return ; daca nu, atunci iese din program
ok:
	add dword [edi + 4 * ecx], 1 ; daca e radacina, adica daca patratul factorului e elementul curent
	jmp continue ; pune 1 in vectorul in care se cere rezultatul
	; se pune 1 (sau 0 atunci la inceput de tot) pe pozitia specifica elementului din celalalt vector
return:
    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
