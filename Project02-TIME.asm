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
	Input: .asciiz "D:/Project02/KTMT-HN-Project02/input.txt"
	Output: .asciiz "D:/Project02/KTMT-HN-Project02/output.txt"
	spc: .asciiz " "
	newline: .asciiz "\n"
	flash: .asciiz "/"
	
	#Cac bien luu tru
	day: .word 0 #bien luu ngay (int)
	month: .word 0 #bien luu thang (int)
	year: .word 0 #bien luu nam (int)
	str: .space 3 #chuoi luu ngay
	str1: .space 3 #chuoi luu thang
	str2: .space 10	#chuoi luu nam
	Buffer: .space 50 #bien luu chuoi doc tu file
	time1: .space 10 #chuoi luu time_1
	time2: .space 10 #chuoi luu time_2
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

#===== Ham chuc nang 01 =====
#Dau thu tuc
func01:
#khai bao stack
	addi $sp,$sp,-4
	#backup thanh ghi
	sw $ra,($sp)

#Than thu tuc
	la $a0,time1

	jal strcat

	la $a1,flash
	jal strcat

	move $a1,$a2
	jal strcat

	la $a1,flash
	jal strcat

	move $a1,$a3
	jal strcat

	la $v1,time1

#Cuoi thu tuc
	#Restore thanh ghi
	lw $ra,($sp)

	#xoa stack
	addi $sp,$sp,4
	#Tra ve
	jr $ra
	
#-------------------------

#==== Ham ghep chuoi =====
strcat:
	addi $sp,$sp,-12
	sw $t0,($sp)
	sw $t1,4($sp)
	sw $t2,8($sp)
	move $t0,$a0
	move $t1,$a1
strcat.turn: 
    	lb $t2,0($t1)
    	beqz $t2,strcat_done
   	sb $t2,0($t0)
    	addi $t0,$t0,1
   	addi $t1,$t1,1
   	j strcat.turn

strcat_done:
    	sb $zero,0($t0)
	move $a0,$t0
	lw $t0,($sp)
	lw $t1,4($sp)
	lw $t2,8($sp)
	addi $sp,$sp,12
    	jr $ra

#==== Ham chuc nang 9 =====
func09:
	addi $sp,$sp,-56
	sw $ra,32($sp)
	sw $s0,36($sp)
	sw $t0,40($sp)
	sw $t1,44($sp)
	sw $t2,48($sp)
	sw $t3,52($sp)
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
	
	la $t0,Buffer
	
	#close file
	li $v0,16
	move $a0,$s0
	syscall

	move $a0,$t0
	jal layTime

	jal func01 #tra ve $v1 = time1

	move $a3,$v1
	jal ghiFile

#-
	lw $ra,32($sp)
	lw $s0,36($sp)
	lw $t0,40($sp)
	lw $t1,44($sp)
	lw $t2,48($sp)
	lw $t3,56($sp)
	addi $sp,$sp,60
	jr $ra

layTime:
	addi $sp,$sp,-8
	sw $t0,($sp)
	sw $t1,4($sp)
	la $a1,str
	li $t1,0
	layNgay:  
	lb $t0,0($a0)
	beq $t1,2,prelayThang
	sb $t0,0($a1) 
	addi $a0,$a0,1 
	addi $t1,$t1,1
	addi $a1,$a1,1 
	j layNgay
	
	prelayThang:
	sb $zero,0($a1)
	addi $a0,$a0,1
	addi $t1,$t1,1
	la $a1,str1
	j layThang
	
	layThang:
	lb $t0,0($a0)
	beq $t1,5,prelayNam
	sb $t0,0($a1) 
	addi $a0,$a0,1 
	addi $t1,$t1,1
	addi $a1,$a1,1 
	j layThang
	
	prelayNam:
	sb $zero,0($a1)
	addi $a0,$a0,1
	la $a1,str2
	j layNam
	
	layNam:
	lb $t0,0($a0)
	beqz $t0,layTime.end
	sb $t0,0($a1) 
	addi $a0,$a0,1 
	addi $a1,$a1,1 
	j layNam

	layTime.end:
	sb $zero,0($a1)

	la $a1,str

	la $a2,str1
	
	la $a3,str2
	
	lw $t0,($sp)
	lw $t1,4($sp)
	addi $sp,$sp,8
	jr $ra
	
chuyenSo: #$a0 la chuoi nhap vao
	addi $sp,$sp,-32
	sw $ra,($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $s0,16($sp)
	sw $s1,20($sp)
	sw $s2,24($sp)
	sw $s3,28($sp)
#than thu tuc
	li $t2,0	#$t2 = 0
	li $s0,1
	li $s1,0
	li $s2,10
	li $s3,0

	jal countStr
	move $t2,$v0
	move $t1,$a0

	chay:
	beqz $t2,chay.end
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

	chay.end:
	move $v0,$s3 #return $v0 la so duoc chuyen tu chuoi

	lw $ra,($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $s0,16($sp)
	lw $s1,20($sp)
	lw $s2,24($sp)
	lw $s3,28($sp)
	addi $sp,$sp,32
	jr $ra

ghiFile:
	addi $sp,$sp,-8
	sw $s0,($sp)
	sw $ra,4($sp)
	#open
	li $v0,13
	la $a0,Output
	li $a1,1           
	syscall
	move $s0,$v0

	move $a0,$a3
	jal countStr

	#write
	move $a2,$v0
	li $v0,15
	move $a0,$s0
	move $a1,$a3
	syscall

	li $v0,16
	move $a0,$s0
	syscall
	
	lw $s0,($sp)
	lw $ra,4($sp)
	addi $sp,$sp,8
	jr $ra

countStr:
	addi $sp,$sp,-8
	sw $t0,($sp)
	sw $t1,4($sp)

	countStr.turn:
	lb $t0,($a0)
	beqz $t0,exit
	addi $a0,$a0,1
	addi $t1,$t1,1 #so luong char
	j countStr.turn

	exit:
	move $v0,$t1
	lw $t0,($sp)
	lw $t1,4($sp)
	addi $sp,$sp,8

	jr $ra

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
