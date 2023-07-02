# Hardware Setup

## 热床

热床使用独立电源驱动，控制板仅仅提供控制信号，对控制板无功率要求。

热床: MK3圆形热床铝基板，直径220mm ，厚3mm; 支持12V/24V供电，

热床电源: 明纬nes-350-24，350W 24V 14.6A

热床功率扩展模块：最大电流25A

热床热敏电阻：NTC 100KΩ, B-value: 3950K

## 热端

## 控制板

### Arduino mega 2560 + RAMPS 1.4

#### 供电

RAMPS 1.4 为12V供电，有两个电源输入，分别为 11A 和 5A，各自串接可复位保险。

- 11A用于热床（D8端口）的供电
- 5A用于其他部分的供电
  - 热端和步进电机，12V供电
  - 送往Arduino，利用Arduino的稳压电路得到 5V 供电
    - 所有电子部分，包括传感器都是5V供电
    - 舵机可以用独立5V外接供电，也可以利用Arduino稳压的5V输出。如果要用Arduino给舵机供电，需要将VCC与5V跳线（位于reset按钮旁边）短接。

由于我的热床有独立供电，并不依赖RAMPS提供电流，可以将11A和5A输入在保险之前短接在一起，这样电源输入随便接其中一组端子就可以了。

#### TMC步进驱动UART支持

RAMPS缺省没有支持步进驱动的UART模式，但可以自己接线。

RAMPS步进驱动座下的跳线有3个，分别对应MS1、MS2、MS3，短接为上拉高电平。其中MS3对应着TMC的PDN_UART引脚。

UART模式下，只需要PDN_UART、DIR、STEP三个控制信号，其中DIR和STEP与standalone模式接线相同，因此只需要将驱动模块的PDN_UART引出，接到一对TX/RX端口，直接连接RX，通过1K电阻连接TX。而三个跳线都不接（断开）。

如果TMC驱动模块没有单独的UART引脚，就需要焊接引线出来，分出两根线，其中一根串接1K电阻，分别插入RX/TX。乐积的TMC2225模块已经有额外的TX/RX焊盘孔，并已经接好电阻，焊上针脚插杜邦线就可以。

在RAMPS板上，UART引线可以接到AUX-2和AUX-1的digit引脚，对应在firmware中配置pin编号就可以了。

另外，根据 Klipper 文档，只需要将 PDN_UART 接到一个 pin，而无需通过加电阻接 TX/RX 两个 pin。

> Klipper never uses "gpio hardware irqs" - see: <https://www.klipper3d.org/FAQ.html#do-i-have-to-wire-my-device-to-a-specific-type-of-micro-controller-pin>
>
> Klipper can use any regular GPIO pin for the UART wire. Only one wire is needed (although you can also define both RX and TX if you wish).

## 电源

台达12V10A

## 步进电机

1.8°步进

## 运动结构

效应器：

- 注塑（人人三维）14g
- 铝（启庞）34g

除效应器外，打印头（包括E3D v6，风扇，马蹄铁等）总重约90g

螺丝螺母 用注塑效应器时共19g，用铝时 10g

泰坦挤出机 289g

- 同步带：2GT-6，宽 6mm，齿距 2mm；3 轴共 4 米
- 同步带轮：16-2GT-6-P5，16 齿，内孔 5mm

## 喷嘴清洁

产品名称：SG90 9g 塑料齿数字舵机

产品净重: 9g

产品尺寸: 23x12.2x29mm

产品扭矩: 1.5kg/cm

反应速度: 0.3sec/60degree

工作电压: 4.2V-6V

使用温度: 0-55度

动作死区: 10us

齿轮介质: 塑料

工作模式: 模拟
