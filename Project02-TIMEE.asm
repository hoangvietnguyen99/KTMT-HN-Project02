.data
	tb1: .asciiz "Nhap ngay DAY: "
	tb2: .asciiz "Nhap thang MONTH: "
	tb3: .asciiz "Nhap nam YEAR: "
	tb4: .asciiz "/"
	tb5: .asciiz "----------Ban hay chon 1 trong cac thao tac duoi day -----"
	tb6: .asciiz "\n     1.Xuat chuoi TIME theo dinh dang DD/MM/YYYY"
	tb7: .asciiz "\n     2.Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau:"
	tb8: .asciiz "\n     	A.MM/DD/YYYY"
	tb9: .asciiz "\n     	B.Month DD, YYYY"
	tb10: .asciiz "\n     	C.DD Month, YYYY"
	tb11: .asciiz "\n     3.Kiem tra nam trong chuoi TIME co phai la nam nhuan khong"
	tb12: .asciiz "\n     4.Cho biet ngay vua nhap la ngay thu may trong tuan"
	tb13: .asciiz "\n     5.Cho biet ngay vua nhap la ngay thu may ke tu ngay 1/1/1"
	tb14: .asciiz "\n     6.Cho biet can chi cua nam vua nhap"
	tb15: .asciiz "\n     7.Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2"
	tb16: .asciiz "\n     8.Cho biet 2 nam gan nhat voi nam trong chuoi TIME"
	tb17: .asciiz "\n     9.Nhap input tu file input.txt xuat ket qua toan bo cac chuc nang tren ra file output.txt"
	tb18: .asciiz "\n---------------------------------------------------------"
	tb19: .asciiz "\n  .Lua chon: "
	tb20: .asciiz "  .Ket qua: "
	tb21: .asciiz "January"
	tb22: .asciiz "February"
	tb23: .asciiz "March"
	tb24: .asciiz "April"
	tb25: .asciiz "May"
	tb26: .asciiz "June"
	tb27: .asciiz "July"
	tb28: .asciiz "August"
	tb29: .asciiz "September"
	tb30: .asciiz "October"
	tb31: .asciiz "November"
	tb32: .asciiz "December"
	tb33: .asciiz " "
	tb34: .asciiz ", "
	tb35: .asciiz "A.MM/DD/YYYY\nB.Month DD, YYYY\nC.DD Month, YYYY"
	tb36: .asciiz "\n"
	Input: .asciiz "D:/Project02/KTMT-HN-Project02/input.txt"
	Output: .asciiz "output.txt"
	Buffer: .space 50
	d: .word 0
	m: .word 0
	y: .word 0
.text
main:
	#Kiem tra tinh hop le cua time nhap vao
	#jal kTraHopLe

	#Goi ham xuat menu
	jal xuat_menu

	#Luu ket qua tra ve ham xuat_menu (Lua chon cua nguoi dung)
	move $t0,$v0

	#Thuc thi menu
	blt $t0,9,console
	beq $t0,9,func9
	j ket_thuc
	
console:
	beq $t0,1,func1
	beq $t0,2,func2
	#beq $t0,3,func3
	#beq $t0,4,func4
	#beq $t0,5,func5
	#beq $t0,6,func6
	#beq $t0,7,func7
	#beq $t0,8,func8

func1:
	jal nhap

	#truyen tham so
	lw $a1,d
	lw $a2,m
	lw $a3,y
	
	jal func01
	j ket_thuc
func2:
	#Xuat thong bao cac lua chon
	li $v0,4
	la $a0,tb35
	syscall
	
	#Xuat thong bao lua chon
	li $v0,4
	la $a0,tb19
	syscall

	#nhap lua chon
	li $v0,12
	syscall
	
	move $t0,$v0
	
	li $v0,4
	la $a0,tb36
	syscall
	
	beq $t0,'A',runfunc2
	beq $t0,'B',runfunc2
	beq $t0,'C',runfunc2
	j func2
	
runfunc2:
	jal nhap
	#truyen tham so
	move $a0,$t0 #tham so type
	lw $a1,d
	lw $a2,m
	lw $a3,y

	jal func02
	j ket_thuc

func9:
	jal func09
	
	j ket_thuc

ket_thuc:
	#ket thuc
	li $v0,10
	syscall

#===== Ham nhap =====
#Dau thu tuc
nhap:
#khai bao stack
	addi $sp,$sp,-4
	#backup thanh ghi
	sw $ra,($sp)
#than thu tuc
	#xuat tb1
	li $v0,4
	la $a0,tb1
	syscall
	
	#Nhap DAY
	li $v0,5
	syscall

	#Luu vao DAY
	sw $v0,d

	#xuat tb2
	li $v0,4
	la $a0,tb2
	syscall
	
	#Nhap MONTH
	li $v0,5
	syscall

	#Luu vao MONTH
	sw $v0,m

	#xuat tb3
	li $v0,4
	la $a0,tb3
	syscall
	
	#Nhap YEAR
	li $v0,5
	syscall

	#Luu vao YEAR
	sw $v0,y

#Cuoi thu tuc
	#Restore thanh ghi
	lw $ra,($sp)

	#xoa stack
	addi $sp,$sp,4
	#Tra ve
	jr $ra

#-------------------------

#===== Ham XuatMenu =====
#Dau thu tuc
xuat_menu:
#khai bao stack
	addi $sp,$sp,-8
	#backup thanh ghi
	sw $ra,($sp)
	sw $t0,4($sp)

#than thu tuc:
xuat_menu.lap:
	#xuat menu
	li $v0,4
	la $a0,tb5
	syscall
	li $v0,4
	la $a0,tb6
	syscall
	li $v0,4
	la $a0,tb7
	syscall
	li $v0,4
	la $a0,tb8
	syscall
	li $v0,4
	la $a0,tb9
	syscall
	li $v0,4
	la $a0,tb10
	syscall
	li $v0,4
	la $a0,tb11
	syscall
	li $v0,4
	la $a0,tb12
	syscall
	li $v0,4
	la $a0,tb13
	syscall
	li $v0,4
	la $a0,tb14
	syscall
	li $v0,4
	la $a0,tb15
	syscall
	li $v0,4
	la $a0,tb16
	syscall
	li $v0,4
	la $a0,tb17
	syscall
	li $v0,4
	la $a0,tb18
	syscall
	li $v0,4
	la $a0,tb19
	syscall

	#Nhap chon
	li $v0,5
	syscall

	#luu vao t0
	move $t0,$v0

	#Xet gia tri nhap vao
	bgt $t0,9,xuat_menu.lap

#Cuoi thu tuc
	#Restore thanh ghi
	lw $ra,($sp)
	lw $t0,4($sp)

	#xoa stack
	addi $sp,$sp,8
	#Tra ve
	jr $ra
	
#-------------------------

#===== Ham chuc nang 01 =====
#Dau thu tuc
func01:
#khai bao stack
	addi $sp,$sp,-4
	#backup thanh ghi
	sw $ra,($sp)

#Than thu tuc
	#Xuat thong bao ket qua
	li $v0,4
	la $a0,tb20
	syscall

	#Xuat DAY
	move $a0,$a1
	li $v0,1
	syscall

	#Dinh dang
	li $v0,4
	la $a0,tb4
	syscall

	#Xuat MONTH
	move $a0,$a2
	li $v0,1
	syscall

	#Dinh dang
	li $v0,4
	la $a0,tb4
	syscall

	#Xuat YEAR
	move $a0,$a3
	li $v0,1
	syscall	

#Cuoi thu tuc
	#Restore thanh ghi
	lw $ra,($sp)

	#xoa stack
	addi $sp,$sp,4
	#Tra ve
	jr $ra
	
#-------------------------

#===== Ham chuc nang 02a =====
#Dau thu tuc
func02:
#khai bao stack
	addi $sp,$sp,-12
	#backup thanh ghi
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)

#Than thu tuc
	
	#luu lai lua chon
	move $t0,$a0

	#xuat thong bao ket qua
	li $v0,4
	la $a0,tb20
	syscall
	
	#xu ly
	beq $t0,'A',a
	j xuly1

a:
	#Xuat MONTH
	lw $a0,m
	li $v0,1
	syscall

	#Dinh dang
	li $v0,4
	la $a0,tb4
	syscall

	#Xuat DAY
	move $a0,$a1
	li $v0,1
	syscall

	#Dinh dang
	li $v0,4
	la $a0,tb4
	syscall

	#Xuat YEAR
	lw $a0,y
	li $v0,1
	syscall

	j end

xuly1:
	beq $t0,'B',xuly2
	move $a0,$a1
	li $v0,1
	syscall
	
	li $v0,4
	la $a0,tb33
	syscall

	j xuly2

xuly2:
	move $t1,$a1
	beq $t1,1,jan
	beq $t1,2,feb
	beq $t1,3,mar
	beq $t1,4,apr
	beq $t1,5,may
	beq $t1,6,jun
	beq $t1,7,jul
	beq $t1,8,aug
	beq $t1,9,sep
	beq $t1,10,oct
	beq $t1,11,nov
	beq $t1,12,dec

xuly3:
	beq $t0,'C',xuly4
	li $v0,4
	la $a0,tb33
	syscall
	
	move $a0,$a1
	li $v0,1
	syscall

	j xuly4
		
xuly4:
	li $v0,4
	la $a0,tb34
	syscall

	move $a0,$a3
	li $v0,1
	syscall
	
	j end

jan:
	li $v0,4
	la $a0,tb21
	syscall
	j xuly3
feb:
	li $v0,4
	la $a0,tb22
	syscall
	j xuly3
mar:
	li $v0,4
	la $a0,tb23
	syscall
	j xuly3
apr:
	li $v0,4
	la $a0,tb24
	syscall
	j xuly3
may:
	li $v0,4
	la $a0,tb25
	syscall
	j xuly3
jun:
	li $v0,4
	la $a0,tb26
	syscall
	j xuly3
jul:
	li $v0,4
	la $a0,tb27
	syscall
	j xuly3
aug:
	li $v0,4
	la $a0,tb28
	syscall
	j xuly3
sep:
	li $v0,4
	la $a0,tb29
	syscall
	j xuly3
oct:
	li $v0,4
	la $a0,tb30
	syscall
	j xuly3
nov:
	li $v0,4
	la $a0,tb31
	syscall
	j xuly3
dec:
	li $v0,4
	la $a0,tb32
	syscall
	j xuly3

end:
#Cuoi thu tuc
	#Restore thanh ghi
	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)

	#xoa stack
	addi $sp,$sp,12
	#Tra ve
	jr $ra
	
#-------------------------

#==== Ham chuc nang 9 =====
func09:
	addi $sp,$sp,-16
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)
#than thu tuc
	li $v0,13
	la $a0,Input
	li $a1,0
	syscall
	move $s0,$v0
	
	#read
	li $v0,14
	move $a0,$s0
	la $a1,Buffer
	la $a2,50
	syscall

	la $t0,Buffer
	li $t1,0
countChr:  
	lb $t2,0($t0)
	beqz $t2, end1 
	add $t0,$t0,1 
	add $t1,$t1,1 
	j countChr

end1:	
	#print buffer
	li $v0,4
	la $a0,Buffer
	syscall

	li $v0,4
	la $a0,tb36
	syscall
	
	#print number of char
	li $v0,1
	move $a0,$t1
	syscall

	#close file
	li $v0,16
	move $a0,$s0
	syscall
#-
	lw $ra,($sp)
	lw $s0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	addi $sp,$sp,16
	jr $ra
