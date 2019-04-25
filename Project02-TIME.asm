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
	Jan: .asciiz "January"
	Feb: .asciiz "February"
	Mar: .asciiz "March"
	Apr: .asciiz "April"
	May: .asciiz "May"
	Jun: .asciiz "June"
	Jul: .asciiz "July"
	Aug: .asciiz "August"
	Sep: .asciiz "September"
	Oct: .asciiz "October"
	Nov: .asciiz "November"
	Dec: .asciiz "December"
	comma: .asciiz ", "
	
	#Cac bien luu tru
	day: .word 0 #bien luu ngay (int)
	month: .word 0 #bien luu thang (int)
	year: .word 0 #bien luu nam (int)
	str: .space 3 #chuoi luu ngay
	str1: .space 3 #chuoi luu thang
	str2: .space 10	#chuoi luu nam
	str3:. space 10 #chuoi luu tam
	Buffer: .space 50 #bien luu chuoi doc tu file
	time1: .space 50 #chuoi luu time_1
	time2: .space 50 #chuoi luu time_2
	time_1: .space 50 #chuoi luu time_1
	time_2: .space 50 #chuoi luu time_2
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
	beq $t0,2,func2
	#beq $t0,3,func3
	#beq $t0,4,func4
	#beq $t0,5,func5
	#beq $t0,6,func6
	#beq $t0,7,func7
	#beq $t0,8,func8
	func1:
	jal nhapChuoiTIME
	j func1.run
	
	#xu ly ngay thang nam sang chuoi
	func1.run:
	#xu ly ngay
	lw $a0,day
	la $a1,str
	li $a2,0
	jal chuyenChu

	#xu ly thang
	lw $a0,month
	la $a1,str1
	li $a2,0
	jal chuyenChu

	#xu ly nam
	lw $a0,year
	la $a1,str2
	li $a2,1
	jal chuyenChu
	
	la $a1,str
	la $a2,str1
	la $a3,str2
	jal xuatTIME

	li $v0,4
	la $a0,ketqua
	syscall
	
	li $v0,4
	la $a0,time1
	syscall
	j ketthuc
	
	func2:
	#nhap
	jal nhapChuoiTIME

	#xu ly ngay
	lw $a0,day
	la $a1,str
	li $a2,0
	jal chuyenChu

	#xu ly thang
	lw $a0,month
	la $a1,str1
	li $a2,0
	jal chuyenChu

	#xu ly nam
	lw $a0,year
	la $a1,str2
	li $a2,1
	jal chuyenChu

	#Xuat thong bao cac lua chon
	li $v0,4
	la $a0,menu2a
	syscall

	li $v0,4
	la $a0,menu2b
	syscall

	li $v0,4
	la $a0,menu2c
	syscall
	
	func2chon:
	#Xuat thong bao lua chon
	li $v0,4
	la $a0,luachon
	syscall

	#nhap lua chon
	li $v0,12
	syscall
	
	move $t0,$v0
	
	li $v0,4
	la $a0,newline
	syscall
	
	beq $t0,'A',runfunc2
	beq $t0,'B',runfunc2
	beq $t0,'C',runfunc2
	j func2chon
	
runfunc2:

	#truyen tham so
	move $a0,$t0 #tham so type
	la $a1,str
	la $a2,str1
	la $a3,str2

	jal chuyendoiTIME

	li $v0,4
	la $a0,ketqua
	syscall
	
	li $v0,4
	la $a0,time1
	syscall
	j ketthuc
	
	func9:
	jal xulyFile
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
xuatTIME: #tham so $a1 = day(2), $a2 = month(2), $a3 = year(4)
#khai bao stack
	addi $sp,$sp,-4
	#backup thanh ghi
	sw $ra,($sp)

#Than thu tuc
	la $a0,time1

	jal strcat #tham so dau vao $a0, $a1

	la $a1,flash
	jal strcat

	move $a1,$a2
	jal strcat

	la $a1,flash
	jal strcat

	move $a1,$a3
	jal strcat

	la $v1,time1 #tra ve $v1 = time1

#Cuoi thu tuc
	#Restore thanh ghi
	lw $ra,($sp)

	#xoa stack
	addi $sp,$sp,4
	#Tra ve
	jr $ra
	
#-------------------------

#==== Ham ghep chuoi =====
strcat: #tham so dau vao $a0, $a1
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

#===== Ham chuc nang 02a =====
#Dau thu tuc
chuyendoiTIME: #tham so $a1 = day(2), $a2 = month(2), $a3 = year(4)
#khai bao stack
	addi $sp,$sp,-40
	#backup thanh ghi
	sw $ra,32($sp)
	sw $t0,36($sp)
	sw $t1,40($sp)

#Than thu tuc
	
	#luu lai lua chon
	move $t0,$a0
	
	#xu ly
	beq $t0,'A',A
	move $a0,$a2
	jal chuyenSo
	move $t1,$v0
	move $a2,$a1
	la $a0,time1
	j xuly1

A:
	move $t1,$a1
	move $a1,$a2
	move $a2,$t1
	jal xuatTIME
	j chuyendoi.end

xuly1:
	beq $t0,'B',xuly2
	jal strcat
	
	la $a1,spc
	jal strcat

	j xuly2

xuly2:	
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

jan:
	la $a1,Jan
	jal strcat
	j xuly3
feb:
	la $a1,Feb
	jal strcat
	j xuly3
mar:
	la $a1,Mar
	jal strcat
	j xuly3
apr:
	la $a1,Apr
	jal strcat
	j xuly3
may:
	la $a1,May
	jal strcat
	j xuly3
jun:
	la $a1,Jun
	jal strcat
	j xuly3
jul:
	la $a1,Jul
	jal strcat
	j xuly3
aug:
	la $a1,Aug
	jal strcat
	j xuly3
sep:
	la $a1,Sep
	jal strcat
	j xuly3
oct:
	la $a1,Oct
	jal strcat
	j xuly3
nov:
	la $a1,Nov
	jal strcat
	j xuly3
dec:
	la $a1,Dec
	jal strcat
	j xuly3

xuly3:
	beq $t0,'C',xuly4

	la $a1,spc
	jal strcat

	move $a1,$a2
	jal strcat

	j xuly4
		
xuly4:
	la $a1,comma
	jal strcat

	move $a1,$a3
	jal strcat
	
	j chuyendoi.end

	chuyendoi.end:
	la $v1,time1
#Cuoi thu tuc
	#Restore thanh ghi
	lw $ra,32($sp)
	lw $t0,36($sp)
	lw $t1,40($sp)

	#xoa stack
	addi $sp,$sp,40
	#Tra ve
	jr $ra
	
#-------------------------

#==== Ham chuc nang 9 =====
xulyFile:
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

	move $a0,$t0
	la $a1,time_1
	la $a2,time_2
	jal tach
	
	#close file
	li $v0,16
	move $a0,$s0
	syscall

	la $a0,time_1
	jal layTime #$a0 = day, $a1 = month, $a2 = year

	la $a1,str
	la $a2,str1
	la $a3,str2
	la $a0 'C'
	
	#jal xuatTIME	
	jal chuyendoiTIME
	

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

tach: #$a0 = chuoi can tach, $a1 = time_1, $a2 = time_2
	addi $sp,$sp,-8
	sw $t0,($sp)
	sw $ra,4($sp)
	
	move $t0,$a2
	li $a3,0
	li $a2,10
	jal strcopy

	addi $a0,$a0,2
	
	move $a1,$t0
	li $a3,11
	li $a2,21
	jal strcopy
	
	lw $t0,($sp)
	lw $ra,4($sp)
	addi $sp,$sp,8
	jr $ra

strcopy: #$a0 la chuoi nguon, $a1 la chuoi dich, $a2 la do dai chuoi can copy
	#$a3 la vi tri bat dau
	addi $sp,$sp,-8
	sw $t0,($sp)
	sw $t1,4($sp)
	move $t1,$a3
strcopy.turn:
	lb $t0,($a0)	
	sb $t0,($a1)	
	addi $a0,$a0,1	
	addi $a1,$a1,1	
	addi $t1,$t1,1	
	bne $t1,$a2,strcopy.turn
	
	sb $zero,0($a1)
	lw $t0,($sp)
	lw $t1,4($sp)
	addi $sp,$sp,8
	jr $ra		

layTime: #$a0 chuoi dau vao
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

	lw $t0,($sp)
	lw $t1,4($sp)
	addi $sp,$sp,8
	jr $ra

chuyenChu: #tham so dau vao $a0 la so, $a1 la chuoi tra ve
	#$a2 = 0 la DD/MM, $a2 = 1 la YYYY
	addi $sp,$sp,-28
	sw $s0,($sp)
	sw $s1,4($sp)
	sw $s2,8($sp)
	sw $t0,12($sp)
	sw $t1,16($sp)
	sw $t2,20($sp)
	sw $ra,24($sp)
	li $s0,10
	li $t0,0
	move $s1,$a0
	move $t1,$a1

	#chuyen doi so sang chu => chuoi nguoc
	run:
	beqz $s1,run.end
	div $s1,$s0
	mfhi $s2
	mflo $s1
	addi $s2,$s2,48
	sb $s2,0($t1)
	addi $t1,$t1,1
	addi $t0,$t0,1
	j run

	run.end:
	la $t2 '0'
	#xu ly them so 0
	beqz $a2,fillDM.run
	beq $a2,1,fillY.run

	fillDM.run:
	beq $t0,2,reverse
	sb $t2,0($t1)
	addi $t1,$t1,1
	addi $t0,$t0,1
	j fillDM.run

	fillY.run:
	beq $t0,4,reverse
	sb $t2,0($t1)
	addi $t1,$t1,1
	addi $t0,$t0,1
	j fillY.run

	reverse:
	#dao chieu chuoi
	la $a0,str3
	subi $t1,$t1,1
	move $a2,$t0

	reverse.run:
	lb $t2,0($t1)
	beqz $t0,reverse.end
	sb $t2,0($a0)
	addi $a0,$a0,1
	subi $t1,$t1,1
	subi $t0,$t0,1
	j reverse.run

	reverse.end:
	sb $zero,0($a0)
	subi $a0,$a0,1
	move $t0,$a2

	continue:
	subi $a0,$a0,1
	subi $t0,$t0,1
	bnez $t0,continue

	move $a1,$t1
	li $a3,0
	addi $a2,$a2,1
	jal strcopy
	move $v0,$a1 #return $v0 la chuoi duoc chuyen tu so	

	lw $s0,($sp)
	lw $s1,4($sp)
	lw $s2,8($sp)
	lw $t0,12($sp)
	lw $t1,16($sp)
	lw $t2,20($sp)
	lw $ra,24($sp)
	addi $sp,$sp,28
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

ghiFile: #tham so dau vao $a3
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

countStr: #tham so $a0
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
	move $v0,$t1 #tra ve $v0 la so luong char
	lw $t0,($sp)
	lw $t1,4($sp)
	addi $sp,$sp,8

	jr $ra

kiemtraTIMEhople:

# Ham kiem tra nam nhuan: $v0 tra ve 1 la nam nhuan, 0 la nam khong nhuan
kiemtraNamNhuan:
	lw $t0, year	# luu year vao $t0

	addi $t1, $zero, 400
	div $t0, $t1
	mfhi $t2	# $t2 = year % 400
	beq $t2, $zero, kiemtraNamNhuan.dung	# nam nhuan chia het cho 400

	addi $t1, $zero, 4
	div $t0, $t1
	mfhi $t2 	# $t2 = year % 4
	bne $t2, $zero, kiemtraNamNhuan.sai	# neu khong chia het cho 4 khong phai nam nhuan

	addi $t1, $zero, 100
	div $t0, $t1
	mfhi $t2 	# $t2 = year % 100
	beq $t2, $zero, kiemtraNamNhuan.thoat	# neu chia het cho 4 va 100 
kiemtraNamNhuan.dung:
	addi $v0, $zero, 1	# $v0 tra ve 1 la nam nhuan
	j kiemtraNamNhuan.thoat
kiemtraNamNhuan.sai:
	add $v0, $zero, 0	# $v0 tra ve 0 la nam khnong nhuan
kiemtraNamNhuan.thoat:
	jr $ra

NgayThuMaytrongTuan:

NgayThuMayketuNgayDauTien:

CanChicuaNam:

KhoangThoiGiangiuaHaiChuoiTIME:

HaiNamNhuangannhat:
