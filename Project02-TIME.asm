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
	thoatChuongTrinh: .asciiz "0. Thoat chuong trinh.\n"
	line: .asciiz "---------------------------------------------------------\n"
	luachon: .asciiz "* Lua chon: "
	ketqua: .asciiz "* Ket qua: "
	nhapsai: .asciiz "Nhap sai!\n"
	
	#Cac bien luu tru
	day: .word 0
	month: .word 0
	year: .word 0
.text
xuatMenu:
	#Xuat menu
	li $v0,4
	la $a0,menuHeader
	syscall
	la $a0,menu1
	syscall
	la $a0,menu2
	syscall
	la $a0,menu2a
	syscall
	la $a0,menu2b
	syscall
	la $a0,menu2c
	syscall
	la $a0,menu3
	syscall
	la $a0,menu4
	syscall
	la $a0,menu5
	syscall
	la $a0,menu6
	syscall
	la $a0,menu7
	syscall
	la $a0,menu8
	syscall
	la $a0,menu9
	syscall
	la $a0,thoatChuongTrinh
	syscall
	la $a0,line
	syscall
	la $a0,luachon
	syscall
	
	#Nhap lua chon
	li $v0,5
	syscall
	
	#Luu lua chon vao $t0
	move $t0, $v0
	
	beq $t0,1
	beq $t0,2
	beq $t0,3
	beq $t0,4
	beq $t0,5
	beq $t0,6
	beq $t0,7
	beq $t0,8
	beq $t0,9
	beq $t0,0,ketthucChuongTrinh
	j nhapsai
	
nhapChuoiTIME:
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
	
kiemtraChuoiTIMEhople:

xuatChuoiTIME:

chuyendoiChuoiTIME:

kiemtraNamNhuan:

NgayThuMaytrongTuan:

NgayThuMayketuNgayDauTien:

CanChicuaNam:

KhoangThoiGiangiuaHaiChuoiTIME:

HaiNamNhuangannhat:

xulyFile:

nhapsai:
	li $v0,4
	la $a0,nhapsai
	syscall
	j xuatMenu

ketthucChuongTrinh: