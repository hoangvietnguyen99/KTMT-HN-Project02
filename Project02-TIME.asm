.data
	#Nhung dong thong bao
	nhapNgay: .asciiz "Nhap ngay DAY: "
	nhapThang: .asciiz "Nhap thang MONTH: "
	nhapNam: .asciiz "Nhap nam YEAR: "
	menuHeader: .asciiz "-------- Ban hay chon 1 trong cac thao tac duoi day --------\n"
	menu1: .asciiz "1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"
	menu2: .asciiz "2. Chuyen doi chuoi TIME thanh 1 trong cac dinh dang sau:\n"
	menu2a: .asciiz "A. MM/DD/YYYY\n"
	menu2b: .asciiz "B. Month DD, YYYY\n"
	menu2c: .asciiz "C. DD Month, YYYY\n"
	menu3: .asciiz "3. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong\n"
	menu4: .asciiz "4. Cho biet ngay vua nhap la ngay thu may trong tuan\n"
	menu5: .asciiz "5. Cho biet ngay vua nhap la ngay thu may ke tu ngay 1/1/1\n"
	menu6: .asciiz "6. Cho biet can chi cua nam vua nhap. Vi du nam 2019 la Ky Hoi\n"
	menu7: .asciiz "7. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2\n"
	menu8: .asciiz "8. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi TIME\n"
	menu9: .asciiz "9. Nhap input tu file input.txt xuat ket qua toan bo cac chuc nang tren ra file output.txt\n"
	thoat: .asciiz "0. Thoat chuong trinh.\n"
	line: .asciiz "---------------------------------------------------------\n"
	luachon: .asciiz "* Lua chon: "
	ketqua: .asciiz "* Ket qua: "
	Input: .asciiz "D:/ITUS/KTMT-HN-Project02/input.txt"
	spc: .asciiz " "
	newline: .asciiz "\n"
	
	#Cac bien luu tru
	day: .word 0
	month: .word 0
	year: .word 0
	str: .space 10
	str1: .space 10
	str2: .space 10
	Buffer: .space 50
.text
main:
	#Kiem tra tinh hop le cua time nhap vao
	#jal kTraHopLe

	#Goi ham xuat menu
	jal xuatMenu

	#Luu ket qua tra ve ham xuatMenu (Lua chon cua nguoi dung)
	move $t0,$v0

	#Thuc thi menu
	blt $t0,9,console
	beq $t0,9,func9
	beqz $t0,ketthuc
	
	console:
	beq $t0,1,func1
	#beq $t0,2,func2
	#beq $t0,3,func3
	#beq $t0,4,func4
	#beq $t0,5,func5
	#beq $t0,6,func6
	#beq $t0,7,func7
	#beq $t0,8,func8
	func1:
	jal nhapChuoiTIME
	
	func9:
	jal func09
	j ketthuc
	
	ketthuc:
	li $v0,10
	syscall
#===== Ham XuatMenu =====
#Dau thu tuc
xuatMenu:
#khai bao stack
	addi $sp,$sp,-8
	#backup thanh ghi
	sw $ra,($sp)
	sw $t0,4($sp)

#than thu tuc:
xuatMenu.lap:
	#xuat menu
	li $v0,4
	la $a0,menuHeader
	syscall
	li $v0,4
	la $a0,menu1
	syscall
	li $v0,4
	la $a0,menu2
	syscall
	li $v0,4
	la $a0,menu2a
	syscall
	li $v0,4
	la $a0,menu2b
	syscall
	li $v0,4
	la $a0,menu2c
	syscall
	li $v0,4
	la $a0,menu3
	syscall
	li $v0,4
	la $a0,menu4
	syscall
	li $v0,4
	la $a0,menu5
	syscall
	li $v0,4
	la $a0,menu6
	syscall
	li $v0,4
	la $a0,menu7
	syscall
	li $v0,4
	la $a0,menu8
	syscall
	li $v0,4
	la $a0,menu9
	syscall
	li $v0,4
	la $a0,thoat
	syscall
	li $v0,4
	la $a0,line
	syscall
	li $v0,4
	la $a0,luachon
	syscall

	#Nhap chon
	li $v0,5
	syscall

	#luu vao t0
	move $t0,$v0

	#Xet gia tri nhap vao
	#nhay den nhan xuatMenu.lap neu $t0 > 9
	bgt $t0,9,xuatMenu.lap
	bltz $t0,xuatMenu.lap

