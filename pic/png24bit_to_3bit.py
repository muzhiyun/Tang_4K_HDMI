from PIL import Image
#pip install Pillow
import struct
import sys

png_24bit_file = "640x480_24bit.png"
mi_3bit_file  = (png_24bit_file.split('.')[0])+".mi"
img_3bit_file  = (png_24bit_file.split('.')[0])+"_to3bit.bmp"

img_PIL = Image.open(png_24bit_file)
#mode_list = ['1','L','F','P','RGB','RGBA','CMYK','YCbCr']

img = img_PIL.convert('RGB')
width = img.size[0] 
height = img.size[1]
print('----')
print('width:{} height:{} \npng_24bit_file:{} \nmi_3bit_file:{}\n\n'.format(width,height,png_24bit_file,mi_3bit_file))

mi_file = open(mi_3bit_file, "w")
img_file = open(img_3bit_file, "wb")

mi_file.write( "#File_format=Bin\n")
mi_file.write( "#Address_depth={}\n".format(width*height))
mi_file.write( "#Data_width=3\n")

byte_status = 0  #bit操作状态机
byte0 = 0 # 000-000-00
byte1 = 0 # 0-000-000-0
byte2 = 0 # 00-000-000
for y in range(0, height): #each pixel 
    for x in range(0, width):
        RGB = img.getpixel((x,y))
        #print("24bitRGB=0x%s" %(RGB))  #(0, 33, 149)
        #if(x==1 and y==24):
            #print("pixel[{},{}]:{:x} {:x} {:x}".format(x,y,RGB[0],RGB[1],RGB[2]))
            #exit()
        #b1Bit = (int(RGB[2],10) > 127) ? 1 : 0 #python没有三目运算符~~
        if(int(RGB[0]) > 127):  r1Bit = 1  
        else:                   r1Bit = 0
        if(int(RGB[1]) > 127):  g1Bit = 1  
        else:                   g1Bit = 0
        if(int(RGB[2]) > 127):  b1Bit = 1  
        else:                   b1Bit = 0
        #mi_file.write("{:x}{:x}{:x}\n".format(RGB[0],RGB[1],RGB[2]))
        mi_file.write("{:x}{:x}{:x}\n".format((r1Bit),(g1Bit),(b1Bit)))
        #python也没有switch case
        if (byte_status == 0): #00000000
            byte0 = ( (r1Bit<<2) | (g1Bit<<1) | (b1Bit) )
            byte_status += 1
        elif(byte_status == 1): #00000-111
            #print(" byte0:{:s} type{} len={}".format(bin(byte0),type(byte0),sys.getsizeof(byte0)))
            byte0 = byte0<<3
            #print(" byte0:{:s} type{} len={}".format(bin(byte0),type(byte0),sys.getsizeof(byte0)))
            byte0 |=  ( (r1Bit<<2) | (g1Bit<<1) | (b1Bit) )
            #print("\npixel[{},{}]:{:x} {:x} {:x}".format(x,y,RGB[0],RGB[1],RGB[2]))
            #print("r1Bit:{} g1Bit:{} b1Bit:{}".format(r1Bit,g1Bit,b1Bit))
            #print("byte_status:{} byte0:{:0>8b} byte1:{:0>8b} byte2:{:0>8b}".format(byte_status,byte0,byte1,byte2))
            byte_status += 1
        elif(byte_status == 2): #00111-111
            byte0 = byte0 << 2
            byte0 |= ( (r1Bit<<1) | (g1Bit))
            byte1 = b1Bit
            img_file.write(struct.pack('B', byte0))
            byte_status += 1
        elif(byte_status == 3): #111-111-11 0000000-1
            byte1 = byte1 << 3
            byte1 |=  ( (r1Bit<<2) | (g1Bit<<1) | (b1Bit) )
            byte_status += 1
        elif(byte_status == 4): #111-111-11 00001-111
            byte1 = byte1 << 3
            byte1 |=  ( (r1Bit<<2) | (g1Bit<<1) | (b1Bit) )
            byte_status += 1
        elif(byte_status == 5): #111-111-11 01-111-111
            byte1 = byte1 << 1
            byte1 |=  (r1Bit)
            byte2 |=  ( (g1Bit<<1) | (b1Bit) )
            img_file.write(struct.pack('B', byte1))
            byte_status += 1
        elif(byte_status == 6): #111-111-11 1-111-111-1 00000011
            byte2 = byte2 << 3
            byte2 |=  ( (r1Bit<<2) | (g1Bit<<1) | (b1Bit) )
            byte_status += 1
        elif(byte_status == 7): #111-111-11 1-111-111-1 00011-111
            byte2 = byte2 << 3
            byte2 |=  ( (r1Bit<<2) | (g1Bit<<1) | (b1Bit) )
            img_file.write(struct.pack('B', byte2))
            byte_status = 0
            byte0 = 0 # 000-000-00
            byte1 = 0 # 0-000-000-0
            byte2 = 0 # 00-000-000
            #exit()
        else:                   #111-111-11 1-111-111-1 11-111-111
            print("Wrong state machine\n")
            exit()
                

print('--finish--')
mi_file.close()
img_file.close()