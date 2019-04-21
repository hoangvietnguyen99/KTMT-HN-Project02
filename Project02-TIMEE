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
	tb10: .asciiz "\n     	B.DD Month, YYYY"
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
	d: .word 0
	m: .word 0
	y: .word 0
.text
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

	#Goi ham xuat menu
	jal xuat_menu

	#Luu ket qua tra ve ham xuat_menu (Lua chon cua nguoi dung)
	move $t0,$v0

	#Thuc thi menu
	beq $t0,1,func1
func1:
	jal func01
	#beq $t0,2,func02
	#beq $t0,3,func03
	#beq $t0,4,func04
	#beq $t0,5,func05
	#beq $t0,6,func06
	#beq $t0,7,func07
	#beq $t0,8,func08
	#beq $t0,9,func09	

ket_thuc:
	#ket thuc
	li $v0,10
	syscall

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
	lw $a0,d
	li $v0,1
	syscall

	#Dinh dang
	li $v0,4
	la $a0,tb4
	syscall

	#Xuat MONTH
	lw $a0,m
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

#Cuoi thu tuc
	#Restore thanh ghi
	lw $ra,($sp)

	#xoa stack
	addi $sp,$sp,4
	#Tra ve
	jr $ra
	
#-------------------------