#Cuoi thu tuc
	#Restore thanh ghi
	lw $ra,($sp)
	lw $t0,4($sp)

	#xoa stack
	addi $sp,$sp,8
	#Tra ve
	jr $ra
	
#-------------------------

#===== Ham nhap =====
#Dau thu tuc	
nhapChuoiTIME:
#khai bao stack
	addi $sp,$sp,-4
	#backup thanh ghi
	sw $ra,($sp)
	
#than thu tuc
	#Nhap Ngay
	li $v0,4
	la $a0,nhapNgay
	syscall

	li $v0,5
	syscall

	#Luu vao day
	sw $v0,day

	#Nhap Thang
	li $v0,4
	la $a0,nhapThang
	syscall

	li $v0,5
	syscall

	#Luu vao month
	sw $v0,month
	
	#Nhap Nam
	li $v0,4
	la $a0,nhapNam
	syscall

	li $v0,5
	syscall

	#Luu vao year
	sw $v0,year
	
#Cuoi thu tuc
	#Restore thanh ghi
	lw $ra,($sp)

	#xoa stack
	addi $sp,$sp,4
	#Tra ve
	jr $ra

#==== Ham chuc nang 9 =====
func09:
	addi $sp,$sp,-20
	sw $ra,($sp)
	sw $s0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)
	sw $t3,20($sp)
#than thu tuc
	li $v0,13 #open file
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

	#lay ngay
	la $t0,Buffer
	la $t3,str
	
	layNgay:  
	lb $t2,0($t0)
	beq $t1,2,prelayThang
	sb $t2,0($t3) 
	addi $t0,$t0,1 
	addi $t1,$t1,1
	addi $t3,$t3,1 
	j layNgay
	
	prelayThang:
	sb $zero,0($t3)
	addi $t0,$t0,1
	addi $t1,$t1,1
	la $t3,str1
	j layThang
	
	layThang:
	lb $t2,0($t0)
	beq $t1,5,prelayNam
	sb $t2,0($t3) 
	addi $t0,$t0,1 
	addi $t1,$t1,1
	addi $t3,$t3,1 
	j layThang
	
	prelayNam:
	sb $zero,0($t3)
	addi $t0,$t0,1
	addi $t1,$t1,1
	la $t3,str2
	j layNam
	
	layNam:
	lb $t2,0($t0)
	beqz $t2,end1
	sb $t2,0($t3) 
	addi $t0,$t0,1 
	addi $t1,$t1,1
	addi $t3,$t3,1 
	j layNam
end1:
	sb $zero,0($t3)
	#print buffer
	la $t1,str
	j chuyenSo
	

	li $v0,4
	la $a0,newline
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
	lw $t3,20($sp)
	addi $sp,$sp,20
	jr $ra
	
chuyenSo:
#than thu tuc
	li $t2,0	#$t2 = 0
	li $s0,1
	li $s2,10
	li $s3,0	
countStr:
	lb $t0,($t1)
	beqz $t0,chay
	addi $t1,$t1,1
	addi $t2,$t2,1 #so luong char
	j countStr
	
chay:
	beqz $t2,end
	subi $t1,$t1,1
	lb $t0,($t1)
	subi $t0,$t0,48
	mult $t0,$s0
	mflo $s1
	add $s3,$s3,$s1
	subi $t2,$t2,1
	mult $s0,$s2
	mflo $s0
	
	j chay

	end:
	li $v0,1
	move $a0,$s3
	syscall	
kiemtraTIMEhople:


xuatTIME:

chuyendoiTIME:

kiemtraNamNhuan:

NgayThuMaytrongTuan:

NgayThuMayketuNgayDauTien:

CanChicuaNam:

KhoangThoiGiangiuaHaiChuoiTIME:

HaiNamNhuangannhat:

xulyFile:
