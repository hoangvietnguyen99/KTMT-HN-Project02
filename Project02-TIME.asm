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
	header1: .asciiz "1."
	header2a: .asciiz "\n2A."
	header2b: .asciiz "\n2B."
	header2c: .asciiz "\n2C."
	header3: .asciiz "\n3."
	header4: .asciiz "\n4."
	header5: .asciiz "\n5."
	header6: .asciiz "\n6."
	header7: .asciiz "\n7."
	header8: .asciiz "\n8."
	NamThuong: .asciiz " La Nam Thuong"
	NamNhuan: .asciiz " La Nam Nhuan"
	can1: .asciiz "Giap"
	can2: .asciiz "At"
	can3: .asciiz "Binh"
	can4: .asciiz "Dinh"
	can5: .asciiz "Mau"
	can6: .asciiz "Ky"
	can7: .asciiz "Canh"
	can8: .asciiz "Tan"
	can9: .asciiz "Nham"
	can10: .asciiz "Quy"
	chi1: .asciiz " Ty"
	chi2: .asciiz " Suu"
	chi3: .asciiz " Dan"
	chi4: .asciiz " Meo"
	chi5: .asciiz " Thin"
	chi6: .asciiz " Ty"
	chi7: .asciiz " Ngo"
	chi8: .asciiz " Mui"
	chi9: .asciiz " Than"
	chi10: .asciiz " Dau"
	chi11: .asciiz " Tat"
	chi12: .asciiz " Hoi"
	mess6: .asciiz " la nam "

	#Cac bien luu tru
	day: .word 0 #bien luu ngay (int)
	month: .word 0 #bien luu thang (int)
	year: .word 0 #bien luu nam (int)
	str: .space 3 #chuoi luu ngay
	str1: .space 3 #chuoi luu thang
	str2: .space 10	#chuoi luu nam
	str3: .space 10 #chuoi luu tam
	Buffer: .space 50 #bien luu chuoi doc tu file
	time1: .space 50 #chuoi luu time_1
	time2: .space 50 #chuoi luu time_2
	time_1: .space 50 #chuoi luu time_1
	time_2: .space 50 #chuoi luu time_2
	CanChi :.space 50 #chuoi luu can chi
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

	beq $t0,1,func1
	beq $t0,2,func2
	beq $t0,3,func3
	#beq $t0,4,func4
	#beq $t0,5,func5
	beq $t0,6,func6
	#beq $t0,7,func7
	#beq $t0,8,func8
func1:
	la $a1,str
	la $a2,str1
	la $a3,str2
	jal xuatTIME

	li $v0,4
	la $a0,ketqua
	syscall
	
	li $v0,4
	move $a0,$v1
	syscall
	j ketthuc
	
func2:
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
	move $a0,$v1
	syscall
	j ketthuc

func3:
	la $a0,str2
	jal kiemtraNamNhuan
	move $a0,$v0
	beqz $a0,nThuong
	j nNhuan

	nThuong:
	li $v0,4
	la $a0,NamThuong
	syscall

	nNhuan:
	li $v0,4
	la $a0,NamNhuan
	syscall
	j func3.end

	func3.end:
	j ketthuc

func6:
	la $a0,str2
	jal CanChicuaNam

	li $v0,4
	move $a0,$v1
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
strcat: #tham so dau vao $a0 chuoi dich, $a1 chuoi nguon
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

#===== Ham chuc nang 02 =====
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

#==== Ham chuc nang 03 =====
# Ham kiem tra nam nhuan: $v0 tra ve 1 la nam nhuan, 0 la nam khong nhuan
kiemtraNamNhuan:
	addi $sp,$sp,-16
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	
	jal chuyenSo
	move $t0,$v0

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
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	addi $sp,$sp,16
	jr $ra

#--------------------------

#==== Ham chuc nang 6 =====
CanChicuaNam:
	addi $sp,$sp,-4
	sw $ra,0($sp)
	
	jal chuyenSo
	move $s0,$v0

	li $s1,10
	
	addi $s0,$s0,6 # year + 6
	div $s0,$s1
	mfhi $s2 # (year + 6) %10

	la $a0,CanChi
	beq $s2,0,giap
	beq $s2,1,at
	beq $s2,2,binh
	beq $s2,3,dinh
	beq $s2,4,mau
	beq $s2,5,ky
	beq $s2,6,canh
	beq $s2,7,tan
	beq $s2,8,nham
	beq $s2,9,quy
	giap:
	la $a1,can1
	jal strcat
	j Can.end
	
	at:
	la $a1,can2
	jal strcat
	j Can.end
	
	binh:
	la $a1,can3
	jal strcat
	j Can.end

	dinh:
	la $a1,can4
	jal strcat
	j Can.end

	mau:
	la $a1,can5
	jal strcat
	j Can.end

	ky:
	la $a1,can6
	jal strcat
	j Can.end

	canh:
	la $a1,can7
	jal strcat
	j Can.end

	tan:
	la $a1,can8
	jal strcat
	j Can.end

	nham:
	la $a1,can9
	jal strcat
	j Can.end

	quy:
	la $a1,can10
	jal strcat
	j Can.end
	
	Can.end:
	move $s0,$v0
	li $s1,12
	
	addi $s0,$s0,8 # year + 8
	div $s0,$s1
	mfhi $s2 # (year + 8) %12

	beq $s2,0,Chi1
	beq $s2,1,Chi2
	beq $s2,2,Chi3
	beq $s2,3,Chi4
	beq $s2,4,Chi5
	beq $s2,5,Chi6
	beq $s2,6,Chi7
	beq $s2,7,Chi8
	beq $s2,8,Chi9
	beq $s2,9,Chi10
	beq $s2,10,Chi11
	beq $s2,11,Chi12
	
	Chi1:
	la $a1,chi1
	jal strcat
	j Chi.end

	Chi2:
	la $a1,chi2
	jal strcat
	j Chi.end
	
	Chi3:
	la $a1,chi3
	jal strcat
	j Chi.end

	Chi4:
	la $a1,chi4
	jal strcat
	j Chi.end

	Chi5:
	la $a1,chi5
	jal strcat
	j Chi.end

	Chi6:
	la $a1,chi6
	jal strcat
	j Chi.end

	Chi7:
	la $a1,chi7
	jal strcat
	j Chi.end

	Chi8:
	la $a1,chi8
	jal strcat
	j Chi.end

	Chi9:
	la $a1,chi9
	jal strcat
	j Chi.end

	Chi10:
	la $a1,chi10
	jal strcat
	j Chi.end

	Chi11:
	la $a1,chi11
	jal strcat
	j Chi.end

	Chi12:
	la $a1,chi12
	jal strcat
	j Chi.end

	Chi.end:
	la $v1,CanChi #tra ve $v1
	
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra

#--------------------------

#==== Ham chuc nang 9 =====
xulyFile:
	addi $sp,$sp,-68
	sw $ra,44($sp)
	sw $s7,48($sp)
	sw $t0,52($sp)
	sw $t1,56($sp)
	sw $t2,60($sp)
	sw $t3,64($sp)
#than thu tuc

	#open file
	li $v0,13 
	la $a0,Input
	li $a1,0
	syscall
	move $s7,$v0
	
	#read
	li $v0,14
	move $a0,$s7
	la $a1,Buffer
	la $a2,50
	syscall
	
	#tien hanh tach chuoi
	la $t0,Buffer

	move $a0,$t0
	la $a1,time_1 ## chuoi TIME_1
	la $a2,time_2 ## chuoi TIME_2
	jal tach
	
	#close file
	li $v0,16
	move $a0,$s7
	syscall

#---------

	#open file de ghi
	li $v0,13 
	la $a0,Output
	li $a1,1
	syscall
	move $s7,$v0 #luu lai descriptor tra ve trong $v0	

	la $a0,time_1
	jal layTime
	
	la $a0,header1
	jal countStr
	move $a2,$v0
	
	#write 1
	move $a0,$s7
	li $v0,15
	la $a1,header1
	syscall

	la $a1,str
	la $a2,str1
	la $a3,str2
	
	jal xuatTIME

	move $a0,$v1
	jal countStr
	move $a2,$v0

	#write 2
	move $a0,$s7
	li $v0,15
	move $a1,$v1
	syscall

	la $a0,header2a
	jal countStr
	move $a2,$v0

	#write 4
	move $a0,$s7
	li $v0,15
	la $a1,header2a
	syscall

	la $a1,str
	la $a2,str1
	la $a3,str2
	la $a0,'A'
	jal chuyendoiTIME

	move $a0,$v1
	jal countStr
	move $a2,$v0

	#write 5
	move $a0,$s7
	li $v0,15
	move $a1,$v1
	syscall
	
	la $a0,header2b
	jal countStr
	move $a2,$v0

	#write 6
	move $a0,$s7
	li $v0,15
	la $a1,header2b
	syscall

	la $a1,str
	la $a2,str1
	la $a3,str2
	la $a0,'B'
	jal chuyendoiTIME

	move $a0,$v1
	jal countStr
	move $a2,$v0

	#write 7
	move $a0,$s7
	li $v0,15
	move $a1,$v1
	syscall

	la $a0,header2c
	jal countStr
	move $a2,$v0

	#write 8
	move $a0,$s7
	li $v0,15
	la $a1,header2c
	syscall

	la $a1,str
	la $a2,str1
	la $a3,str2
	la $a0,'C'
	jal chuyendoiTIME

	move $a0,$v1
	jal countStr
	move $a2,$v0

	#write 9
	move $a0,$s7
	li $v0,15
	move $a1,$v1
	syscall

	la $a0,header3
	jal countStr
	move $a2,$v0
	
	#write 10
	move $a0,$s7
	li $v0,15
	la $a1,header3
	syscall

	la $a0,str2
	jal countStr
	move $a2,$v0

	#write 11
	move $a0,$s7
	li $v0,15
	la $a1,str2
	syscall

	la $a0,str2
	jal kiemtraNamNhuan
	beqz $v0,laNamThuong
	j laNamNhuan

	laNamThuong:
	la $a0,NamThuong
	jal countStr
	move $a2,$v0

	#write 12
	move $a0,$s7
	li $v0,15
	la $a1,NamThuong
	syscall
	j  write.cont

	laNamNhuan:
	la $a0,NamNhuan
	jal countStr
	move $a2,$v0
	
	#write 13
	move $a0,$s7
	li $v0,15
	la $a1,NamNhuan
	syscall
	j  write.cont

	write.cont:
	la $a0,header6
	jal countStr
	move $a2,$v0
	
	#write header 6
	move $a0,$s7
	li $v0,15
	la $a1,header6
	syscall

	la $a0,str2
	jal countStr
	move $a2,$v0
	
	move $a0,$s7
	li $v0,15
	la $a1,str2
	syscall

	la $a0,mess6
	jal countStr
	move $a2,$v0
	
	move $a0,$s7
	li $v0,15
	la $a1,mess6
	syscall

	#In ket qua chuc nang 6
	la $a0,str2
	jal CanChicuaNam
	move $a0,$v1

	jal countStr
	move $a2,$v0
	
	move $a0,$s7
	li $v0,15
	move $a1,$v1
	syscall
	

	#close file
	li $v0,16
	move $a0,$s7
	syscall

#---------

	lw $ra,44($sp)
	lw $s7,48($sp)
	lw $t0,52($sp)
	lw $t1,56($sp)
	lw $t2,60($sp)
	lw $t3,64($sp)
	addi $sp,$sp,68
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
	#$a2 = 0 la DD/MM, $a2 = 1 la YYYY, $a2 khac la loai khac
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
	beqz $a2,fillDM.run #TH la ngay hoac thang
	beq $a2,1,fillY.run #TH la nam
	j reverse #TH khac

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

NgayThuMaytrongTuan:

# ham tinh ngay ke tu 1/1/1 tra ve ket qua so ngay trong $v1
NgayThuMayketuNgayDauTien:

	lw $a0, day
	lw $a1, month
	lw $a2, year
	
	addi $t0, $zero, 0	# luu ket qua
	sub $a2, $a2, 1	# tru nam cho 1 de biet so nam da qua
	
	# tinh so nam nhuan da qua bang cach (nam / 4) - (nam / 100) + (nam / 400)
	div $a2, 4
	mflo $t1
	addi $t0,$t1,0
	
	div $a2, 100
	mflo $t1
	sub $t0,$t0,$t1
	
	div $a2, 400
	mflo $t1
	addi $t0,$t1,0
	
	sub $t1,$a2,$t0 # so nam khong nhuan
	
	mul $t0,$t0,366	# so nam nhuan nhan cho 366 ngay
	
	mul $t1,$t1,365
	
	add $t0,$t0,$t1
	
	# cong thang du
	
	bgt $a1,1,cong31
	bgt $a1,2,congThang2
	bgt $a1,3,cong31
	bgt $a1,4,cong30
	bgt $a1,5,cong31
	bgt $a1,6,cong30
	bgt $a1,7,cong31
	bgt $a1,8,cong31
	bgt $a1,9,cong30
	bgt $a1,10,cong31
	bgt $a1,11,cong30
	bgt $a1,12,cong31
	
	# cong ngay du
	add $t0,$t0,$a0
	
	move $v1,$t0
	
	jr $ra
	
	cong31:
		addi $t0,$t0,31
	cong30:
		addi $t0,$t0,30
	congThang2:
		lw $a0,year
		li $a1,1
		jal kiemtraNamNhuan
		#luu lai ket qua trong $v0
		
		

KhoangThoiGiangiuaHaiChuoiTIME:

HaiNamNhuangannhat:
