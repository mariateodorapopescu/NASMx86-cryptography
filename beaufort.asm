%include "../include/io.mac"

section .text
    global beaufort
    extern printf

; void beaufort(int len_plain, char *plain, int len_key, char *key, char tabula_recta[26][26], char *enc) ;
beaufort:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; len_plain
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; len_key
    mov edx, [ebp + 20] ; key (address of first element in matrix)
    mov edi, [ebp + 24] ; tabula_recta
    mov esi, [ebp + 28] ; enc
    ;; DO NOT MODIFY
    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE
    mov edi, [ebp + 8] ; nu folosesc deloc tabela, mai ales ca am gasit o formula;
	; in edi mut dimensiunea textului in clar
    xor eax, eax ; iterez prin sirul in clar
fori:
forj:
    mov ah, [edx] ; pun cate un caracter din cheie aici pentru ca sa completez, sa repet cheia cat sa aiba cate caractere are clarul
    mov [esi], ah
	inc esi ; asa iterez eu prin cheie
	inc edx ; iterez prin textul in clar
	dec ecx ; ma ajuta sa stiu de cate ori mai trebuie sa iterez prin cheie. nu e tocmai un for (j = strlen(cheie)-1; j >= 0; j--) dar e 
    ; (continuare) o modalitate buna de a ma ajuta sa trec prin cheie
	cmp ecx, 0
	jg forj ; iterez prin cheie pana cand ajung la final ca sa o pun intr-un sir in care sa o repet
    mov edx, [ebp + 20] ; iau adresa cheii
    mov ecx, [ebp + 16] ; iau adresa textului in clar
    sub edi, ecx ; fac diferenta dintre adrese, adica lungimi ca sa stiu cat sa completez/ de cate ori sa repet cheia
    cmp edi, 0 ; dau sunt egale sau textul; in clar are lungime mai mica decat cheia
    jle ok
    cmp edi, ecx ; daca diferenta e mai mare, iau si parcurg de la capat
    jge fori 
    mov ecx, edi ; mut noua dimensiune ramasa ca sa stiu cat iterez, cat prelungesc
    jmp fori
ok:
    mov esi, [ebp + 28] ; merg la inceputul cheii prelungite ca sa ma pregatesc sa parcurg simultan in chieie si textul in clar
    mov ecx, [ebp + 8] ; aici pun lungimea textului in clar
    xor eax, eax ; cu asta o sa iterez prin sirul in textul in clar
    jmp for
for:
        mov al, [esi] ; iau un caracter din cheia prelungita
        cmp al, [ebx] ; il compar cu un caracter din textul in clar
        sub al, [ebx] ; fac diferenta dintre cheie si clar, conform formuleui descoperite
		; adaug 65, adica litera A, ca in formula
		add byte al, 65 ; daca diefrenta a fost negativa, deci e mai mica decat litera A, nu mai face parte din alfabet
		; formula
		cmp al, 65 ; atunci adaug 26 ca sa ma intorc in interioruil alfabetului 
		jl neok 
        jmp continue ; daca nu, merge mai departe
neok:
        add al, 26
        jmp continue
continue:
    mov [esi], al ; mut in destinatie ce am modificat
	inc esi ; merg mai departe in cheia prelungita
	inc ebx ; merg mai departe in textul in clar
	dec ecx ; ma ajuta sa pun caractere in textul criptat
	cmp ecx, 0
	jg for ; acest for iau caracterele in acelasi timp cheia prelungita si textul in clar
    mov esi, [ebp + 28]
    jmp return
return:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY