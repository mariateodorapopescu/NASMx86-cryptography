%include "../include/io.mac"

section .text
    global spiral
    extern printf

; void spiral(int N, char *plain, int key[N][N], char *enc_string);
spiral:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]  ; N (size of key line)
    mov ebx, [ebp + 12] ; plain (address of first element in string)
    mov ecx, [ebp + 16] ; key (address of first element in matrix)
    mov edx, [ebp + 20] ; enc_string (address of first element in string)
    ;; DO NOT MODIFY
    ;; TODO: Implement spiral encryption
    ;; FREESTYLE STARTS HERE

	; deci... din nou, mai intai explic aici la inceput gandirea cu care am facut programul acesta
	; matricea o impart intr-un fel de patrate concentrice/unul in celalalt, pe care le parcurg astfel:
	; mai intai latura de sus, apoi latura din dreapta, apoi latura de jos si la urma latura din stanga
	; ca sa fie mai interativ: impart matricea in k patrate, in functie de paritatea lui N
	; o sa fac discutie dupa paritatea lui N mai incolo
	; iau linia k, apoi coloana N-k, apoi linia N-K apoi coloana k. 
    mov edi, eax ; aici pun lungimea unei linii din matrice
    mov ecx, eax ; si aici lungimea unei coloane din matrice
	; sunt egale, mai ales ca este matrice patratica
    mov esi, [ebp + 16] ; aici pun adresa primului element din matrice
    mov dword edi, 4 ; aici pun dimensiunea unui int; matricea e int. asta ma ajuta sa iterez prin ea
    mul edi ; il fac 16 pentru ca sa fie precizia mai buna la iterare (nu stiu cum sa ma exprim altfel),
	; ^ adica, 4 pentru linie, 4 pentru coloana (4 pentru ca atata ocupa int-ul -> word)
    mov edi, eax ; pun aici dimensiunea matricei ca sa ma duca pe coloana N, ca incep de la coloana N
    mov eax, ecx ; aici pun cam numarul de N patrate pe care il am 
fork:
    dec eax ; e un fel de for ( k = N; k >= 0; k--) in care iau patratele
	; fiecare patrat are dimensuiune k
	cmp eax, 0 ; verific daca am ajuns la elementul 0
    je neok ; fac verificarea pe caz a lui k si N. aici verific sa vad daca N e impar sau nu
    mov ecx, eax ; resetez contorul cum ar veni
	jmp lk
neok:
    mov edx, [esi] ; la numarul initial N, de iteratii
    add [ebx], edx ; si daca e, atunci mai fac inca o iteratie
    jmp return
lk:
	; aici iau linia k
    mov edx, [esi] ; aici pun caracterul (in ascii) din cheie, adica din matrice
    add [ebx], edx ; si il adaug la caracterul din textul in clar, conform formulei
    add ebx, 1 ; adaug 1 ca sa trec la urmatorul element din textul in clar
    add esi, 4 ; adaug 4 ca sa trec la elementul urmator din linie
    jmp next
continue:
    add esi, edi ; aici adaug adresa la care am ajuns
    add esi, 4 ; si inca 1 ca sa trec in patratul din interior
    dec eax ; scad din dimensiunea unui patrat 1 ca se micsoreaza patratele in mod progresiv
    cmp eax, 0
    jg fork
    jle return
cn_k:
; aici se intampla asemanator ca la parcurgerea liniei k (lk), doar ca nu mai adaug patru ci 16, ca ma duc pe o linie mai in jos
    mov edx, [esi] 
    add [ebx], edx
    add ebx, 1 ; iterez prin textul in clar
    add esi, edi ; adaug 16, ca ma duc pe o linie mai in jos
    jmp label
run:
	cmp ecx, 0 ; daca mai am elemente in clarul modificat
	jg copy
    dec edi
    cmp edi, 0
    jg cpy
    jmp done
next:
	dec ecx ; acesta este un contor care ma ajuta sa stiu cate elemente mai am in linie,
	; ^ desi ca elemente pornesc de la inceput la sfarsit
	cmp ecx, 0 ; daca mai am elemente in linie
	jg lk ; continui iterarea prin linie
    mov ecx, eax ; daca nu mai am elemente prin linie, mut inapoi in contor dimensiunea, pentru cand voi lua coloana n-k
	jmp cn_k
ln_k:
    ; aici este asemanator ca la linia k, doar ca merg de la sfarsit la inceput, asa ca scad din adresa matricei
	mov edx, [esi]
    add [ebx], edx
    inc ebx ; iterez prin textul in clar
    sub esi, 4 ; aici scad 4 pentru ca int si pentru ca in linie plec de la final la inceput
    dec ecx ; acesta este un contor care ma ajuta sa stiu cate elemente mai am in linie,
	cmp ecx, 0 ; daca mai am elemente in linie
	jg ln_k ; ma intorc aici ca sa termin elementele
	mov ecx, eax ; mut inapoi dimensiunea in contor, pentru urmatoarea iteratie
	jmp c_k
cpy:
    mov ecx, [ebp + 8] ; contorul ramane in continuare 
    jmp copy
c_k:
    mov edx, [esi] ; iau coloana k
    add [ebx], edx ; si urmatorul caracter din textul in clar
    inc ebx ; trec mai departe in textul in clar
    sub esi, edi ; scad 16 pentru ca urc o linie
    dec ecx ; acesta este un contor care ma ajuta sa stiu cate elemente mai am in coloana,
	; ^ desi ca elemente pornesc de la inceput la sfarsit
	cmp ecx, 0 ; daca mai am elemente in coloana
	jg c_k
	jmp continue ; dupa ce a facut un patrat, merg mai departe
copy:
    mov esi, [ebx] ; iau textul in clar, care a fost modificat; mai bine zis, iau ce e la adresa aia la indexul respectiv, inca de la inceput
	; da, stiu ca nu e un index propriu-zis, dar ioau adresa de inceput si merg mai departe
    mov [edx], esi ; si pun in destinatie
    inc ebx ; trec la urmatorul caracter din clarul modificat
    inc edx ; la fel si in ceea ce pun ce am modificat
    dec ecx
    jmp run
label:
    dec ecx ; acesta este un contor care ma ajuta sa stiu cate elemente mai am in coloana,
	; ^ desi ca elemente pornesc de la inceput la sfarsit
	cmp ecx, 0 ; daca mai am elemente in coloana
	jg cn_k ; continui iterarea prin coloana
    mov ecx, eax ; daca nu mai am elemente prin linie, mut dimensiunea, adica pun aici dimensiunea pentru linia N-k
	jmp ln_k
return:
    mov edx, [ebp + 20] ; dupa ce ies din fork (for k) care ia patratele, 
	; mut inapoi ce era la inceput in registre ca sa ma ajute la pus caracterele prelucrate in sirul criptat
	; adica in edx pun destinatia, in ebx - clarul si in edi - N-ul
    mov edi, [ebp + 8]
    mov ebx, [ebp + 12] 
    jmp cpy
done:
    ;; FREESTYLE ENDS HERE
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY
